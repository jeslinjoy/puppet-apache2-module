class apache2::groups inherits apache2 {
            
              group {$apache2::group:
                      ensure => present,
                    }
    }              
