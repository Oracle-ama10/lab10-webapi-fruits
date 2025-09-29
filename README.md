# 🍎 Lab10 Web API - ร้านขายผลไม้

## 📖 รายละเอียด
โปรเจกต์นี้เป็น RESTful API ด้วย **PHP + MySQL** ทำงานบน XAMPP  
ใช้สำหรับจัดการข้อมูลสินค้า (ผลไม้) สามารถ:
- ดูผลไม้ทั้งหมด
- ดูทีละผล
- เพิ่มผลไม้
- แก้ไขผลไม้
- ลบผลไม้

---

## ⚙️ การติดตั้ง
1. Import ไฟล์ `fruits.sql` เข้าฐานข้อมูล MySQL
2. วางโฟลเดอร์ `api/` ไว้ใน `htdocs/lab10/`
3. แก้ไข `db.php` ถ้าคุณเปลี่ยน user/password ฐานข้อมูล
4. เรียก API ผ่าน URL เช่น:
   ```
   http://localhost/lab10-webapi-fruits/api/products
   ```

---

## 🛠 Endpoints

| Method | Endpoint                  | คำอธิบาย |
|--------|---------------------------|-----------|
| GET    | `/products`               | ดึงสินค้าทั้งหมด |
| GET    | `/products/{id}`          | ดึงสินค้าตาม id |
| POST   | `/products`               | เพิ่มสินค้าใหม่ |
| PUT    | `/products/{id}`          | แก้ไขสินค้า |
| DELETE | `/products/{id}`          | ลบสินค้า |

---

## 📌 ตัวอย่างการใช้งาน

### GET สินค้าทั้งหมด
```sh
curl http://localhost/lab10-webapi-fruits/api/products
```

### GET สินค้าทีละชิ้น
```sh
curl http://localhost/lab10-webapi-fruits/api/products/1
```

### POST เพิ่มสินค้า
```sh
curl -X POST http://localhost/lab10-webapi-fruits/api/products -H "Content-Type: application/json" -d '{	
"title": "สละอินโด",	
"category": "ผลไม้เมืองร้อน",	
"description": "สละพันธุ์ใหม่ รสหวานกรอบ",	
"price": 180.00,	
"stock": 50,	
"origin": "อินโดนีเซีย",	
"image_url": "https://www.google.com/search?q=https://example.com/salak_indo.jpg"	
}'
```

### PUT แก้ไขสินค้า
```sh
curl -X PUT http://localhost/lab10-webapi-fruits/api/products/26 -H "Content-Type: application/json" -d '{
    "price": 150.00,
    "stock": 40
}'
```

### DELETE ลบสินค้า
```sh
curl -X DELETE http://localhost/lab10-webapi-fruits/api/products/26
```

---


