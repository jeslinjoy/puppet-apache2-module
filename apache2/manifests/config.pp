class apache2::config {
         File {
                owner => root,
                group => root,
                mode  => 644,
             }
                 
            file {['/var/www/html','/var/www/html/site']:
                   ensure => 'directory',
                   owner => 'root',
                   group => 'root',
                   mode  => 750,
                  before => File['index.html'],
               }

       file {'index.html':
              path => '/var/www/html/site/index.html',
              ensure => 'present',
              owner => 'root',
              group => 'root',
              mode =>  750,
              source => 'puppet:///modules/apache2/index.html',            
            }

            exec {'enablevhost':
                   path => [ '/bin','/usr/bin','/usr/sbin'],
                   command => 'a2ensite site.com.conf',
                   notify  => Service['apache2'],
                 }



         file {'site.com.conf':
                require => Package['apache2'],
                path => '/etc/apache2/sites-available/site.com.conf',
                #ensure => present,
                source =>  'puppet:///modules/apache2/site.com.conf',
               notify => Service['apache2'],
              }
            
            
}
    

