class rabbitmq::config {
  file { 'rabbitmq_conf':
    path    => '/etc/rabbitmq/rabbitmq.config',
    content => template('rabbitmq/rabbitmq.config.erb'),
    owner   => root,
    group   => root,
    require => Class['rabbitmq::package'],
  }
}
