create or replace function getprice(
varproductid number
)
return product.price%type
is
s_varproductprice number:=0;
BEGIN

SELECT price INTO s_varproductprice
from product
where productid = varproductid;

RETURN s_varproductprice;

END;
/


create or replace function getamount(
varorderid number
)
return orders.amount%type
is
s_varorderid number:=0;
BEGIN

SELECT price INTO s_varproductprice
from product
where productid = varproductid;

RETURN s_varproductprice;

END;
/


CREATE OR REPLACE FUNCTION is_numeric (str IN VARCHAR2)
  RETURN INT
IS
  v_num NUMBER;
BEGIN
  v_num:=TO_NUMBER(str);
  RETURN 1;
EXCEPTION
WHEN VALUE_ERROR THEN
  RETURN 0;
END is_numeric;
/


