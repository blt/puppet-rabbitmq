define rabbitmq::resource::vhost ($ensure=present) {
  case $ensure {
    present: {
      exec { "create rabbitmq vhost ${name}":
        command => "rabbitmqctl add_vhost ${name}",
        unless  => "rabbitmqctl list_vhosts | grep '^${name}$'",
      }
    }
    absent: {
      exec { "remove rabbitmq vhost $name":
        command => "rabbitmqctl delete_vhost $name",
        onlyif  => "rabbitmqctl list_vhosts | grep '^${name}$'",
      }
    }
    default: {
      fail "(present|absent) not '$ensure'"
    }
  }
}
