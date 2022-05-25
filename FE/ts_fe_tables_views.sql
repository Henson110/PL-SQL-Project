--
--This program is to create views for Final Exam Dataset by using package, procedure and trigger
--
--Modification History
--When                      Who                     What
--2021/12/12            ts4271@nyu.edu              Second ceation

truncate table ts_fe_dbaAndCat;
truncate table ts_fe_address;
truncate table ts_fe_phone;
truncate table ts_fe_category;
truncate table ts_fe_dba;
truncate table ts_fe_company;
truncate table ts_fe_stage;

create table ts_fe_company(
    company_pk number not null,
    company_name varchar2(255) not null);
ALTER TABLE ts_fe_company
ADD CONSTRAINT ts_fe_company_pk PRIMARY KEY (company_pk);

create table ts_fe_dba(
    dba_pk number not null,
    company_fk number,
    dba_name varchar2(255) not null);
ALTER TABLE ts_fe_dba
ADD CONSTRAINT ts_fe_dba_pk PRIMARY KEY (dba_pk);
ALTER TABLE ts_fe_dba
ADD CONSTRAINT ts_fe_company_fk FOREIGN KEY (company_fk) REFERENCES ts_fe_company(company_pk);

create table ts_fe_address(
    address_pk number not null,
    dba_fk1 number,
    address varchar2(128),
    city varchar2(26),
    state varchar2(26),
    zip number(38));
ALTER TABLE ts_fe_address
ADD CONSTRAINT ts_fe_address_pk PRIMARY KEY (address_pk);
ALTER TABLE ts_fe_address
ADD CONSTRAINT ts_fe_dba_fk1 FOREIGN KEY (dba_fk1) REFERENCES ts_fe_dba(dba_pk);

create table ts_fe_phone(
    phone_pk number not null,
    dba_fk2 number,
    phone varchar2(255));
ALTER TABLE ts_fe_phone
ADD CONSTRAINT ts_fe_phone_pk PRIMARY KEY (phone_pk);
ALTER TABLE ts_fe_phone
ADD CONSTRAINT ts_fe_dba_fk2 FOREIGN KEY (dba_fk2) REFERENCES ts_fe_dba(dba_pk);

create table ts_fe_category(
    category_pk number not null,
    product_category varchar2(255));
alter table ts_fe_category 
add constraint ts_fe_category_pk primary key (category_pk);

create table ts_fe_dbaAndCat(
    dbaAndCat_pk number not null,
    dba_fk3 number,
    category_fk number);
ALTER TABLE ts_fe_dbaAndCat
ADD CONSTRAINT ts_fe_dbaAndCat_pk PRIMARY KEY (dbaAndCat_pk);
ALTER TABLE ts_fe_dbaAndCat
ADD CONSTRAINT ts_fe_dba_fk3 FOREIGN KEY (dba_fk3) REFERENCES ts_fe_dba(dba_pk);
ALTER TABLE ts_fe_dbaAndCat
ADD CONSTRAINT ts_fe_category_fk FOREIGN KEY (category_fk) REFERENCES ts_fe_category(category_pk);
  
create sequence seq_ts_fe_dba;
create sequence seq_ts_fe_category;
create sequence seq_ts_fe_phone;
create sequence seq_ts_fe_address;
create sequence seq_ts_fe_company;
create sequence seq_ts_fe_dbaAndCat;
drop sequence seq_ts_fe_dba;
drop sequence seq_ts_fe_category;
drop sequence seq_ts_fe_phone;
drop sequence seq_ts_fe_address;
drop sequence seq_ts_fe_company;
drop sequence seq_ts_fe_dbaAndCat;

select * from ts_fe_company;
select * from ts_fe_address;
select * from ts_fe_phone;
select * from ts_fe_category;
select * from ts_fe_dba;
select * from ts_fe_dbaAndCat;
select * from ts_fe_stage;
select count(*) from ts_fe_company;
select count(*) from ts_fe_address;
select count(*) from ts_fe_phone;
select count(*) from ts_fe_category;
select count(*) from ts_fe_dba;
select count(*) from ts_fe_dbaAndCat;
select count(*) from ts_fe_stage;

------------------------View of data----------------------------------
create or replace view ts_fe_view as
    select distinct ts_fe_dba.dba_name,ts_fe_address.address,ts_fe_address.city,ts_fe_address.state,ts_fe_address.zip,
    ts_fe_company.company_name,ts_fe_category.product_category
    from ts_fe_address
    full outer join ts_fe_dba on ts_fe_dba.dba_pk=ts_fe_address.dba_fk1
    full outer join ts_fe_company on ts_fe_dba.company_fk=ts_fe_company.company_pk
    full outer join ts_fe_dbaAndCat on ts_fe_dbaAndCat.dba_fk3=ts_fe_dba.dba_pk
    full outer join ts_fe_category on ts_fe_category.category_pk=ts_fe_dbaAndCat.category_fk;
select * from ts_fe_view;
select count(*) from ts_fe_view;

create or replace view ts_fe_view2 as
select distinct ts_fe_dba.dba_name,ts_fe_company.company_name,ts_fe_phone.phone
from ts_fe_company
full outer join ts_fe_dba on ts_fe_dba.company_fk=ts_fe_company.company_pk
full outer join ts_fe_phone on ts_fe_dba.dba_pk=ts_fe_phone.dba_fk2;

select count(*) from ts_fe_view2;

create or replace view ss as
    select distinct ts_fe_dba.dba_name,ts_fe_address.address,ts_fe_address.city,ts_fe_address.state,ts_fe_address.zip,
    ts_fe_company.company_name,ts_fe_category.product_category,ts_fe_phone.phone
    from ts_fe_address
    full outer join ts_fe_dba on ts_fe_dba.dba_pk=ts_fe_address.dba_fk1
    full outer join ts_fe_company on ts_fe_dba.company_fk=ts_fe_company.company_pk
    full outer join ts_fe_dbaAndCat on ts_fe_dbaAndCat.dba_fk3=ts_fe_dba.dba_pk
    full outer join ts_fe_category on ts_fe_category.category_pk=ts_fe_dbaAndCat.category_fk
    full outer join (select distinct phone from ts_fe_phone) ts_fe_phone on ts_fe_dba.dba_pk=ts_fe_phone.dba_fk2;
select count(*) from ss;