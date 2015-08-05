class apache2::users inherits apache2{

   
     user {$apache2::user:
            ensure => present,
         }
  }
