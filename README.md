# Capistrano::Jabber::Notifications

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'capistrano-jabber-notifications'

or

    gem 'capistrano-jabber-notifications', :github => "netbrick/capistrano-jabber-notifications"

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-jabber-notifications

## Usage

Add into capistrano configuration:

    require 'capistrano/jabber/notifications'
    
    set :jabber_uid, 'capistrano@jabbim.cz'
    set :jabber_server, 'jabbim.cz'
    set :jabber_password, 'superSecretPassword'
    set :jabber_group, []
    set :jabber_members, ["developer0@netbrick.cz", "developer1@netbrick.cz"]


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
