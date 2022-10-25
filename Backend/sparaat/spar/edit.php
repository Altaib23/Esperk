<?php

include "../connect.php";

$spara_id         =   filterRequest("spara_id");
$spara_name          =   filterRequest("spara_name");
$spara_price        =   filterRequest("spara_price");
$spara_version        =   filterRequest("spara_version");
$imagename      =   filterRequest("imagename");

if (isset($_FILES['file'])){
    
    deleteFile("../upload" , $imagename) ;
    $imagename = imageUpload("file");
   

} 


$stmt = $con->prepare("UPDATE `spara_part` SET 
 `spara_name`=?,`spara_price`=?,`spara_version`=? , spara_image = ?   WHERE spara_id = ?
");
$stmt->execute(array($spara_name, $spara_price, $spara_version, $imagename , $spara_id));
$count = $stmt->rowCount();

if ($count > 0) {
    echo json_encode(array("status" => "success"));
} else {
    echo json_encode(array("status" => "fail"));
}
