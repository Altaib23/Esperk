<?php 
 
  include "../connect.php" ; 
 
  $admin_email     = filterRequest("admin_email");

  $admin_password  = filterRequest("admin_password");

  $stmt = $con->prepare("SELECT * FROM admini WHERE `admin_password` = ? AND admin_email = ? "); 

  $stmt->execute(array( $admin_password , $admin_email )) ;

  $data = $stmt->fetch(PDO::FETCH_ASSOC) ; 

  $count = $stmt->rowCount() ; 

  if ($count > 0) {

    echo json_encode(array("status" => "success" , "data" => $data)) ; 

  }else {

    echo json_encode(array("status" => "fail")) ; 

  }
