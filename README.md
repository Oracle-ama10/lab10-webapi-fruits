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
<img width="1919" height="1031" alt="Get all" src="https://github.com/user-attachments/assets/7403ea9b-e8f2-4c2e-9a84-ba19a6d4fc62" />

### GET สินค้าทีละชิ้น
```sh
curl http://localhost/lab10-webapi-fruits/api/products/1
```
<img width="1919" height="1029" alt="Get one" src="https://github.com/user-attachments/assets/ae6f8405-122b-48cd-b949-bdd4a33f21ca" />


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
<img width="1919" height="1038" alt="Post new" src="https://github.com/user-attachments/assets/f1048d27-0f6d-42e1-aef2-0a5708823e6e" />


### PUT แก้ไขสินค้า
```sh
curl -X PUT http://localhost/lab10-webapi-fruits/api/products/26 -H "Content-Type: application/json" -d '{
    "price": 150.00,
    "stock": 40
}'
```
<img width="1919" height="1033" alt="Update" src="https://github.com/user-attachments/assets/7cef617a-6f77-4218-bb6a-4ae32e545b56" />


### DELETE ลบสินค้า
```sh
curl -X DELETE http://localhost/lab10-webapi-fruits/api/products/26
```
<img width="1919" height="1034" alt="Delete" src="https://github.com/user-attachments/assets/8c461fb8-b65d-4fea-ad10-3e2c9cca2a85" />



