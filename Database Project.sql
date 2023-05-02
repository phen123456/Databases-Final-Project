--transactions customers
CREATE TABLE pr_transactions (
  transactionid varchar2(9) not null,
  customer char(9),
  location varchar2(50),
  datetransaction date,
  paymenttype varchar2(15),
  price decimal(6,0),
  primary key (transactionid),
  foreign key (customer) references pr_customers(customerid)
);
--DROP TABLE transactions;

CREATE TABLE pr_has (
  transactid   varchar2(9) not null,
  itemid varchar2(15) not null,
  menuitem varchar2(15),
  primary key (transactid,itemid),
  foreign key (transactid) references pr_transactions(transactionid),
  foreign key (itemid) references PR_MENU_ITEM(item)
);
--DROP TABLE has;

CREATE TABLE pr_customers (
  customerid char(9) not null,
  phonenum char(10),
  name varchar(15),
  email varchar(15),
  primary key(customerid)
);
--DROP TABLE customers;