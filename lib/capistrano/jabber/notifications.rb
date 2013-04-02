# -*- encoding : utf-8 -*-

require 'xmpp4r'
require 'xmpp4r/roster/helper/roster'
require "capistrano/jabber/notifications/version"

module Capistrano
  module Jabber
    module Notifications

      class << self

        attr_accessor :options

        def deploy_started(stage)
          send_jabber_message("cap deploy #{stage} by :username started at #{Time.now}")
        end

        def deploy_completed(stage)
          send_jabber_message("cap deploy #{stage} by :username completed at #{Time.now}")
        end

        def rollback_started(stage)
          send_jabber_message("cap deploy:rollback #{stage} by :username started at #{Time.now}")
        end

        def rollback_completed(stage)
          send_jabber_message("cap deploy:rollback #{stage} by :username completed at #{Time.now}")
        end

        private

        def send_jabber_message(msg)
          msg.gsub!(':username', username) if msg[':username']

          client = ::Jabber::Client.new(options[:uid])
          client.connect(options[:server])
          client.auth(options[:password])
          notification_group = options[:group]

          roster = ::Jabber::Roster::Helper.new(client)

          mainthread = Thread.current
          roster.add_query_callback { |iq| mainthread.wakeup }
          Thread.stop

          roster.find_by_group(notification_group).each {|item|
            client.send(item.jid)
            m = ::Jabber::Message.new(item.jid, msg).set_type(:normal).set_id('1').set_subject('hi')
            client.send(m)
          }

          client.close
          true
        end

        def username
          @username ||= [`whoami`, `hostname`].map(&:strip).join('@')
        end
      end
    end
  end
end


Capistrano::Configuration.instance(:must_exist).load do

  namespace :deploy do
    namespace :jabber do
      %w(deploy_started deploy_completed rollback_started rollback_completed).each do |m|
        task m.to_sym do
          Capistrano::Jabber::Notifications.options = {
            uid:      fetch(:jabber_uid),
            server:   fetch(:jabber_server),
            password: fetch(:jabber_password),
            group:    fetch(:jabber_group)
          }
          Capistrano::Jabber::Notifications.send(m, fetch(:stage))
        end
      end
    end
  end

  before 'deploy',          'deploy:jabber:deploy_started'
  after  'deploy',          'deploy:jabber:deploy_completed'
  before 'deploy:rollback', 'deploy:jabber:rollback_started'
  after  'deploy:rollback', 'deploy:jabber:rollback_completed'
end
