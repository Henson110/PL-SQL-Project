--
--This program is to create views for Final Exam Dataset by using package, procedure and trigger
--
--Modification History
--When                      Who                     What
--2021/12/12           ts4271@nyu.edu              Second ceation

--------------------ts_fe_company_trigger-----------------------
create or replace trigger ts_fe_company_trigger
    before insert on ts_fe_company
    for each row
declare
    v_ts_fe_company_pk number;
    company_pk number;
begin  
    dbms_output.put_line('in trigger');
      --get next value
    if :new.company_pk is null then  
        select seq_ts_fe_company.nextval
        into v_ts_fe_company_pk
        from dual;
            --set the ZPK before doing insert 
        :new.company_pk := v_ts_fe_company_pk;
    end if;
end;

----------------------ts_fe_address_trigger---------------------
create or replace trigger ts_fe_address_trigger
    before insert on ts_fe_address
    for each row
declare
    v_ts_fe_address_pk number;
    address_pk number;
begin  
    dbms_output.put_line('in trigger');
      --get next value
    if :new.address_pk is null then  
        select seq_ts_fe_address.nextval
        into v_ts_fe_address_pk
        from dual;
            --set the ZPK before doing insert 
        :new.address_pk := v_ts_fe_address_pk;
    end if;
end;

----------------------ts_fe_phone_trigger--------------------
create or replace trigger ts_fe_phone_trigger
    before insert on ts_fe_phone
    for each row
declare
    v_ts_fe_phone_pk number;
    phone_pk number;
begin  
    dbms_output.put_line('in trigger');
      --get next value
    if :new.phone_pk is null then  
        select seq_ts_fe_phone.nextval
        into v_ts_fe_phone_pk
        from dual;
            --set the ZPK before doing insert 
        :new.phone_pk := v_ts_fe_phone_pk;
    end if;
end;

---------------------ts_fe_category_trigger---------------
create or replace trigger ts_fe_category_trigger
    before insert on ts_fe_category
    for each row
declare
    v_ts_fe_category_pk number;
    category_pk number;
begin  
    dbms_output.put_line('in trigger');
      --get next value
    if :new.category_pk is null then  
        select seq_ts_fe_category.nextval
        into v_ts_fe_category_pk
        from dual;
            --set the ZPK before doing insert 
        :new.category_pk := v_ts_fe_category_pk;
    end if;
end;

-------------------ts_fe_dba_trigger----------------------------
create or replace trigger ts_fe_dba_trigger
    before insert on ts_fe_dba
    for each row
declare
    v_ts_fe_dba_pk number;
    dba_pk number;
begin  
    dbms_output.put_line('in trigger');
      --get next value
    if :new.dba_pk is null then
        select seq_ts_fe_dba.nextval
        into v_ts_fe_dba_pk
        from dual;
            --set the ZPK before doing insert 
        :new.dba_pk := v_ts_fe_dba_pk;
    end if;
end;

-------------------ts_fe_dbaAndCat_trigger----------------------------
create or replace trigger ts_fe_dbaAndCat_trigger
    before insert on ts_fe_dbaAndCat
    for each row
declare
    v_ts_fe_dbaAndCat_pk number;
    dbaAndCat_pk number;
begin  
    dbms_output.put_line('in trigger');
      --get next value
    if :new.dbaAndCat_pk is null then
        select seq_ts_fe_dba.nextval
        into v_ts_fe_dbaAndCat_pk
        from dual;
            --set the ZPK before doing insert 
        :new.dbaAndCat_pk := v_ts_fe_dbaAndCat_pk;
    end if;
end;
