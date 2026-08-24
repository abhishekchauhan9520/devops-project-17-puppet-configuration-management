class users {
  user { 'deploy':
    ensure     => present,
    managehome => true,
    home       => '/home/deploy',
    shell      => '/bin/bash',
  }
}
