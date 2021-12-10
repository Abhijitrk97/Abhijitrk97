CREATE TABLE employees (
  empid number PRIMARY KEY,
  firstname varchar(20),
  lastname varchar(20),
  gender char,
  DOB date,
  phnumber number,
  address varchar(20),
  email varchar(20),
  deptno number,
  mgrid number
);

CREATE TABLE department (
  deptno number PRIMARY KEY,
  deptname varchar(10),
  deptaddress varchar(10),
  locationno number
);

CREATE TABLE location (
  locationno number PRIMARY KEY,
  location_name varchar(20),
  location_mgrid number
);

CREATE TABLE customers (
  customerid number PRIMARY KEY,
  customer_fname varchar(20),
  customer_lname varchar(20),
  customer_gender varchar(20),
  customer_phno number,
  customer_email varchar(20),
  customer_DOB date,
  street_address varchar(20),
  apt_house_no number,
  city varchar(20),
  state varchar(20),
  country varchar(20),
  zip number
);

CREATE TABLE cart_items (
  cart_id number PRIMARY KEY,
  customerid number,
  product_id number,
  quantity number,
  Product_price number,
  Date_Created date,
  is_final char
);

CREATE TABLE orders (
  orderid number PRIMARY KEY,
  customerid number,
  cart_id number,
  amount number,
  delivery_address varchar(20),
  transaction_id number,
  order_date date
);

CREATE TABLE order_items (
  orderid number,
  productid number PRIMARY KEY,
  quantity number,
  Product_price number
);

CREATE TABLE transaction (
  transaction_id number,
  orderid number PRIMARY KEY,
  modeof_payment varchar(20),
  card_type varchar(20),
  card_number number,
  card_expirydate date,
  payment_status char,
  transaction_date date
);

CREATE TABLE product (
  productid number PRIMARY KEY,
  upc_code number,
  sku_code number,
  price number,
  expiry_date date,
  product_name varchar(20),
  description varchar(20),
  brand varchar(20),
  supplier_id number,
  category_id number
);

CREATE TABLE category (
  category_id number PRIMARY KEY,
  sub_category varchar(20),
  category_main varchar(20)
);

CREATE TABLE inventory_product (
  inventory_id number PRIMARY KEY,
  productid number,
  quantity number
);

CREATE TABLE inventory (
  inventory_id number PRIMARY KEY,
  inventory_name varchar(20),
  storage_space number
);

CREATE TABLE supplier_inventory (
  supplierno number PRIMARY KEY,
  inventory_id number,
  Product_id number
);

CREATE TABLE supplier (
  supplierno number NOT NULL,
  suppliername varchar(20),
  Product_id number,
  quantity_suppliable number,
  PRIMARY KEY (supplierno)
);

CREATE TABLE deliverypartner (
  partner_id number,
  partner_no number,
  partner_name varchar(255),
  orderid number,
  delivery_status char
);

CREATE TABLE returns (
  customerid number UNIQUE,
  returnid number,
  orderid number PRIMARY KEY,
  product_id number,
  quantity number,
  partnerid number
);




ALTER TABLE department ADD CONSTRAINT FK_Department_Location FOREIGN KEY (locationno) REFERENCES location (locationno);

ALTER TABLE employees ADD CONSTRAINT FK_Employees_Department FOREIGN KEY (deptno) REFERENCES department (deptno);

ALTER TABLE cart_items ADD CONSTRAINT FK_CartItems_Customers FOREIGN KEY (customerid) REFERENCES customers (customerid);

ALTER TABLE orders ADD CONSTRAINT FK_Orders_CartItems FOREIGN KEY (cart_id) REFERENCES cart_items (cart_id);


ALTER TABLE product ADD CONSTRAINT FK_Product_OrderItems FOREIGN KEY (productid) REFERENCES order_items (productid);

ALTER TABLE product ADD CONSTRAINT FK_Product_Category FOREIGN KEY (category_id) REFERENCES category (category_id);

ALTER TABLE inventory_product ADD CONSTRAINT FK_InventoryProduct_Product FOREIGN KEY (productid) REFERENCES product (productid);

ALTER TABLE inventory ADD CONSTRAINT FK_Inventory_InventoryProduct FOREIGN KEY (inventory_id) REFERENCES inventory_product (inventory_id);

ALTER TABLE supplier_inventory ADD CONSTRAINT FK_SupplierInventory_Inventory FOREIGN KEY (inventory_id) REFERENCES inventory (inventory_id);

ALTER TABLE supplier ADD CONSTRAINT FK_Supplier_SupplierInventory FOREIGN KEY (supplierno) REFERENCES supplier_inventory (supplierno);

ALTER TABLE deliverypartner ADD CONSTRAINT FK_Deliverypartner_Orders FOREIGN KEY (orderid) REFERENCES orders (orderid);

ALTER TABLE orders ADD CONSTRAINT FK_Orders_Transaction FOREIGN KEY (orderid) REFERENCES transaction (orderid);

ALTER TABLE customers ADD CONSTRAINT FK_Customers_Returns FOREIGN KEY (customerid) REFERENCES returns (customerid);

ALTER TABLE deliverypartner ADD CONSTRAINT FK_Deliverypartner_Returns FOREIGN KEY (orderid) REFERENCES returns (orderid);

ALTER TABLE order_items ADD CONSTRAINT FK_OrderItems_Returns FOREIGN KEY (orderid) REFERENCES returns (orderid);