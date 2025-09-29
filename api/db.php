<?php
$host = "localhost";
$user = "root"; // ค่า default XAMPP
$pass = "";     // ค่า default XAMPP
$dbname = "lab10_webapi";

$conn = new mysqli($host, $user, $pass, $dbname);

if ($conn->connect_error) {
    die(json_encode(["error" => "Connection failed: " . $conn->connect_error]));
}

$conn->set_charset("utf8mb4");
?>