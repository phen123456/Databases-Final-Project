CREATE TABLE PR_Inventory_Ingredient (
  cost        decimal(5,2),
  ingredient_name      varchar2(15) not null, 
  primary key (ingredient_name)
);

CREATE TABLE PR_Location (
   franchise_ID char(9) not null,
   address varchar2(50) not null, 
   mgrssn char(9) not null,
   phone_number char(10)
);

CREATE TABLE PR_Menu_Location (
    franchise_ID char(9) not null,
    item varchar2(15) not null,
    primary key (franchise_ID, item)
);

ALTER TABLE PR_Location ADD (
  primary key (franchise_ID)
);

ALTER TABLE PR_Location ADD (
  foreign key (mgrssn) references PR_employee
);

ALTER TABLE PR_Menu_Location ADD (
    foreign key (item) references PR_Menu_Item,
    foreign key (franchise_ID) references PR_Location
);



--Insert/Delete into PR_CUSTOMERS table
INSERT INTO PR_CUSTOMERS (CUSTOMERID, PHONENUM, NAME, EMAIL) 
VALUES (123412899, 2069875353, 'Claire Bob', 'cbob@yahoo.com');

DELETE FROM PR_CUSTOMERS WHERE CUSTOMERID = 123412899;

--Insert into PR_EMPLOYEE TABLE
INSERT INTO PR_EMPLOYEE (FNAME, MINIT, LNAME, DOB, SSN, POSITION, HOURY_WAGE, WORKS_FOR)
VALUES ('Bruce', 'L', 'Willis', '16-MAR-64', 537987102, 'Cook', 17.5, 108665443);

--Insert into PR_Location
INSERT INTO PR_LOCATION (FRANCHISE_ID, ADDRESS, MGRSSN, PHONE_NUMBER)
VALUES (987123456, '710 Oak Street', 756283282, 8764538765);

--Insert into Inventory Ingredient
INSERT INTO PR_INVENTORY_INGREDIENT (COST, INGREDIENT_NAME) VALUES (3, 'NewWorld Salt');

--Insert into Menu Item
INSERT INTO PR_MENU_ITEM (CATEGORY, COST_OF_MATERIAL, ITEM, PRICE) VALUES ('Dinner', NULL, 'Burger', 6.99);

--Insert into Menu Item Ingredients
INSERT INTO PR_MENU_ITEM_INGREDIENTS (INGREDIENT, QUANTITY, MENU_ITEM) VALUES ('bun', 1, 'Burger');

--Insert into Menu Location
INSERT INTO PR_MENU_LOCATION (FRANCHISE_ID, ITEM) VALUES (987123456, 'Burger');

--Insert into Menu Transactions
INSERT INTO PR_MENU_TRANSACTIONS (TRANSACTID, Menu_Item, QUANTITY) VALUES (1, 'Burger', 1);

--Insert into Transactions
INSERT INTO PR_TRANSACTIONS (TRANSACTIONID, CUSTOMER, LOCATION, DATETRANSACTION, PAYMENTTYPE, PRICE) VALUES (1, 1, 987123456, '01-APR-23', 'Credit', 6.99);

DELETE FROM PR_TRANSACTIONS WHERE LOCATION = 987123456 AND CUSTOMER = 1 AND DATETRANSACTION = '01-APR-23';


--Retrieving Records
--Simple retreive all records from Transactions Table
select * from PR_Transactions;

--Select which menu items are at a certain location
select * from PR_MENU_LOCATION where franchise_id = 108665443;

--Select which menu items are at a certain location and list the franchise address
select F.address, M.item 
from PR_MENU_LOCATION M, PR_LOCATION F 
where F.franchise_id = 987123456 and M.franchise_id = F.franchise_id;

--Select name last name of employees who make above 16 
select LNAME from PR_Employee E, PR_Location L where L.FRANCHISE_ID = E.WORKS_FOR and E.HOURY_WAGE > 16;

--Update 
update PR_EMPLOYEE set position = 'Cook', HOURY_WAGE = 17.5 where SSN = 876111999;
select * from PR_Employee;









