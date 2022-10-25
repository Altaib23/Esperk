<?php

include "../connect.php";

$sparaname       = filterRequest("sparaname");
$sparaprice     = filterRequest("sparaprice");
$sparaversion      = filterRequest("sparaversion");

$imagename = imageUpload("file");

if ($imagename != 'fail') {
    
    $stmt = $con->prepare("INSERT INTO `spara_part`
    (`spara_name` , `spara_price` , `spara_version` , `spara_image`)
  VALUES (? , ?  , ? , ?)
  ");

    $stmt->execute(array($sparaname , $sparaprice , $sparaversion , $imagename));

    $count = $stmt->rowCount();

    if ($count > 0) {
        echo json_encode(array("status" => "success"));
    } else {
        echo json_encode(array("status" => "fail"));
    }
} else {
    echo json_encode(array("status" => "fail"));
}
