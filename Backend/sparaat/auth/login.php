<?php 
 
  include "../connect.php" ; 
 
  $user_email     = filterRequest("user_email");

  $user_password  = filterRequest("user_password");

  $stmt = $con->prepare("SELECT * FROM users WHERE `user_email` = ? AND user_password = ? "); 

  $stmt->execute(array( $user_email , $user_password )) ;

  $data = $stmt->fetch(PDO::FETCH_ASSOC) ; 

  $count = $stmt->rowCount() ; 

  if ($count > 0) {

    echo json_encode(array("status" => "success" , "data" => $data)) ; 

  }else {

    echo json_encode(array("status" => "fail")) ; 

  }
