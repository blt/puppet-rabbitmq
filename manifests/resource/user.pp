## See http://www.rabbitmq.com/man/rabbitmqctl.1.man.html and search for
## commands listed here.
define rabbitmq::resource::user($password='', $ensure=present) {
  case $ensure {
    present: {
      case $password {
        '': { fail "'password' must be set" }
        default: {} # do nothing
      }
      exec { "create rabbitmq user $title" :
        command => "rabbitmqctl add_user $title $password",
        unless  => "rabbitmqctl list_users | awk '{ print \$1 }' | grep '^${title}$'",
      }
    }
    absent: {
      exec { "destroy rabbitmq user $title":
        command => "rabbitmqctl delete_user $title",
        onlyif  => "rabbitmqctl list_users | awk '{ print \$1 }' | grep '^${title}$'",
      }
    }
    default: {
      fail "(present|absent) not '$ensure'"
    }
  }
}

define rabbitmq::resource::user::permissions($vhost='/', $conf='.*', $write='.*', $read='.*', $ensure=present) {
  case $ensure {
    present: {
      exec { "set permissions for user $title for vhost $vhost":
        command => "rabbitmqctl set_permissions -p $vhost $title '$conf' '$write' '$read'",
        unless  => "rabbitmqctl list_permissions -p $vhost | awk '{ print \$1 }' | grep '^${name}$'",
      }
    }
    absent: {
      exec { "clear permissions for user $title for vhost $vhost":
        command => "rabbitmqctl clear_permissions -p $vhost $title",
        onlyif  => "rabbitmqctl list_users | awk '{ print \$1 }' | grep '^${name}$'",
      }
    }
    default: {
      fail "(present|absent) not '$ensure'"
    }
  }
}

