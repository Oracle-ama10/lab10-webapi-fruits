<?php
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type"); // อนุญาต Content-Type สำหรับ POST/PUT

require_once "db.php";

$method = $_SERVER['REQUEST_METHOD'];
// ใช้ $_SERVER['PATH_INFO'] ในการดึง endpoint/id
// นี่คือจุดที่ต้องพึ่งพาการทำงานของ .htaccess
$request = explode('/', trim($_SERVER['PATH_INFO'] ?? '', '/')); 
$resource = $request[0] ?? '';
$id = $request[1] ?? null;

// ให้ endpoint หลักเป็น 'products'
if ($resource !== "products") {
    http_response_code(404);
    echo json_encode(["error" => "Invalid endpoint"]);
    exit;
}

switch ($method) {
    case 'GET':
        if ($id) {
            // ดึงข้อมูลรายการเดียว
            $stmt = $conn->prepare("SELECT * FROM products WHERE id=?");
            $stmt->bind_param("i", $id);
            $stmt->execute();
            $result = $stmt->get_result()->fetch_assoc();
            if ($result) {
                echo json_encode($result);
            } else {
                http_response_code(404);
                echo json_encode(["error" => "Product not found"]);
            }
        } else {
            // ดึงข้อมูลทั้งหมด
            $result = $conn->query("SELECT * FROM products");
            echo json_encode($result->fetch_all(MYSQLI_ASSOC));
        }
        break;

    case 'POST':
        // เพิ่มสินค้าใหม่
        $data = json_decode(file_get_contents("php://input"), true);
        
        // ตรวจสอบข้อมูลเบื้องต้น
        if (empty($data) || !isset($data['title'])) {
            http_response_code(400); // Bad Request
            echo json_encode(["error" => "Missing data or invalid JSON."]);
            exit;
        }

        $stmt = $conn->prepare("INSERT INTO products (title, category, description, price, stock, origin, image_url) VALUES (?, ?, ?, ?, ?, ?, ?)");
        // sssdi ss คือ string 4 ตัว, double (decimal), integer, string 2 ตัว
        $stmt->bind_param("sssdiis", $data['title'], $data['category'], $data['description'], $data['price'], $data['stock'], $data['origin'], $data['image_url']);
        
        if ($stmt->execute()) {
             http_response_code(201); // Created
             echo json_encode(["success" => true, "id" => $conn->insert_id]);
        } else {
             http_response_code(500);
             echo json_encode(["error" => "Failed to create product."]);
        }
        break;

    case 'PUT':
        // แก้ไขสินค้า
        if (!$id) { 
            http_response_code(400); 
            echo json_encode(["error" => "Product ID required for update"]); 
            exit; 
        }
        
        $data = json_decode(file_get_contents("php://input"), true);
        if (empty($data)) {
            http_response_code(400); // Bad Request
            echo json_encode(["error" => "Missing data or invalid JSON."]);
            exit;
        }

        $set_clause = [];
        $bind_types = "";
        $bind_params = [];
        
        // สร้าง Set Clause และเตรียม Prepared Statement (แก้ไขจุดนี้ให้ปลอดภัย)
        foreach ($data as $key => $value) {
             // ตรวจสอบ key ที่อนุญาตให้ update ได้
             if (in_array($key, ['title', 'category', 'description', 'price', 'stock', 'origin', 'image_url'])) {
                 $set_clause[] = "$key = ?";
                 // กำหนดชนิดข้อมูล (d สำหรับ decimal, i สำหรับ integer, s สำหรับ string)
                 if ($key == 'price') {
                     $bind_types .= "d";
                 } elseif ($key == 'stock') {
                     $bind_types .= "i";
                 } else {
                     $bind_types .= "s";
                 }
                 $bind_params[] = $value;
             }
        }
        
        $sql = "UPDATE products SET " . implode(", ", $set_clause) . " WHERE id = ?";
        $bind_types .= "i"; // เพิ่มชนิดข้อมูลสำหรับ id
        $bind_params[] = $id; // เพิ่ม id เป็น parameter สุดท้าย
        
        $stmt = $conn->prepare($sql);
        // ใช้ call_user_func_array เพื่อ bind_param ด้วย array
        $stmt->bind_param($bind_types, ...$bind_params);
        
        $success = $stmt->execute();
        
        if ($success) {
            echo json_encode(["success" => true, "rows_affected" => $stmt->affected_rows]);
        } else {
            http_response_code(500);
            echo json_encode(["success" => false, "error" => $stmt->error]);
        }
        break;


    case 'DELETE':
        // ลบสินค้า
        if (!$id) { 
            http_response_code(400); 
            echo json_encode(["error" => "Product ID required for delete"]); 
            exit; 
        }
        
        // ใช้ Prepared Statement ในการลบ (เพื่อความปลอดภัย)
        $stmt = $conn->prepare("DELETE FROM products WHERE id=?");
        $stmt->bind_param("i", $id);
        
        $success = $stmt->execute();
        
        if ($success) {
             echo json_encode(["success" => true, "rows_deleted" => $stmt->affected_rows]);
        } else {
             http_response_code(500);
             echo json_encode(["success" => false, "error" => $stmt->error]);
        }
        break;

    case 'OPTIONS':
        // สำหรับ Preflight Request จาก Browser (CORS)
        http_response_code(200);
        exit;
        
    default:
        http_response_code(405); // Method Not Allowed
        echo json_encode(["error" => "Method not allowed"]);
}