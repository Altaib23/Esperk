<?php 
 
 include "../connect.php" ; 

  $user_name  = filterRequest("user_name");
  $user_email     = filterRequest("user_email");
  $user_phone	  = filterRequest("user_phone");
  $user_password	  = filterRequest("user_password");

  $stmt = $con->prepare("INSERT INTO `users`(`user_name`, `user_email`, `user_phone`, `user_password`) 
                         VALUES (?  , ? , ? ,?)
                        ") ; 

  $stmt->execute(array($user_name , $user_email , $user_phone, $user_password)) ;

  $count = $stmt->rowCount() ; 

  if ($count > 0) {
    echo json_encode(array("status" => "success")) ; 
  }else {
    echo json_encode(array("status" => "fail")) ; 
  }
