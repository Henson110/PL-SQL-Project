--
--This program is to create views for Final Exam Dataset by using package, procedure and trigger
--
--Modification History
--When                      Who                     What
--2021/12/12            ts4271@nyu.edu              Second ceation
--
create or replace package ts_fe_data
is
    procedure p_run_all;
end ts_fe_data;

create or replace package body ts_fe_data 
is
    procedure insert_company 
    is
    begin
        insert into ts_fe_company(company_name)
        select distinct company_name
        from ts_fe_stage
        where company_name is not null
        minus 
        select company_name from ts_fe_company;
    end;
    
    procedure insert_dba
    is
    begin  
        insert into ts_fe_dba(dba_name,company_fk)
        select 
            dba_name,
            (select company_pk from ts_fe_company compnay where compnay.company_name=stage.company_name and rownum=1) company_fk
        from (select distinct dba_name,company_name
        from ts_fe_stage where dba_name is not null) stage
        minus 
        select dba_name,company_fk
        from 
            ts_fe_dba;
    end;
    
    procedure insert_address
    is
    begin  
        insert into ts_fe_address(dba_fk1,address,city,state,zip)
        select 
            (select dba_pk from ts_fe_dba dba where dba.dba_name=stage.dba_name and rownum=1) dba_fk1,
            address,
            city,
            state,
            zip
        from (select distinct dba_name,company_name,address,city,state,zip
        from ts_fe_stage) stage
        minus 
        select dba_fk1,address,city,state,zip
        from ts_fe_address;
    end;
    
    procedure insert_phone
    is
    begin  
        insert into ts_fe_phone(phone,dba_fk2)
        select 
            phone,
            (select dba_pk from ts_fe_dba dba where dba.dba_name=stage.dba_name and rownum=1) dba_fk2
        from (select distinct phone,dba_name
        from ts_fe_stage  where phone is not null) stage
        minus 
        select phone,dba_fk2
        from ts_fe_phone;
    end;
    
    procedure insert_category
    is
    begin  
        insert into ts_fe_category(product_category)
        select distinct product_category
        from ts_fe_stage
        where product_category is not null
        minus 
        select product_category from ts_fe_category;
    end;
    
    procedure insert_dbaAndCat
    is
    begin  
        insert into ts_fe_dbaAndCat(dba_fk3,category_fk)
        select 
            (select dba_pk from ts_fe_dba dba where dba.dba_name=stage.dba_name and rownum=1) dba_fk3,
            (select category_pk from ts_fe_category category where category.product_category=stage.product_category and rownum=1) category_fk
        from (select distinct dba_name,product_category
        from ts_fe_stage) stage
        minus 
        select dba_fk3,category_fk
        from ts_fe_dbaAndCat;
    end;

    
    procedure p_run_all 
    is
    begin           
        insert_company;
        insert_dba;
        insert_address;
        insert_phone;
        insert_category;
        insert_dbaAndCat;       
    end;
    
end ts_fe_data;
