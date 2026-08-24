class webserver {
  package { 'nginx':
    ensure => present,
  }

  file { '/var/www/myapp':
    ensure => directory,
    owner  => 'www-data',
    group  => 'www-data',
    mode   => '0755',
  }

  file { '/var/www/myapp/index.html':
    ensure  => file,
    source  => 'puppet:///modules/webserver/index.html',
    owner   => 'www-data',
    group   => 'www-data',
    mode    => '0644',
    require => File['/var/www/myapp'],
    notify  => Service['nginx'],
  }

  file { '/etc/nginx/sites-available/myapp.conf':
    ensure  => file,
    content => template('webserver/nginx.conf.erb'),
    require => Package['nginx'],
    notify  => Service['nginx'],
  }

  file { '/etc/nginx/sites-enabled/myapp.conf':
    ensure  => link,
    target  => '/etc/nginx/sites-available/myapp.conf',
    require => File['/etc/nginx/sites-available/myapp.conf'],
    notify  => Service['nginx'],
  }

  service { 'nginx':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    require    => Package['nginx'],
  }
}
