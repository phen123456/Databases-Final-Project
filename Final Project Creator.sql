--Created By: Anthony D'Antonio 3/30/2023
CREATE TABLE  pr_employee (
  fname varchar2(15) not null,
  minit varchar2(15),
  lname varchar2(15) not null,
  dob date not null,
  ssn char(9) not null,
  position varchar(20),
  houry_wage decimal(5,2),
  works_for char(9),
  primary key (ssn)
);

CREATE TABLE pr_menu_item (
    category varchar2(15) not null,
    cost_of_material decimal(5,2),
    item varchar2(15) not null,
    price decimal(5,2),
    primary key (item)
);

CREATE TABLE pr_menu_item_ingredients (
    ingredient varchar2(15) not null,
    quantity number(2),
    menu_item varchar2(15) not null,
    primary key(ingredient, menu_item)
    
);

ALTER TABLE pr_employee ADD (
  foreign key (works_for) references pr_location(franchise_id)
);

ALTER TABLE pr_menu_item_ingredients ADD (
  foreign key (ingredient) references pr_inventory_ingredient(ingredient_name),
  foreign key (menu_item) references pr_menu_item(item)

);

ALTER TABLE pr_menu_item_ingredients ADD (
  foreign key (menu_item) references pr_menu_item(item)
);

