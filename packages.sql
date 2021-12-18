CREATE OR REPLACE PACKAGE everything AS

VIEW EmployeeDetailsWithGreaterSalaryThanManagers;
VIEW EmployeeDetailsWithGreaterSalaryThanManagers;
VIEW mostDissatisfiedCustomersView;
VIEW RecentProductExpiryDate;
VIEW MostPurchaseByCustomer ;
VIEW MostReturnedProducts;
VIEW TotalAmountByCity;
VIEW TotalAmountByCountry;
VIEW CityOrdersByDate;
VIEW CustomerView;
VIEW InventoryDetails;
VIEW RecentOrders;
VIEW YearlyAndMonthlyOrderCount;
VIEW YearlySales;

PROCEDURE prepopulatetable;
PROCEDURE cust_proc
(
    x_fname customers.customer_fname%TYPE,
    x_lname customers.customer_lname%TYPE,
    x_gender customers.customer_gender%TYPE,
    x_phno customers.customer_phno%TYPE,
    x_email customers.customer_email%TYPE,
    x_dob customers.customer_dob%TYPE,
    x_address customers.street_address%TYPE,
    x_aptno customers.apt_house_no%TYPE,
    x_city customers.city%TYPE,
    x_state customers.state%TYPE,
    x_country customers.country%TYPE,
    x_zip customers.zip%TYPE
);
procedure delprtn_proc 
(
    x_partnerno deliverypartner.partner_no%TYPE,
    x_partnername deliverypartner.partner_name%TYPE,
    x_deliverysts deliverypartner.delivery_status%TYPE
);

procedure proc_supplier 
(
    x_suppliername supplier.suppliername%TYPE,
    x_productid supplier.product_id%TYPE,
    x_quantsup supplier.quantity_suppliable%TYPE
);

procedure cat_proc
(
    x_subcat category.sub_category%TYPE,
    x_categorymain category.category_main%TYPE
);

procedure proc_prod
(

x_price product.price%TYPE,
x_expiry product.expiry_date%TYPE,
x_productnm product.product_name%TYPE,
x_descrip product.description%TYPE,
x_brand product.brand%TYPE,
x_supid product.supplier_id%TYPE,
x_catid product.category_id%TYPE
);

procedure proc_loc
(
  
  x_locname location.location_name%TYPE,
  x_locmgrid location.location_mgrid%TYPE
);

procedure proc_dep
(
   
    x_deptname department.deptname%TYPE,
    x_deptadd department.deptaddress%TYPE,
    x_locationno department.locationno%TYPE
);

procedure proc_emp
(
    x_empfirstname employees.firstname%TYPE,
    x_emplastname employees.lastname%TYPE,
    x_empgend employees.gender%TYPE,
    x_empdateofb employees.DOB%TYPE,
    x_empphnum employees.phnumber%TYPE,
    x_empaddss employees.address%TYPE,
    x_empem employees.email%TYPE,
    x_empsal employees.salary%TYPE,
    x_empdeptnum employees.deptno%TYPE,
    x_empmid employees.mgrid%TYPE
);

procedure proc_inventory
(
    x_inInventoryName inventory.inventory_name%TYPE,
    x_inStorageSpace inventory.storage_space%TYPE,
    x_invlocation inventory.invlocation%type
);

procedure proc_inv_prod
(
    x_invInventoryId inventory_product.inventory_id%TYPE,
    x_invProductId inventory_product.productid%TYPE,
    x_invQuantity inventory_product.quantity%TYPE
);


procedure proc_suppin
(
    x_supplierno supplier_inventory.supplierno%TYPE,
    x_inventid supplier_inventory.inventory_id%TYPE,
    x_prodid supplier_inventory.product_id%TYPE
)

procedure proc_ret
(
    x_customid returns.customerid%TYPE,
    x_ordid returns.orderid%TYPE,
    x_produid returns.product_id%TYPE,
    x_quant returns.quantity%TYPE,
    x_partid returns.partnerid%TYPE
);

procedure procgenorderid(
x_customerid orders.customerid%type,
x_deliveryaddress orders.delivery_address%TYPE
);

procedure procorder_items(
x_orderidins order_items.orderid%type,
x_productidins order_items.productid%type,
x_quantityins order_items.quantity%type
);

procedure populateamount(
x_finorderid orders.orderid%type
);


PROCEDURE assigndelipartner
(
x_transorderid deliveredby.orderid%type
);


PROCEDURE completetransaction(
x_transorderid transactions.orderid%type,
x_modeofpayment transactions.modeof_payment%type,
x_cardtype transactions.card_type%type,
x_cardnumber transactions.card_number%type,
x_cardexpirydate transactions.card_expirydate%type,
x_transaction_date transactions.transaction_date%type
);


procedure proc_delorderitems
(
    x_orderid returns.orderid%TYPE,
    x_productid returns.product_id%TYPE
);


FUNCTION getamount (varorderid number) return orders.amount%type;

FUNCTION is_numeric (str IN VARCHAR2) RETURN INT;

function getprice(
varproductid number
)
return product.price%type;

FUNCTION getpartner
RETURN deliveredby.partner_id%TYPE;

END everthing;

create sequence seq_cust start with 1000
increment by 1;

create sequence seq_dlvptn start with 1000
increment by 1;

create sequence seq_supplier start with 1000
increment by 1;

create sequence seq_cat start with 100
increment by 1;

create sequence seq_prod start with 100
increment by 1;

create sequence seq_loc start with 100
increment by 1;

create sequence seq_dep start with 1
increment by 1;

create sequence seq_emp start with 1000
increment by 1;

create sequence seq_inventory start with 100
increment by 1;

create sequence seq_orders start with 1000
increment by 1;

create sequence seq_transaction start with 1000
increment by 1;


CREATE OR REPLACE PACKAGE BODY everything AS



PROCEDURE prepopulatetable 
    is
BEGIN

insert into category values(80,'shoe','wear');
insert into category values(81,'shirt','wear');
insert into category values(82,'pant','wear');
insert into category values(83,'cap','wear');
insert into category values(84,'belt','wear');
insert into category values(85,'gloves','wear');
insert into category values(86,'towel','wear');
insert into category values(87,'socks','wear');
insert into category values(88,'scarf','wear');
insert into category values(89,'jacket','wear');

insert into product values(40,1001,10001,100,date'2025-02-02','shoe','red','nike',30,80);
insert into product values(41,1002,10002,101,date'2025-03-02','shirt','green','adidas',31,81);
insert into product values(42,1003,10003,102,date'2025-04-02','pant','black','jordan',32,82);
insert into product values(43,1004,10004,103,date'2025-05-02','cap','indigo','puma',33,83);
insert into product values(44,1005,10005,104,date'2025-06-02','belt','blue','balmain',34,84);
insert into product values(45,1006,10006,105,date'2025-07-02','gloves','white','primark',35,85);
insert into product values(46,1007,10007,106,date'2025-08-02','towel','pink','gucci',36,86);
insert into product values(47,1008,10008,107,date'2025-09-02','socks','yellow','coach',37,87);
insert into product values(48,1009,10009,108,date'2025-10-02','scarf','orange','channel',38,88);
insert into product values(49,1010,10010,109,date'2025-11-02','jacket','violet','timberland',39,89);

insert into customers VALUES(1,'david','warner','M',9441456907,'david@gmail.com',date'1989-09-08','Savenue',3,'boston','MA','USA',02140);
insert into customers VALUES(2,'steve','smith','M',9443456907,'steve@gmail.com',date'1998-03-04','jvue',4,'Ashland','MA','USA',02490);
insert into customers VALUES(3,'david','miller','M',9421456907,'miller@gmail.com',date'1989-06-04','missionmain',5,'denver','MA','USA',02110);
insert into customers VALUES(4,'ross','taylor','M',9498456907,'ross@gmail.com',date'1999-08-09','boylston',6,'charles','MA','USA',02800);
insert into customers VALUES(5,'virat','kohli','M',9441456877,'virat@gmail.com',date'1992-10-03','aliston',7,'chestnut','MA','USA',02190);
insert into customers VALUES(6,'marcus','harris','M',9441156904,'harris@gmail.com',date'1997-08-11','parkerst',8,'malakpet','hyderabad','India',500040);
insert into customers VALUES(7,'preha','palle','F',944858922,'palle@gmail.com',date'1979-06-06','Huntington',9,'richardson','NJ','USA',06140);
insert into customers VALUES(8,'gautami','rao','F',92241456988,'rao@gmail.com',date'1993-11-12','kothapet',10,'brunshwick','NJ','USA',06640);
insert into customers VALUES(9,'rohith','sharma','M',9441006907,'rohith@gmail.com',date'1994-12-08','rampur',11,'goa','punjab','India',500036);
insert into customers VALUES(10,'ishanth','verma','M',9441456337,'ishanth@gmail.com',date'1989-10-08','goa',12,'kent','MA','USA',02240);

insert into orders values(11,1,100,'Savenue',4,date'2021-12-18');
insert into orders values(12,2,101,'jvue',5,date'2021-12-18');
insert into orders values(13,3,102,'missionmain',6,date'2021-12-18');
insert into orders values(14,4,103,'boylston',7,date'2021-12-18');
insert into orders values(15,5,104,'aliston',8,date'2021-12-18');
insert into orders values(16,6,105,'parkerst',9,date'2021-12-18');
insert into orders values(17,7,106,'Huntington',10,date'2021-12-18');
insert into orders values(18,8,107,'kothapet',21,date'2021-12-18');
insert into orders values(19,9,108,'rampur',22,date'2021-12-18');
insert into orders values(20,10,109,'goa',23,date'2021-12-18');

insert into transactions values(50,11,'card','visa',1234,date'2025-02-02','Y',date'2021-12-18');
insert into transactions values(51,12,'card','visa',1123,date'2025-02-02','Y',date'2021-12-18');
insert into transactions values(52,13,'card','visa',1224,date'2025-02-02','Y',date'2021-12-18');
insert into transactions values(53,14,'card','visa',1244,date'2025-02-02','Y',date'2021-12-18');
insert into transactions values(54,15,'card','visa',1233,date'2025-02-02','Y',date'2021-12-18');
insert into transactions values(55,16,'card','visa',1231,date'2025-02-02','Y',date'2021-12-18');
insert into transactions values(56,17,'card','visa',1232,date'2025-02-02','Y',date'2021-12-18');
insert into transactions values(57,18,'card','visa',1221,date'2025-02-02','Y',date'2021-12-18');
insert into transactions values(58,19,'card','visa',1235,date'2025-02-02','Y',date'2021-12-18');
insert into transactions values(59,20,'card','visa',1239,date'2025-02-02','Y',date'2021-12-18');

insert into order_Items values(11,40,2,100);
insert into order_Items values(12,41,3,101);
insert into order_Items values(13,42,4,102);
insert into order_Items values(14,43,5,103);
insert into order_Items values(15,44,6,104);
insert into order_Items values(16,45,7,105);
insert into order_Items values(17,46,8,106);
insert into order_Items values(18,47,9,107);
insert into order_Items values(19,48,10,108);
insert into order_Items values(20,49,11,109);

insert into supplier values(420,'ziva',40,900);
insert into supplier values(421,'ziva',41,901);
insert into supplier values(422,'ziva',42,902);
insert into supplier values(423,'ziva',43,903);
insert into supplier values(424,'ziva',44,904);
insert into supplier values(425,'ziva',45,905);
insert into supplier values(426,'ziva',46,906);
insert into supplier values(427,'ziva',47,907);
insert into supplier values(428,'ziva',48,908);
insert into supplier values(429,'ziva',49,909);

insert into Inventory values(600,'melon',900,'Delhi');
insert into Inventory values(601,'strawberry',901,'Mirzapur');    
insert into Inventory values(602,'blueberry',902,'Goa');
insert into Inventory values(603,'mango',903,'Hyderabad');
insert into Inventory values(604,'orange',904,'Chennai');   
insert into Inventory values(605,'banana',905,'Mumbai');
insert into Inventory values(606,'apple',906,'Karnataka');
insert into Inventory values(607,'litchi',907,'Kolkata');    
insert into Inventory values(608,'grape',908,'Srinagar');
insert into Inventory values(609,'dragonfruit',909,'Kochi');

insert into supplier_inventory values(420,600,40);
insert into supplier_inventory values(421,601,41);
insert into supplier_inventory values(422,602,42);
insert into supplier_inventory values(423,603,43);
insert into supplier_inventory values(424,604,44);
insert into supplier_inventory values(425,605,45);
insert into supplier_inventory values(426,606,46);
insert into supplier_inventory values(427,607,47);
insert into supplier_inventory values(428,608,48);
insert into supplier_inventory values(429,609,49);

insert into Inventory_product values(600,40,60);
insert into Inventory_product values(601,41,61);
insert into Inventory_product values(602,42,62);
insert into Inventory_product values(603,43,63);
insert into Inventory_product values(604,44,64);
insert into Inventory_product values(605,45,65);
insert into Inventory_product values(606,46,66);
insert into Inventory_product values(607,47,67);
insert into Inventory_product values(608,48,68);
insert into Inventory_product values(609,49,69);

insert into deliverypartner values(19,121,'scott');
insert into deliverypartner values(29,122,'micheal');
insert into deliverypartner values(39,123,'pam');
insert into deliverypartner values(49,124,'kevin');
insert into deliverypartner values(59,125,'dwight');
insert into deliverypartner values(69,126,'oscar');
insert into deliverypartner values(79,127,'angela');
insert into deliverypartner values(89,128,'jim');
insert into deliverypartner values(99,129,'rayn');
insert into deliverypartner values(09,120,'andy');

insert into deliveredby values(19,11,'Y');
insert into deliveredby values(29,12,'Y');
insert into deliveredby values(39,13,'Y');
insert into deliveredby values(49,14,'Y');
insert into deliveredby values(59,15,'Y');
insert into deliveredby values(69,16,'Y');
insert into deliveredby values(79,17,'Y');
insert into deliveredby values(89,18,'Y');
insert into deliveredby values(99,19,'Y');
insert into deliveredby values(09,20,'Y');

insert into returns values(60,1,11,1111,3,19);
insert into returns values(61,2,12,1112,4,29);
insert into returns values(62,3,13,1113,5,39);
insert into returns values(63,4,14,1114,6,49);
insert into returns values(64,5,15,1115,7,59);
insert into returns values(65,6,16,1116,8,69);
insert into returns values(66,7,17,1117,9,79);
insert into returns values(67,8,18,1118,10,89);
insert into returns values(68,9,19,1119,11,99);
insert into returns values(69,10,20,1110,12,09);

insert into location values(150,'huntington',300);
insert into location values(151,'huntington',301);
insert into location values(152,'huntington',302);
insert into location values(153,'huntington',303);
insert into location values(154,'huntington',304);
insert into location values(155,'huntington',305);
insert into location values(156,'huntington',306);
insert into location values(157,'huntington',307);
insert into location values(158,'huntington',308);
insert into location values(159,'huntington',309);

insert into department values(101,'IT','jvue',150);
insert into department values(103,'IT','jvue',151);
insert into department values(105,'IT','jvue',152);
insert into department values(107,'IT','jvue',153);
insert into department values(109,'IT','jvue',154);
insert into department values(111,'IT','jvue',155);
insert into department values(113,'IT','jvue',156);
insert into department values(115,'IT','jvue',157);
insert into department values(117,'IT','jvue',158);
insert into department values(119,'IT','jvue',159);

insert into employees VALUES(1,'Raj','tharun','M',date'1998-12-12',9492442222,'jvue','raj@gmail.com',1000,101,102);
insert into employees VALUES(2,'Ravi','singh','M',date'1990-11-11',9492222112,'Savenue','ravi@gmail.com',2000,103,104);
insert into employees VALUES(3,'varun','baddam','M',date'1980-10-09',949779922,'missionmain','varun@gmail.com',3000,105,106);
insert into employees VALUES(4,'ketan','patel','M',date'1995-03-08',9492445222,'boylston','ketan@gmail.com',4000,107,108);
insert into employees VALUES(5,'tanmay','bhatt','M',date'1998-02-02',9497442222,'aliston','tanmay@gmail.com',5000,109,110);
insert into employees VALUES(6,'teja','bhattar','M',date'1980-06-02',9499442222,'parkerst','teja@gmail.com',6000,111,112);
insert into employees VALUES(7,'rahul','reddy','M',date'1989-1-12',9492440022,'Huntington','rahul@gmail.com',7000,113,114);
insert into employees VALUES(8,'arpitha','ghanate','F',date'1989-11-09',9472442222,'kothapet','arpitha@gmail.com',8000,115,116);
insert into employees VALUES(9,'kiran','poosa','M',date'1988-07-12',9492444422,'rampur','kiran@gmail.com',9000,117,118);
insert into employees VALUES(10,'dhanush','vasa','M',date'1997-09-11',9412442222,'goa','dhanush@gmail.com',10000,119,120);
 
END prepopulatetable;


PROCEDURE cust_proc
(
    x_fname customers.customer_fname%TYPE,
    x_lname customers.customer_lname%TYPE,
    x_gender customers.customer_gender%TYPE,
    x_phno customers.customer_phno%TYPE,
    x_email customers.customer_email%TYPE,
    x_dob customers.customer_dob%TYPE,
    x_address customers.street_address%TYPE,
    x_aptno customers.apt_house_no%TYPE,
    x_city customers.city%TYPE,
    x_state customers.state%TYPE,
    x_country customers.country%TYPE,
    x_zip customers.zip%TYPE
)
AS
    countEmail NUMBER;
    countPhno NUMBER;

    s_fname EXCEPTION;
    s_lname EXCEPTION;
    s_gender EXCEPTION;
    s_phno EXCEPTION;
    s_email EXCEPTION;
    s_dob EXCEPTION;
    s_address EXCEPTION;
    s_aptno EXCEPTION;
    s_city EXCEPTION;
    s_state EXCEPTION;
    s_country EXCEPTION;
    s_zip EXCEPTION;
    ss_gender customers.customer_gender%TYPE;
    dup_email EXCEPTION;
    dup_phno EXCEPTION;

    
Begin

IF x_fname IS NULL
THEN RAISE s_fname;

IF x_lname Is Null
THEN RAISE s_lname;

IF x_gender IS NULL
THEN RAISE s_gender;

If x_phno IS NULL
THEN RAISE s_phno;

IF x_email Is Null
THEN RAISE s_email;

IF x_dob IS NULL
THEN RAISE s_dob;

IF x_address IS NULL
THEN RAISE s_address;

IF x_aptno Is Null
THEN RAISE s_aptno;

IF x_city IS NULL
THEN RAISE s_city;

If x_state IS NULL
THEN RAISE s_state;

IF x_country IS NULL
THEN Raise s_country;

IF x_zip IS NULL
THEN RAISE s_zip;

END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;

SELECT COUNT(*) INTO countEmail FROM customers WHERE customer_email = x_email;
IF countEmail > 0 THEN
    RAISE dup_email;
END IF;

SELECT COUNT(*) INTO countPhno From customers WHERE customer_phno = x_phno;
IF countPhno > 0 THEN
    RAISE dup_phno;
END IF;

select x_gender into ss_gender from dual where x_gender IN ('M','F','T');

INSERT INTO customers(customerid,customer_fname,customer_lname,customer_gender,customer_phno,customer_email,customer_dob,street_address,apt_house_no,city,state,country,zip)
VALUES(seq_cust.nextval,x_fname,x_lname,x_gender,x_phno,x_email,x_dob,x_address,x_aptno,x_city,x_state,x_country,x_zip);


    

EXCEPTION

    WHEN dup_email THEN
        dbms_output.put_line('Email cannot be repeated ');
        
    WHEN dup_phno THEN
        dbms_output.put_line('Phone number cannot be repeated ');
        
    When s_fname THEN
        dbms_output.put_line('First Name cannot be null');

    WHEN s_lname THEN
        dbms_output.put_line('Last Name cannot be null');

    WHEN s_gender THEN
        dbms_output.put_line('Gender value cannot be null');

    When s_phno THEN
        dbms_output.put_line('Phone number cannot be null');
        
    WHEN s_email THEN
        dbms_output.put_line('Email ID cannot be null');
        
    WHEN s_dob THEN
        dbms_output.put_line('Date of Birth cannot be null');
        
    When s_address THEN
        dbms_output.put_line('Address cannot be null');
        
    WHEN s_aptno THEN
        dbms_output.put_line('Apartment number cannot be null');
        
    WHEN s_city THEN
        dbms_output.put_line('City cannot be null');
        
    WHEN s_state THEN
        dbms_output.put_line('State cannot be null');
        
    WHEN s_country THEN
        dbms_output.put_line('Country cannot be null');
        
    WHEN s_zip THEN
        dbms_output.put_line('Zip cannot be null');
        
    WHEN no_data_found THEN
        dbms_output.put_line('(M/F/T) genders entry only');

END cust_proc;


procedure delprtn_proc 
(
    x_partnerno deliverypartner.partner_no%TYPE,
    x_partnername deliverypartner.partner_name%TYPE,
    x_deliverysts deliverypartner.delivery_status%TYPE
)
AS

dp_status deliverypartner.delivery_status%TYPE;
dp_namenull exception;

BEGIN
if x_partnername is null then
  raise dp_namenull;
IF x_deliverysts not in('Y','N') then
    raise_application_error(-20009, 'Delivery status can only be Y or N');
end if;
end if;


insert into deliverypartner(partner_id,partner_no,partner_name,delivery_status)
values(seq_dlvptn.nextval,x_partnerno,x_partnername,x_deliverysts);

EXCEPTION 
    when dp_namenull then
        DBMS_OUTPUT.PUT_LINE('Please fill all the details, partnername cannot be blank');

end delprtn_proc;


procedure proc_supplier 
(
    x_suppliername supplier.suppliername%TYPE,
    x_productid supplier.product_id%TYPE,
    x_quantsup supplier.quantity_suppliable%TYPE
)
AS

countsupp number;
s_namenull exception;
s_proidnull exception;
s_dupcolcomb exception;

BEGIN
if x_suppliername is null then
  raise s_namenull;
IF x_productid is null then
    raise s_proidnull;
end if;
end if;
select count(*) into countsupp from supplier where product_id = x_productid and suppliername = x_suppliername;
if countsupp > 0 then
    raise s_dupcolcomb;
end if;

insert into supplier(supplierno,suppliername,product_id,quantity_suppliable)
values(seq_supplier.nextval,x_suppliername,x_productid,x_quantsup);

EXCEPTION 
    when s_namenull then
        DBMS_OUTPUT.PUT_LINE('Please fill all the details, suppliername cannot be blank');
    when s_proidnull then
        DBMS_OUTPUT.PUT_LINE('Please fill all the details, productid cannot be blank');
    when s_dupcolcomb then
        DBMS_OUTPUT.PUT_LINE('combination of productid and suppliername already exists');

end proc_supplier;


procedure cat_proc
(
   
    x_subcat category.sub_category%TYPE,
    x_categorymain category.category_main%TYPE
)
AS

cat_count number;
cat_combo exception;

BEGIN

select count(*) into cat_count from category where sub_category = x_subcat and category_main = x_categorymain;

if cat_count > 0 then
    raise cat_combo;
end if;

insert into category(category_id,sub_category,category_main)
values(seq_cat.nextval,x_subcat,x_categorymain);


exception
    when cat_combo then
        DBMS_OUTPUT.PUT_LINE('combination of sub_category and category_main already exists');

end cat_proc;

procedure proc_prod
(

x_price product.price%TYPE,
x_expiry product.expiry_date%TYPE,
x_productnm product.product_name%TYPE,
x_descrip product.description%TYPE,
x_brand product.brand%TYPE,
x_supid product.supplier_id%TYPE,
x_catid product.category_id%TYPE
)

AS
countcatidincat number;
countprod number;
pr_pricenull exception;
pr_expirynull exception;
pr_prodnamenull exception;
pr_descnull exception;
pr_brandnull exception;
pr_supidnull exception;
pr_catidnull exception;
pr_dupcol exception;
pr_countcatidincat exception;

BEGIN

if x_price is NULL
then raise pr_pricenull;
if x_expiry is NULL
then raise pr_expirynull;
if x_productnm is NULL
then raise pr_prodnamenull;
if x_descrip is NULL
then raise pr_descnull;
if x_brand is NULL
then raise pr_brandnull;
if x_supid is NULL
then raise pr_supidnull;
if x_catid is NULL
then raise pr_catidnull;

end if;
end if;
end if;
end if;
end if;
end if;
end if;

select count(*) into countcatidincat from category where category_id=x_catid ;
if countcatidincat < 1 then
	raise pr_countcatidincat ;
end if;
select count(*) into countprod from product where product_name = x_productnm;
if countprod > 0 then
    raise pr_dupcol;
end if;

insert into product(productid,upc_code,sku_code,price,expiry_date,product_name,description,brand,supplier_id,category_id)
values(seq_prod.nextval,seq_upc.nextval,seq_sku.nextval,x_price,x_expiry,x_productnm,x_descrip,x_brand,x_supid,x_catid);

EXCEPTION 
when pr_countcatidincat  then
     DBMS_OUTPUT.PUT_LINE('Categoryid invalid as it does not exist in category table');
when pr_pricenull then
     DBMS_OUTPUT.PUT_LINE('price value cannot be null');
when pr_expirynull then
     DBMS_OUTPUT.PUT_LINE('expiry date cannot be null');
when pr_prodnamenull then
     DBMS_OUTPUT.PUT_LINE('product name cannot be null');
when pr_descnull then
     DBMS_OUTPUT.PUT_LINE('description cannot be null');
when pr_brandnull then
     DBMS_OUTPUT.PUT_LINE('brand name cannot be null');
when pr_supidnull then
     DBMS_OUTPUT.PUT_LINE('supplier id cannot be null');
when pr_catidnull then
     DBMS_OUTPUT.PUT_LINE('category id cannot be null');
when pr_dupcol then
    DBMS_OUTPUT.PUT_LINE('that product already exists');

end proc_prod;

procedure proc_loc
(
  
  x_locname location.location_name%TYPE,
  x_locmgrid location.location_mgrid%TYPE
)

AS 

countloc number;
l_locname exception;
l_locmgrid exception;
l_dupcol exception;

BEGIN
if x_locname is NULL 
then raise l_locname;
if x_locmgrid is NULL
then raise l_locmgrid;
end if;
end if;

select count(*) into countloc from location where location_name = x_locname and location_mgrid = x_locmgrid;
if countloc > 0 then
    raise l_dupcol;
end if;

insert into location(locationno,location_name,location_mgrid)
values(seq_loc.nextval,x_locname,x_locmgrid);

EXCEPTION
when l_locname then 
    DBMS_OUTPUT.PUT_LINE('location name cannot be null');
when l_locmgrid then
    DBMS_OUTPUT.PUT_LINE('Manager Id cannot be null');
when l_dupcol then
    DBMS_OUTPUT.PUT_LINE('combination of location name and location manager id already exists');
end proc_loc;

procedure proc_dep
(
   
    x_deptname department.deptname%TYPE,
    x_deptadd department.deptaddress%TYPE,
    x_locationno department.locationno%TYPE
)

AS 
countdept number;
d_deptname exception;
d_deptadd exception;
d_locationno exception;
d_deptcol exception;



BEGIN

if x_deptname is NULL
then raise d_deptname;
if x_deptadd is NULL
then raise d_deptadd;
if x_locationno is NULL
then raise d_locationno;
end if;
end if;
end if;

select count(*) into countdept from department where deptname = x_deptname and deptaddress = x_deptadd and locationno = x_locationno;
if countdept > 0 then
    raise d_deptcol;
end if;

insert into department(deptno,deptname,deptaddress,locationno)
values(seq_dep.nextval,x_deptname,x_deptadd,x_locationno);

EXCEPTION

when d_deptname then 
    DBMS_OUTPUT.PUT_LINE('Department name cannot be null');
when d_deptadd then
    DBMS_OUTPUT.PUT_LINE('Department address cannot be null');
when d_locationno then
    DBMS_OUTPUT.PUT_LINE('Location cannot be null');   
when d_deptcol then
    DBMS_OUTPUT.PUT_LINE('combination of Department name, Department address and location number already exists');

end proc_dep;

procedure proc_emp
(
    x_empfirstname employees.firstname%TYPE,
    x_emplastname employees.lastname%TYPE,
    x_empgend employees.gender%TYPE,
    x_empdateofb employees.DOB%TYPE,
    x_empphnum employees.phnumber%TYPE,
    x_empaddss employees.address%TYPE,
    x_empem employees.email%TYPE,
    x_empsal employees.salary%TYPE,
    x_empdeptnum employees.deptno%TYPE,
    x_empmid employees.mgrid%TYPE
)

AS

    countfname number;
    countlname number;
    countgend number;
    countdob number;
    countph number;
    countem number;
    countdeptnum number;
    countmid number;
    countadds number;
    
    e_empfirstname exception;
    e_emplastname exception;
    e_empgend exception;
    e_empdateofb exception;
    e_empphnum exception;
    e_empem exception;
    e_empaddss exception;
    e_empdeptnum exception;
    e_empmid exception;
    e_invsal exception;
    e_empsal exception;
    e_empdupcol exception;
    e_empdupphno exception;
    e_empphnoint exception;

BEGIN

if x_empfirstname is NULL
then raise e_empfirstname;

if x_emplastname is NULL
then raise e_emplastname;

if x_empgend is NULL
then raise e_empgend;

if x_empdateofb is NULL
then raise e_empdateofb;

if is_numeric(x_empphnum)=0 THEN
    RAISE e_empphnoint;


if x_empphnum is NULL
then raise e_empphnum;

if x_empem is NULL 
then raise e_empem;

if x_empsal is NULL
then raise e_empsal;

if is_numeric(x_empsal)=0 THEN
    RAISE e_invsal;

if x_empaddss is NULL
then raise e_empaddss;

if x_empdeptnum is NULL
then raise e_empdeptnum;

if x_empmid is NULL
then raise e_empmid;

end if;
end if;
end if;
end if;
end if;
end if;
end if;
end if;
end if;
end if;
end if;
end if;

select count(*) into countph from employees where phnumber = x_empphnum;
if countph > 0 then
    raise e_empdupphno;
end if;

select count(*) into countem from employees where email = x_empem;
if countem > 0 then
    raise e_empdupcol;
end if;


insert into employees(empid,firstname,lastname,gender,DOB,phnumber,address,email,salary, deptno,mgrid)
values(seq_emp.nextval,x_empfirstname,x_emplastname,x_empgend,x_empdateofb,x_empphnum,x_empaddss,x_empem, x_empsal,x_empdeptnum,x_empmid);


EXCEPTION


when e_empphnoint then
    DBMS_OUTPUT.PUT_LINE('employee phone number can only be integers');
    
when e_empfirstname then
    DBMS_OUTPUT.PUT_LINE('First Name cannot be null');
    
when e_emplastname then
    DBMS_OUTPUT.PUT_LINE('Last Name cannot be null');

when e_empgend then
    DBMS_OUTPUT.PUT_LINE('Gender cannot be null');

when e_empdateofb then
    DBMS_OUTPUT.PUT_LINE('Date of Birth cannot be null');
    
when e_empphnum then
    DBMS_OUTPUT.PUT_LINE('Phone number cannot be null');
    
when e_empaddss then
    DBMS_OUTPUT.PUT_LINE('Address cannot be null');

when e_empem then
    DBMS_OUTPUT.PUT_LINE('Email cannot be null');

when e_empsal then
    DBMS_OUTPUT.PUT_LINE('salary cannot be null');

when e_invsal then
    DBMS_OUTPUT.PUT_LINE('salary can only be numeric');
when e_empdeptnum then
    DBMS_OUTPUT.PUT_LINE('Department number cannot be null');
    
when e_empmid then
    DBMS_OUTPUT.PUT_LINE('Manager Id cannot be null');

when e_empdupcol then
    DBMS_OUTPUT.PUT_LINE('email already exists');
    
when e_empdupphno then
    DBMS_OUTPUT.PUT_LINE('phone number already exists');
end proc_emp;

procedure proc_inventory
(
    x_inInventoryName inventory.inventory_name%TYPE,
    x_inStorageSpace inventory.storage_space%TYPE,
    x_invlocation inventory.invlocation%type
)

AS
    
    s_inInventoryName exception;
    s_inStorageSpace exception;
    s_inInventoryloc exception;
    
    
BEGIN

    if x_invlocation is NULL
    then raise s_inInventoryloc;   
    
    if x_inInventoryName is NULL
    then raise s_inInventoryName;
    
    if x_inStorageSpace is NULL
    then raise s_inStorageSpace;
    
    end if;
    end if;
    end if;
    
insert into inventory(inventory_id,inventory_name,storage_space, invlocation) 
values (seq_inventory.nextval,x_inInventoryName,x_inStorageSpace,x_invlocation);

EXCEPTION

when s_inInventoryName then
    DBMS_OUTPUT.PUT_LINE('Inventory name cannot be null');

when s_inStorageSpace then
    DBMS_OUTPUT.PUT_LINE('Storage Space details cannot be null');

when s_inInventoryloc then
    DBMS_OUTPUT.PUT_LINE('Inventory location cannot be null');

    
end proc_inventory;


procedure proc_inv_prod
(
    x_invInventoryId inventory_product.inventory_id%TYPE,
    x_invProductId inventory_product.productid%TYPE,
    x_invQuantity inventory_product.quantity%TYPE
)

AS
    countsuppid number:=0;
    countComb number:=0;
    s_invInventoryId exception;
    s_invProductId exception;
    s_invDupcol exception;
    s_countsuppid exception;
BEGIN
    
    if x_invInventoryId is NULL
    then raise s_invInventoryId;
    
    
    if x_invProductId is NULL
    then raise s_invProductId;
    

    

    end if;
    end if;
       
    
    select count(*) into countComb from inventory_product where inventory_id = x_invInventoryId and productid = x_invProductId;
    if countComb > 0 then
        raise s_invDupcol;
    end if;
    select count(*) into countsuppid from inventory where inventory_id = x_invInventoryId;
    if countsuppid < 1 then
        raise s_countsuppid;
    end if;

insert into inventory_product(inventory_id,productid,quantity)
values (x_invInventoryId,x_invProductId,x_invQuantity);

EXCEPTION

when s_invInventoryId then
    DBMS_OUTPUT.PUT_LINE('Inventory ID cannot be null');
    
when s_invProductId then
    DBMS_OUTPUT.PUT_LINE('Product ID cannot be null');
    
when s_invDupcol then
    DBMS_OUTPUT.PUT_LINE('The information of the product in the inventory already exists!');
when s_countsuppid then
    DBMS_OUTPUT.PUT_LINE('Supplier id does not exist');

end proc_inv_prod;

procedure proc_suppin
(
    x_supplierno supplier_inventory.supplierno%TYPE,
    x_inventid supplier_inventory.inventory_id%TYPE,
    x_prodid supplier_inventory.product_id%TYPE
)
AS

countsupnum number;
countsup number;
dupcolsup exception;
w_supnum exception;

BEGIN 
select count(*) into countsup from supplier_inventory where supplierno=x_supplierno and inventory_id =x_inventid;
if countsup > 0 then
    raise dupcolsup;
end if;

select count(*) into countsupnum from supplier where supplierno = x_supplierno;
if countsupnum < 1 then
    raise w_supnum ;
end if;    

insert into supplier_inventory(supplierno,inventory_id,product_id)
values (x_supplierno,x_inventid,x_prodid); 


EXCEPTION

when w_supnum then
    DBMS_OUTPUT.PUT_LINE('Supplier number invalid as it does not exist in supplier table');

when dupcolsup then
      DBMS_OUTPUT.PUT_LINE('combination of supplier number and inventory id already exists');
end proc_suppin

procedure proc_ret
(
    x_customid returns.customerid%TYPE,
    x_ordid returns.orderid%TYPE,
    x_produid returns.product_id%TYPE,
    x_quant returns.quantity%TYPE,
    x_partid returns.partnerid%TYPE
)

AS 
countprodret number;
countret number;
r_cusid exception;
r_orid exception;
r_proid exception;
r_quant exception;
r_parid exception;
r_dupcol exception;
r_countprodret exception;
BEGIN

if x_customid is NULL
then raise r_cusid;
if x_ordid is NULL
then raise r_orid;
if x_produid is NULL
then raise r_proid;
if x_quant is NULL
then raise r_quant;
if x_partid is NULL
then raise r_parid;

end if;
end if;
end if;
end if;
end if;

select count(*) into countret from returns where customerid = x_customid and orderid = x_ordid and product_id = x_produid;
if countret > 0 then
    raise r_dupcol;
end if;
select count(*) into countprodret from order_items where productid = x_produid and orderid = x_ordid;
if countprodret < 1 then
    raise r_countprodret;
end if;
insert into returns(returnid,customerid,orderid, product_id,quantity, partnerid)
values(seq_ret.nextval,x_customid,x_ordid,x_produid,x_quant,x_partid);

EXCEPTION

when r_countprodret then
    DBMS_OUTPUT.PUT_LINE('Unable to find product in your order, Please check your ordered products.');
when r_cusid then
    DBMS_OUTPUT.PUT_LINE('customer id cannot be null');
when r_orid then
    DBMS_OUTPUT.PUT_LINE('order id cannot be null');
when r_proid then
    DBMS_OUTPUT.PUT_LINE('product id cannot be null');
when r_quant then
    DBMS_OUTPUT.PUT_LINE('quantity cannot be null');
when r_parid then
    DBMS_OUTPUT.PUT_LINE('partner id cannot be null');
when r_dupcol then 
    DBMS_OUTPUT.PUT_LINE('customer id, order id and product id already exists');

end proc_ret;


procedure procgenorderid(
x_customerid orders.customerid%type,
x_deliveryaddress orders.delivery_address%TYPE
)
as
transidnum number:= seq_transaction.nextval;
orderidnum number := seq_orders.nextval;
countcustid number:=0;
s_customerid exception;
s_customeridnotfound exception;
s_deliveryaddressisnull exception;

begin
if x_customerid IS NULL
then raise s_customerid;
end if;

if x_deliveryaddress IS NULL
then raise s_deliveryaddressisnull;
end if;

select count(*) into countcustid from customers where customerid = x_customerid;
if countcustid<1 then
raise s_customeridnotfound;
end if;



insert into transactions(transaction_id,orderid)
values(transidnum, orderidnum);
insert into orders (orderid,customerid,delivery_address, transaction_id, order_date)
values(orderidnum, x_customerid, x_deliveryaddress, transidnum, sysdate);

DBMS_OUTPUT.PUT_LINE('Your orderid is '||to_char(orderidnum));

EXCEPTION
WHEN s_customerid THEN
    DBMS_OUTPUT.PUT_LINE('CUSTOMERID cannot be null');
WHEN s_customeridnotfound THEN
    DBMS_OUTPUT.PUT_LINE('CUSTOMERID cannot be FOUND please create a new customer account or insert correct customerid');
WHEN s_deliveryaddressisnull THEN
    DBMS_OUTPUT.PUT_LINE('please enter delivery address');    
    
end procgenorderid;


procedure procorder_items(
x_orderidins order_items.orderid%type,
x_productidins order_items.productid%type,
x_quantityins order_items.quantity%type
)
as
countorderid number := 0;
countproductid number := 0;
x_priceins order_items.product_price%type := getprice(x_productidins);
s_countorderid EXCEPTION;
s_countproductid EXCEPTION;
s_invquantity EXCEPTION;

begin

SELECT count(*) into countorderid from orders where orderid = x_orderidins;
if countorderid<1 then
raise s_countorderid;
end if;
SELECT count(*) into countproductid from product where productid = x_productidins;
if countproductid<1 then
raise s_countproductid;
end if;
IF x_quantityins < 1 THEN
RAISE s_invquantity;
end if;

insert into order_items(orderid, productid, quantity, product_price) 
values(x_orderidins, x_productidins, x_quantityins, x_priceins);

exception
    when s_countorderid then
        DBMS_OUTPUT.PUT_LINE('Orderid does not exist');
    when s_countproductid then
        DBMS_OUTPUT.PUT_LINE('Productid does not exist');
    when s_invquantity then
        DBMS_OUTPUT.PUT_LINE('Quantity cannot be 0');
end procorder_items;

procedure populateamount(
x_finorderid orders.orderid%type
)
as
countfinorderid number:=0;
finamount orders.amount%type := 0;
s_invalorderid exception;
begin
select count(*) into countfinorderid from orders where orderid = x_finorderid;
if countfinorderid < 1 then
raise s_invalorderid;
end if;

finamount:=getamount(x_finorderid);

UPDATE orders
set amount=finamount
where orderid=x_finorderid;


exception

    when s_invalorderid then
        DBMS_OUTPUT.PUT_LINE('Orderid does not exist');
        
end populateamount;


PROCEDURE assigndelipartner
(
x_transorderid deliveredby.orderid%type
)
AS
x_partnerid number:=getpartner;
Begin
INSERT INTO deliveredby(partner_id, orderid ) VALUES(x_partnerid, x_transorderid);
END assigndelipartner;


 PROCEDURE completetransaction(
x_transorderid transactions.orderid%type,
x_modeofpayment transactions.modeof_payment%type,
x_cardtype transactions.card_type%type,
x_cardnumber transactions.card_number%type,
x_cardexpirydate transactions.card_expirydate%type,
x_transaction_date transactions.transaction_date%type
)
AS
valueto_pass number;
paymentstate char :='Y';
counttransorder NUMBER:=0;
s_transorderid EXCEPTION;
s_transorderidnotexist EXCEPTION;
s_modeofpayment EXCEPTION;
s_modeofpaymentinv EXCEPTION;
s_cardtypeinv EXCEPTION;
s_cardtypenull EXCEPTION;
s_cardnumbernull EXCEPTION;
s_invcardnum EXCEPTION;
s_cardexpired EXCEPTION;
BEGIN

IF x_transorderid IS NULL THEN
    RAISE s_transorderid;
    
SELECT COUNT(*) INTO counttransorder
from transactions
where orderid=x_transorderid;

IF counttransorder<1 THEN
    RAISE s_transorderidnotexist;

IF x_modeofpayment IS NULL THEN
    RAISE s_modeofpayment;
    
IF x_modeofpayment NOT IN ('CREDIT','DEBIT') THEN
    RAISE s_modeofpaymentINV;
    
IF x_cardtype IS NULL THEN
    RAISE s_cardtypenull;  
IF x_cardtype NOT IN ('VISA','MASTERCARD') THEN
    RAISE s_cardtypeinv;
IF x_cardnumber IS NULL THEN
    RAISE s_cardnumbernull;  
IF is_numeric(x_cardnumber)=0 THEN
    RAISE s_invcardnum;
IF (TO_DATE(x_cardexpirydate,'MM-YY')-SYSDATE)<1 THEN
    RAISE s_cardexpired;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;



UPDATE transactions
SET modeof_payment=x_modeofpayment, card_type=x_cardtype, card_number=x_cardtype, transaction_date= sysdate, card_expirydate=x_cardexpirydate, payment_status = paymentstate
WHERE orderid=x_transorderid;
valueto_pass :=x_transorderid;
assigndelipartner(valueto_pass);

EXCEPTION

WHEN s_transorderid THEN
    DBMS_OUTPUT.PUT_LINE('Orderid CANNOT BE null');
WHEN s_transorderidnotexist THEN
    DBMS_OUTPUT.PUT_LINE('Orderid not generated yet');
WHEN s_modeofpayment THEN
    DBMS_OUTPUT.PUT_LINE('Mode of payment cant be null');
WHEN s_modeofpaymentinv THEN
    DBMS_OUTPUT.PUT_LINE('Mode of payment can only be either credit or debit');
WHEN s_cardtypeinv THEN
    DBMS_OUTPUT.PUT_LINE('card type can only be VISA OR MASTERCARD');
WHEN s_cardtypenull THEN
    DBMS_OUTPUT.PUT_LINE('card type cannot be null');
WHEN s_cardnumbernull THEN
    DBMS_OUTPUT.PUT_LINE('card number slot empty please enter card number');
WHEN s_invcardnum THEN
    DBMS_OUTPUT.PUT_LINE('card number is invalid and only be numeric');
WHEN s_cardexpired THEN
    DBMS_OUTPUT.PUT_LINE('Card is expired');

END completetransaction;


procedure proc_delorderitems
(
    x_orderid returns.orderid%TYPE,
    x_productid returns.product_id%TYPE
)

AS 
x_countorderid number:=0;
s_countorderid exception;
s_productid exception;
s_orderid exception;
BEGIN
IF x_orderid is null then
    raise s_orderid;
end if;
SELECT count(*) into x_countorderid FROM order_items where orderid= x_orderid and productid = x_productid;
if x_countorderid < 1 then
    raise s_countorderid;
end if;

delete from order_items WHERE orderid=x_orderid and productid= x_productid;
dbms_output.put_line('Product has been removed from your cart');

EXCEPTION
when s_orderid then
    dbms_output.put_line('Order id cannot be null');
when s_productid then
    dbms_output.put_line('Product id cannot be null');
WHEN s_countorderid then
    dbms_output.put_line('product not found in your cart');
end  proc_delorderitems;

VIEW EmployeeDetailsWithGreaterSalaryThanManagers AS
SELECT a.empid as employee_id, a.salary as employee_salary, b.empid as manager_id, b.salary as manager_salary  FROM employees a
join employees b on a.mgrid = b.empid 
where a.salary > b.salary;




VIEW expiredTransactionDetails AS 
SELECT * FROM transactions WHERE (card_expirydate - sysdate) < 0;




VIEW mostDissatisfiedCustomersView AS
SELECT  customerid, count(customerid) 
as return_frequency 
from returns 
group by customerid 
order by count(customerid) desc;



VIEW RecentProductExpiryDate AS
SELECT productid, product_name,brand, description,expiry_date from product where expiry_date < sysdate order by expiry_date desc;



VIEW MostPurchaseByCustomer AS
SELECT customerid, sum(amount) as total from orders group by customerid order by total desc;




VIEW MostReturnedProducts AS
SELECT product_id, count(*) as frequency from returns group by product_id;



VIEW TotalAmountByCity AS
SELECT customers.city,sum(orders.amount) as total from 
customers join orders on customers.customerid = orders.customerid
group by customers.city;




VIEW TotalAmountByCountry AS
SELECT customers.country,sum(orders.amount) as total 
from customers join orders on customers.customerid = orders.customerid
group by customers.country;



 VIEW CityOrdersByDate AS
SELECT customers.city,orders.order_date, orders.amount 
from customers join orders on customers.customerid = orders.customerid;



VIEW CustomerView AS
SELECT p.productid,p.product_name,p.brand,p.description,p.expiry_date,c.category_id,c.sub_category,c.category_main
from product p join category c on c.category_id = p.category_id;


VIEW InventoryDetails AS
SELECT i.inventory_id,i.inventory_name,i.storage_space,s.supplierno,Product_id from 
inventory i join supplier_inventory s on i.inventory_id = s.inventory_id;


 VIEW RecentOrders AS
SELECT orderid,customerid,amount,order_date from orders order by abs(order_date-sysdate) desc;


VIEW YearlyAndMonthlyOrderCount AS
SELECT  EXTRACT(year from order_date) year, EXTRACT (month from order_date) month, COUNT(orderid) order_count FROM orders
GROUP BY EXTRACT(YEAR FROM order_date),EXTRACT(MONTH FROM order_date) Order by year desc,month;


VIEW YearlySales AS
SELECT  EXTRACT(year from order_date) year, sum(amount) as total FROM orders
GROUP BY EXTRACT(YEAR FROM order_date) Order by year desc;



End everything;
