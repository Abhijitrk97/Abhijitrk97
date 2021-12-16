create sequence seq_cust start with 1000
increment by 1;

set serveroutput ON;

create or replace procedure cust_proc
(
    x_fname customers.customer_fname%TYPE,
    x_lname customers.customer_lname%TYPE,
    x_gender customers.customer_gender%TYPE,
    x_phno customers.customer_phno%TYPE,
    x_email customers.customer_email%TYPE,
    x_dob customers.customer_DOB%TYPE,
    x_address customers.street_address%TYPE,
    x_aptno customers.apt_house_no%TYPE,
    x_city customers.city%TYPE,
    x_state customers.state%TYPE,
    x_country customers.country%TYPE,
    x_zip customers.zip%TYPE
)
AS

BEGIN
insert into customers(customerid,customer_fname,customer_lname,customer_gender,customer_phno,customer_email,customer_DOB,street_address,apt_house_no,city,state,country,zip)
values(seq_cust.nextval,x_fname,x_lname,x_gender,x_phno,x_email,x_dob,x_address,x_aptno,x_city,x_state,x_country,x_zip);

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Email cannot be repeated ');

end;
/




create sequence seq_dlvptn start with 1000
increment by 1;

set serveroutput ON;
create or replace procedure delprtn_proc 
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

end;
/







create sequence seq_supplier start with 1000
increment by 1;
set SERVEROUTPUT ON;

create or replace procedure proc_supplier 
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

end;
/ 





create sequence seq_cat start with 100
increment by 1;


set SERVEROUTPUT ON;


create or replace procedure cat_proc
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

end;

/







create sequence seq_orderitems start with 1000
increment by 1;
set SERVEROUTPUT ON;

create or replace procedure proc_ordersitems 
(
    x_orderitemsorderid order_items.orderid%TYPE,
    x_orderitemsproductid order_items.productid%TYPE,
    x_orderitemsquantity order_items.quantity%TYPE
)
AS

s_orderitemsorderidnull exception;
s_orderitemsproductid exception;
s_orderitemsquantity exception;

BEGIN




if x_orderitemsorderid is null then
  raise s_orderitemsorderidnull;
IF x_orderitemsproductid is null then
    raise s_orderitemsproductid;
IF x_orderitemsquantity is null then
    raise s_orderitemsquantity;
    
    
end if;
end if;
end if;



insert into order_items(orderid, productid,quantity)
values(x_orderitemsorderid,x_orderitemsproductid, x_orderitemsquantity);

EXCEPTION 
    when s_orderitemsorderidnull then
        DBMS_OUTPUT.PUT_LINE('Please fill all the details, orderid cannot be blank');
    when s_orderitemsproductid then
        DBMS_OUTPUT.PUT_LINE('Please fill productid');
    when s_orderitemsquantity then
        DBMS_OUTPUT.PUT_LINE('Enter quantity cannot be null');

end;
/ 




create sequence seq_dep start with 1
increment by 1;

set serveroutput on;
create or replace procedure proc_dep
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

end;
/








create sequence seq_loc start with 100
increment by 1;

set serveroutput on;
create or replace procedure proc_loc
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
end;
/





create or replace procedure proc_prod
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

countprod number;
pr_pricenull exception;
pr_expirynull exception;
pr_prodnamenull exception;
pr_descnull exception;
pr_brandnull exception;
pr_supidnull exception;
pr_catidnull exception;
pr_dupcol exception;

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

select count(*) into countprod from product where product_name = x_productnm;
if countprod > 0 then
    raise pr_dupcol;
end if;

insert into product(productid,upc_code,sku_code,price,expiry_date,product_name,description,brand,supplier_id,category_id)
values(seq_prod.nextval,seq_upc.nextval,seq_sku.nextval,x_price,x_expiry,x_productnm,x_descrip,x_brand,x_supid,x_catid);

EXCEPTION 
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

end;
/




create sequence seq_emp start with 1000
increment by 1;


create or replace procedure proc_emp
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
    e_empsal exception;
    e_empdupcol exception;
    e_empdupphno exception;

BEGIN

if x_empfirstname is NULL
then raise e_empfirstname;

if x_emplastname is NULL
then raise e_emplastname;

if x_empgend is NULL
then raise e_empgend;

if x_empdateofb is NULL
then raise e_empdateofb;

if x_empphnum is NULL
then raise e_empphnum;

if x_empem is NULL 
then raise e_empem;

if x_empsal is NULL
then raise e_empsal;

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

when e_empdeptnum then
    DBMS_OUTPUT.PUT_LINE('Department number cannot be null');
    
when e_empmid then
    DBMS_OUTPUT.PUT_LINE('Manager Id cannot be null');

when e_empdupcol then
    DBMS_OUTPUT.PUT_LINE('email already exists');
    
when e_empdupphno then
    DBMS_OUTPUT.PUT_LINE('phone number already exists');
end;
/






 create or replace procedure proc_inv_prod
(
    x_invInventoryId inventory_product.inventory_id%TYPE,
    x_invProductId inventory_product.productid%TYPE,
    x_invQuantity inventory_product.quantity%TYPE
)

AS
    countComb number;
    s_invInventoryId exception;
    s_invProductId exception;
    s_invDupcol exception;
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


insert into inventory_product(inventory_id,productid,quantity)
values (x_invInventoryId,x_invProductId,x_invQuantity);

EXCEPTION

when s_invInventoryId then
    DBMS_OUTPUT.PUT_LINE('Inventory ID cannot be null');
    
when s_invProductId then
    DBMS_OUTPUT.PUT_LINE('Product ID cannot be null');
    
when s_invDupcol then
    DBMS_OUTPUT.PUT_LINE('The information of the product in the inventory already exists!');


end;
/



create or replace procedure proc_suppin
(
    x_supplierno supplier_inventory.supplierno%TYPE,
    x_inventid supplier_inventory.inventory_id%TYPE,
    x_prodid supplier_inventory.product_id%TYPE
)
AS

countsup number;
dupcolsup exception;

BEGIN 
select count(*) into countsup from supplier_inventory where supplierno=x_supplierno and inventory_id =x_inventid;
if countsup > 0 then
    raise dupcolsup;
end if;

insert into supplier_inventory(supplierno,inventory_id,product_id)
values (x_supplierno,x_inventid,x_prodid); 

EXCEPTION
when dupcolsup then
      DBMS_OUTPUT.PUT_LINE('combination of supplier number and inventory id already exists');
end;
/



create or replace procedure proc_ret
(
    x_customid returns.customerid%TYPE,
    x_ordid returns.orderid%TYPE,
    x_produid returns.product_id%TYPE,
    x_quant returns.quantity%TYPE,
    x_partid returns.partnerid%TYPE
)

AS 

countret number;
r_cusid exception;
r_orid exception;
r_proid exception;
r_quant exception;
r_parid exception;
r_dupcol exception;

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

insert into returns(returnid,customerid,orderid, product_id,quantity, partnerid)
values(seq_ret.nextval,x_customid,x_ordid,x_produid,x_quant,x_partid);

EXCEPTION

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

end;
/




create sequence seq_inventory start with 100
increment by 1;

create or replace procedure proc_inventory
(
    x_inInventoryName inventory.inventory_name%TYPE,
    x_inStorageSpace inventory.storage_space%TYPE
)

AS
    
    s_inInventoryName exception;
    s_inStorageSpace exception;
    
    
BEGIN
    
    if x_inInventoryName is NULL
    then raise s_inInventoryName;
    
    if x_inStorageSpace is NULL
    then raise s_inStorageSpace;
    
    end if;
    end if;
    
insert into inventory(inventory_id,inventory_name,storage_space) 
values (seq_inventory.nextval,x_inInventoryName,x_inStorageSpace);

EXCEPTION

when s_inInventoryName then
    DBMS_OUTPUT.PUT_LINE('Inventory name cannot be null');

when s_inStorageSpace then
    DBMS_OUTPUT.PUT_LINE('Storage Space details cannot be null');
    
end;
/


 
