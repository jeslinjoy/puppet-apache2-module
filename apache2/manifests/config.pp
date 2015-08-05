class apache2::config inherits apache2 {
         File {
                require => [Class['apache2::users'],Class['apache2::groups']],
                owner => $apache2::user,
                group => $apache2::group,
                mode  => $apache2::mode,
             }
                 
            file {['/var/www/html','/var/www/html/site']:
                   require => [Class['apache2::users'],Class['apache2::groups']],
                   ensure => 'directory',
                   owner => $apache2::user,
                   group => $apache2::group,
                   mode  => $apache2::mode,
                  before => File['index.html'],
               }

       file {'index.html':
              require => [Class['apache2::users'],Class['apache2::groups']],
              path => '/var/www/html/site/index.html',
              ensure => 'present',
              owner => $apache2::user,
              group => $apache2::group,
              mode =>  $apache2::mode,
              source => 'puppet:///modules/apache2/index.html',            
            }

            exec {'enablevhost':
                   path => [ '/bin','/usr/bin','/usr/sbin'],
                   command => 'a2ensite site.com.conf',
                   notify  => Service['apache2'],
                   subscribe => File['site.com.conf'],
                 }



         file {'site.com.conf':
                require => Class['apache2::install'],
                path => '/etc/apache2/sites-available/site.com.conf',
                #ensure => present,
                source =>  'puppet:///modules/apache2/site.com.conf',
               notify => Service['apache2'],
              }
            
            
}
    

