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









