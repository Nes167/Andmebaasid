## Andmebaas sales
```sql
--1.categories
create table categories(
category_id int PRIMARY KEY identity(1,1),
category_name varchar(25) UNIQUE);

INSERT INTO categories(category_name)
VALUES ('Arvuti');

SELECT * FROM categories;
```
<img width="219" height="109" alt="{AA745EB5-D265-4ABE-A993-5D46F6D9222D}" src="https://github.com/user-attachments/assets/ad7d2a47-013d-4c79-be07-0c2c3d67e880" />

```sql
--2.brands
CREATE TABLE brands(
brand_id int PRIMARY KEY identity(1,1),
brand_name varchar(15) UNIQUE);

INSERT INTO brands(brand_name)
VALUES ('Samsung');

SELECT * FROM brands;
```
<img width="184" height="115" alt="{98576E8F-1D2B-4ED7-881E-70D07E1D55D8}" src="https://github.com/user-attachments/assets/fc9ed315-3369-49f2-80c8-b4ea2305c45a" />

```sql
--3.products
Create TABLE products(
product_id int PRIMARY KEY identity(1,1),
product_name varchar(50) not null,
brand_id int,
FOREIGN KEY (brand_id) references  brands(brand_id),
category_id int,
FOREIGN KEY (category_id) references categories(category_id),
model_year int,
list_price money);

select * from products;

INSERT INTO products
VALUES ('nutitelefon X10', 1, 1, 2025, 600);
```
<img width="456" height="109" alt="{5E1B0ED8-F083-416A-8A82-6483AC17EE62}" src="https://github.com/user-attachments/assets/4ae7b75f-0bff-4ead-b079-f234f2f11b7e" />

```sql
--4.stores
CREATE TABLE stores(
store_id int PRIMARY KEY identity (1,1),
store_name varchar(20) not null,
phone varchar(13),
email varchar(40),
street varchar(20),
city varchar(10),
state varchar(10),
zip_code char(5));

SELECT * FROM stores;
```

<img width="599" height="110" alt="{C4C3E011-7461-4494-853F-54622BCD7B54}" src="https://github.com/user-attachments/assets/4f5b8610-0376-4329-a43b-d56f9c1ebb31" />

```sql
--5.stocks
CREATE TABLE stocks(
store_id int,
product_id int,
PRIMARY KEY(store_id, product_id),
FOREIGN KEY (store_id) references stores(store_id),
FOREIGN KEY (product_id) references products(product_id),
quantity int);

SELECT * FROM stocks;

INSERT INTO stocks
VALUES (2,1,5);
```
<img width="216" height="111" alt="{4C0E68FA-6DF3-41E2-BB76-8329F8C2810D}" src="https://github.com/user-attachments/assets/a28c6792-d7fb-4cfc-aabd-b5f69b9021d7" />

```sql
--6.customers
CREATE TABLE customers(
customer_id int PRIMARY KEY identity (1,1),
first_name varchar(20) not null,
last_name varchar(20) not null,
phone varchar(10),
email varchar(30),
street varchar(30),
city varchar(15) check (city='Tallinn' or city='Narva'),
state varchar(15),
zip_code char(5));

SELECT * FROM customers;

INSERT INTO customers
VALUES ('Oleg','Uustal','56574857','uustal@gmail.com', 'Läänemere tee','Narva','Ida-Virumaa','13457');
```
<img width="700" height="108" alt="{DF0DC727-C5CE-4A3C-A68A-FD943B449F73}" src="https://github.com/user-attachments/assets/153e541d-52b5-4ac5-b725-9495034afa4c" />

```sql
--7.staffs
CREATE TABLE staffs(
staff_id int PRIMARY KEY identity (1,1),
first_name varchar(20) not null,
last_name varchar(20) not null,
phone varchar(10),
active bit,
store_id int,
FOREIGN KEY (store_id) references stores(store_id),
manager bit);

SELECT * FROM staffs;

INSERT INTO staffs
VALUES ('Kirill','Leht', '56245878', 0,1,0);
```
<img width="444" height="107" alt="{6C4D7201-729B-4A23-930E-7BD6A738D530}" src="https://github.com/user-attachments/assets/3468f279-c9c9-44ce-af45-387f2f9e55f6" />

```sql
--8.orders
CREATE TABLE orders(
order_id int PRIMARY KEY identity (1,1),
customer_id int,
foreign key (customer_id) references customers(customer_id),
order_status varchar(15) check (order_status='complete' or order_status='incomplete'),
order_date date,
required_date date,
shipped_date date,
store_id int,
FOREIGN KEY (store_id) references stores(store_id),
staff_id int,
FOREIGN KEY (staff_id) references staffs(staff_id));

SELECT * FROM orders;

INSERT INTO orders
VALUES (3, 'incomplete', '2026-04-25','2026-05-18','2026-04-29',2,1);
```
<img width="585" height="106" alt="{E8F931E8-68E8-4AA1-8E59-FC763B22BDA1}" src="https://github.com/user-attachments/assets/187c061b-c63b-48e2-a097-d21ed2406007" />

```sql
--9.order_items
CREATE TABLE order_items(
order_id int,
item_id int, 
PRIMARY KEY (order_id,item_id),
product_id int,
FOREIGN KEY (product_id) references products(product_id),
quantity int,
list_price money,
discount int,
FOREIGN KEY (order_id) references orders(order_id));

SELECT * FROM order_items;

INSERT INTO order_items
VALUES (4, 2, 3, 50,500,10);
```
<img width="375" height="124" alt="{4ECFEE9A-BA6F-4530-8768-3057B8E6C4B6}" src="https://github.com/user-attachments/assets/b2701eff-961c-474b-a8e3-ffe3ab304299" />







