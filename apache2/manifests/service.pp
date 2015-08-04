class apache2::service {
                  
          service {'apache2':
                     enable => true,
                     ensure => running,
                  }
}
                     
