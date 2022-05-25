load data 
infile 'TS_FE_DATA.csv' "str '\r\n'"
append
into table ts_fe_stage
fields terminated by ','
OPTIONALLY ENCLOSED BY '"' AND '"'
trailing nullcols
           ( COMPANY_NAME CHAR(4000),
             DBA_NAME CHAR(4000),
             ADDRESS CHAR(4000),
             CITY CHAR(4000),
             STATE CHAR(4000),
             ZIP,
             PHONE CHAR(4000),
             PRODUCT_CATEGORY CHAR(4000)
           )
