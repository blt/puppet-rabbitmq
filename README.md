# Puppet module for the control of RabbitMQ

## Installation

Include this project as a submodule to your own, something like:

    $ git submodule add git@github.com/blt/puppet-rabbitmq.git

If you're on Debian you'll need to install
[puppet-apt](git://github.com/blt/puppet-apt.git). Have a look at
`manifests/config.pp`. Rather than squeeze you through my thoughts on how
RabbitMQ should be configured, I've assumed that `rabbitmq/rabbitmq.config.erb`
will be hosted as a
[static file](http://docs.puppetlabs.com/guides/file_serving.html#serving-files-from-custom-mount-points).

If this proves to be an onerous requirement--or you end up writing a lot of
configuration _around_ this module--please take out an issue.

## Usage

In your AMQP hosting node definitions do

    include rabbitmq

Defaults are stressed over configuration for simplicity's sake. If that rubs you
badly, have a look at
[puppetlabs-rabbitmq](https://github.com/puppetlabs/puppetlabs-rabbitmq). Specifically:

* The server runs on a single host, no clustering.
* No other high-availability steps are made.
* The guest account is entirely removed, meaning you must set your own users.

I will _gladly_ accept patches that alter these assumptions, especially the lack
of high-availability support.

Several resources exist:

 * rabbitmq::resource::vhost -- Set or destroy rabbitmq vhosts
 * rabbitmq::resource::user -- Set or destroy rabbitmq users
 * rabbitmq::resource::user::permissions -- Set or reset rabbitmq user permissions

For instance, create the vhost 'logs' and user 'logger':

    rabbitmq::resource::vhost { '/logs':
      ensure => present,
    }

    rabbitmq::resource::user { 'logger':
      ensure => present,
      before => Rabbitmq::Resource::User::Permissions['logger'],
    }
    rabbitmq::resource::user::permissions { 'logger':
      ensure => present,
      vhost  => '/logs',
    }
