-- สร้างฐานข้อมูล
CREATE DATABASE IF NOT EXISTS lab10_webapi CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE lab10_webapi;

-- ลบตารางเดิมถ้ามี
DROP TABLE IF EXISTS products;

-- สร้างตาราง products
CREATE TABLE products (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(100) NOT NULL,
  category VARCHAR(50),
  description TEXT,
  price DECIMAL(10,2) NOT NULL,
  stock INT DEFAULT 0,
  origin VARCHAR(50),
  image_url VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- เพิ่มข้อมูลผลไม้ 25 รายการ
INSERT INTO products (title, category, description, price, stock, origin, image_url) VALUES
('มะม่วงน้ำดอกไม้', 'ผลไม้เมืองร้อน', 'มะม่วงรสหวาน เนื้อละมุน', 60, 120, 'ประเทศไทย', 'https://example.com/mango.jpg'),
('ทุเรียนหมอนทอง', 'ผลไม้เมืองร้อน', 'ราชาผลไม้ กลิ่นแรง เนื้อหวานมัน', 150, 30, 'ประเทศไทย', 'https://example.com/durian.jpg'),
('กล้วยหอมทอง', 'ผลไม้เมืองร้อน', 'กล้วยเนื้อแน่น หอมหวาน', 40, 200, 'ประเทศไทย', 'https://example.com/banana.jpg'),
('ส้มเขียวหวาน', 'ผลไม้เมืองร้อน', 'ส้มรสหวานอมเปรี้ยว', 55, 90, 'ประเทศไทย', 'https://example.com/orange.jpg'),
('เงาะโรงเรียน', 'ผลไม้เมืองร้อน', 'เงาะผิวแดง เนื้อกรอบ', 70, 75, 'ประเทศไทย', 'https://example.com/rambutan.jpg'),
('มังคุด', 'ผลไม้เมืองร้อน', 'ราชินีแห่งผลไม้', 80, 65, 'ประเทศไทย', 'https://example.com/mangosteen.jpg'),
('สับปะรดภูแล', 'ผลไม้เมืองร้อน', 'สับปะรดผลเล็ก หวานฉ่ำ', 45, 110, 'ประเทศไทย', 'https://example.com/pineapple.jpg'),
('ฝรั่งกิมจู', 'ผลไม้เมืองร้อน', 'กรอบ หวาน อมเปรี้ยวเล็กน้อย', 35, 150, 'ประเทศไทย', 'https://example.com/guava.jpg'),
('แอปเปิ้ลฟูจิ', 'ผลไม้เมืองหนาว', 'แอปเปิ้ลจากญี่ปุ่น หวาน กรอบ', 90, 80, 'ญี่ปุ่น', 'https://example.com/apple.jpg'),
('สตรอว์เบอร์รี', 'ผลไม้เมืองหนาว', 'ผลสีแดงสด รสหวานอมเปรี้ยว', 120, 50, 'เชียงใหม่', 'https://example.com/strawberry.jpg'),
('องุ่นไร้เมล็ด', 'ผลไม้เมืองหนาว', 'องุ่นหวานทานง่าย', 110, 95, 'ออสเตรเลีย', 'https://example.com/grape.jpg'),
('กีวี', 'ผลไม้เมืองหนาว', 'เนื้อสีเขียวอมเปรี้ยว', 85, 60, 'นิวซีแลนด์', 'https://example.com/kiwi.jpg'),
('ลูกแพร์', 'ผลไม้เมืองหนาว', 'ผลสีเหลืองนวล รสหวานหอม', 95, 40, 'จีน', 'https://example.com/pear.jpg'),
('เชอร์รี', 'ผลไม้เมืองหนาว', 'ผลเล็กสีแดงเข้ม', 250, 25, 'อเมริกา', 'https://example.com/cherry.jpg'),
('บลูเบอร์รี', 'ผลไม้เมืองหนาว', 'ผลสีม่วงเข้ม อุดมด้วยสารต้านอนุมูลอิสระ', 180, 35, 'แคนาดา', 'https://example.com/blueberry.jpg'),
('ลิ้นจี่', 'ผลไม้เมืองร้อน', 'ผลสีแดง รสหวานฉ่ำ', 130, 55, 'ประเทศไทย', 'https://example.com/lychee.jpg'),
('แตงโม', 'ผลไม้เมืองร้อน', 'ผลใหญ่ เนื้อแดงหวานฉ่ำ', 45, 100, 'ประเทศไทย', 'https://example.com/watermelon.jpg'),
('แคนตาลูป', 'ผลไม้เมืองร้อน', 'เนื้อสีส้ม รสหวานหอม', 60, 85, 'ประเทศไทย', 'https://example.com/cantaloupe.jpg'),
('มะละกอฮอลแลนด์', 'ผลไม้เมืองร้อน', 'ผลใหญ่ เนื้อแน่น รสหวาน', 55, 70, 'ประเทศไทย', 'https://example.com/papaya.jpg'),
('ลูกพลับ', 'ผลไม้เมืองหนาว', 'ผลสีส้มสด เนื้อหวาน', 140, 30, 'จีน', 'https://example.com/persimmon.jpg'),
('อินทผลัม', 'ผลไม้เมืองร้อน', 'ผลหวานมาก นิยมอบแห้ง', 200, 45, 'ดูไบ', 'https://example.com/date.jpg'),
('มะขามหวาน', 'ผลไม้เมืองร้อน', 'รสหวานอมเปรี้ยว', 95, 55, 'เพชรบูรณ์', 'https://example.com/tamarind.jpg'),
('น้อยหน่า', 'ผลไม้เมืองร้อน', 'เนื้อขาว เมล็ดเยอะ', 85, 60, 'ประเทศไทย', 'https://example.com/sugarapple.jpg'),
('มะปราง', 'ผลไม้เมืองร้อน', 'ผลสีเหลือง เนื้อหวาน', 120, 40, 'ประเทศไทย', 'https://example.com/marang.jpg'),
('มะเฟือง', 'ผลไม้เมืองร้อน', 'ผลรูปดาว รสเปรี้ยวอมหวาน', 75, 50, 'ประเทศไทย', 'https://example.com/starfruit.jpg');
