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
              content => ' <html>
                           <head> <title>test site</title></head>
                           <body><h1>Hi ..... site.com</h1></body>
                           </html>',            
            }

         file {'site.com.conf':
                require => Package['apache2'],
                path => '/etc/apache2/sites-available/site.com.conf',
                #ensure => present,
                content => '<VirtualHost *:80>
                ServerAdmin webmaster@site
                Servername  site
                DocumentRoot /var/www/html/site
                ErrorLog ${APACHE_LOG_DIR}/error.log
                CustomLog ${APACHE_LOG_DIR}/access.log combined
                </VirtualHost>',
               notify => Service['apache2'],
              }
            exec {'enablevhost':
                   path => [ '/bin','/usr/bin','/usr/sbin'],
                   command => 'a2ensite site.com.conf',
                   notify  => Service['apache2'],
                 }
            
}
    

