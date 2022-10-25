<?php

include "../connect.php";

$spara_id     = filterRequest("spara_id"); 
$imagename  = filterRequest("imagename"); 

$stmt = $con->prepare("DELETE FROM `spara_part` WHERE spara_id  = ? ");

$stmt->execute(array($spara_id));

$count = $stmt->rowCount();

if ($count > 0) {
    deleteFile("../upload" , $imagename) ; 
    echo json_encode(array("status" => "success"));
} else {
    echo json_encode(array("status" => "fail"));
}
