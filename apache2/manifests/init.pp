
class apache2( 
    $user = $user,  
    $group = 'qburst',
    $mode = 0744, 
  ) inherits apache2::params {


    class {'apache2::users':} 
    class {'apache2::groups':}  
    class {'apache2::install':} 
    class {'apache2::config':} 
    class {'apache2::service':}
   
              
}              
