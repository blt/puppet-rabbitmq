class rabbitmq {
  include rabbitmq::config, rabbitmq::package, rabbitmq::service

  rabbitmq::resource::user { 'guest':
    ensure => absent,
  }
  rabbitmq::resource::vhost { '/':
    ensure => absent,
  }
}
