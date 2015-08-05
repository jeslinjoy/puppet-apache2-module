class apache2::params {
  
  
   
  $mode = 0744
if $::hostname == 'agent2' {
   $user = 'dilshad'


  }  
if $::hostname == 'agent' {
   $user = 'jain'
}

}
