class rabbitmq::package {
  case $operatingsystem {
    'debian' : {
      apt::key { 'rabbitmq':
        source => 'http://www.rabbitmq.com/rabbitmq-signing-key-public.asc',
        before => Apt::Source['rabbitmq'],
      }
      apt::source { 'rabbitmq':
        source => 'deb http://www.rabbitmq.com/debian/ testing main',
        before => Package['rabbitmq-server'],
      }
    }
    default: {}
  }

  package { 'rabbitmq-server':
    ensure => present,
  }
}
