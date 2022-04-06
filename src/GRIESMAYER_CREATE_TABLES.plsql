CREATE OR REPLACE PROCEDURE SALES.PROC_GRIESMAYER_CREATE_TABLES (SCHEMA_NAME IN VARCHAR2) IS
  v_tabcnt number;
BEGIN
  SELECT count(*) into v_tabcnt
  FROM   ALL_TABLES
  WHERE  OWNER = SCHEMA_NAME and
         TABLE_NAME = 'DIM_PRODUCT';

  if v_tabcnt = 0 then
      EXECUTE IMMEDIATE
            'CREATE TABLE ' || SCHEMA_NAME || '.DIM_PRODUCT
            (
                PRODUCT_ID     INTEGER      NOT NULL,
                PRODUCT_NAME   VARCHAR2(30) NOT NULL
            )';
  end if;
  
  
  
  SELECT count(*) into v_tabcnt
  FROM   ALL_TABLES
  WHERE  OWNER = SCHEMA_NAME and
         TABLE_NAME = 'DIM_SALES_CHANNEL';

  if v_tabcnt = 0 then
      EXECUTE IMMEDIATE
            'CREATE TABLE ' || SCHEMA_NAME || '.DIM_SALES_CHANNEL
            (
                SALES_CHANNEL  INTEGER      NOT NULL,
                CHANNEL        VARCHAR2(30) NOT NULL
            )';
  end if;



  SELECT count(*) into v_tabcnt
  FROM   ALL_TABLES
  WHERE  OWNER = SCHEMA_NAME and
         TABLE_NAME = 'DIM_SALES_TIME';

  if v_tabcnt = 0 then
      EXECUTE IMMEDIATE
            'CREATE TABLE ' || SCHEMA_NAME || '.DIM_SALES_TIME
            (
                SALES_HOUR  INTEGER      NOT NULL,
                TIME_OF_DAY VARCHAR2(30) NOT NULL
            )';
  end if;



  SELECT count(*) into v_tabcnt
  FROM   ALL_TABLES
  WHERE  OWNER = SCHEMA_NAME and
         TABLE_NAME = 'DIM_SALES_TIME';

  if v_tabcnt = 0 then
      EXECUTE IMMEDIATE
            'CREATE TABLE ' || SCHEMA_NAME || '.DIM_SALES_TIME
            (
                SALES_HOUR  INTEGER      NOT NULL,
                TIME_OF_DAY VARCHAR2(30) NOT NULL
            )';
  end if;



  SELECT count(*) into v_tabcnt
  FROM   ALL_TABLES
  WHERE  OWNER = SCHEMA_NAME and
         TABLE_NAME = 'DIM_CUSTOMER';

  if v_tabcnt = 0 then
      EXECUTE IMMEDIATE
            'CREATE TABLE ' || SCHEMA_NAME || '.DIM_CUSTOMER
            (
                CUSTOMER_ID INTEGER NOT NULL,
                FIRST_NAME VARCHAR2(30) NOT NULL,
                LAST_NAME  VARCHAR2(30) NOT NULL,
                GENDER     VARCHAR2(30) NOT NULL,
                COUNTRY    VARCHAR2(30) NOT NULL,
                CITY       VARCHAR2(30) NOT NULL
            )';
  end if;



  SELECT count(*) into v_tabcnt
  FROM   ALL_TABLES
  WHERE  OWNER = SCHEMA_NAME and
         TABLE_NAME = 'FACT_GRIESMAYER_SALES_STAGING';

  if v_tabcnt = 0 then
      EXECUTE IMMEDIATE
            'CREATE TABLE ' || SCHEMA_NAME || '.FACT_GRIESMAYER_SALES_STAGING
            (
                SALES_DATE     DATE    NOT NULL,
                SALES_TIME     INTEGER NOT NULL,
                SALES_CHANNEL  INTEGER NOT NULL,
                PRODUCT_ID     INTEGER NOT NULL,
                CUSTOMER_ID    INTEGER NOT NULL,
                PIECES         INTEGER NOT NULL,
                REVENUE        DECIMAL(12,2) NOT NULL,
                DISCOUNT       DECIMAL(12,2) NOT NULL,
                TAX            DECIMAL(12,2) NOT NULL
            )';
  end if;



  SELECT count(*) into v_tabcnt
  FROM   ALL_TABLES
  WHERE  OWNER = SCHEMA_NAME and
         TABLE_NAME = 'FACT_GRIESMAYER_SALES';

  if v_tabcnt = 0 then
      EXECUTE IMMEDIATE
            'CREATE TABLE ' || SCHEMA_NAME || '.FACT_GRIESMAYER_SALES
            (
                SALES_DATE     DATE    NOT NULL,
                SALES_TIME     INTEGER NOT NULL,
                SALES_CHANNEL  INTEGER NOT NULL,
                PRODUCT_ID     INTEGER NOT NULL,
                CUSTOMER_ID    INTEGER NOT NULL,
                PIECES         INTEGER NOT NULL,
                REVENUE        DECIMAL(12,2) NOT NULL,
                DISCOUNT       DECIMAL(12,2) NOT NULL,
                TAX            DECIMAL(12,2) NOT NULL,
                ACTUAL_TEMP    DECIMAL(5,2)  NOT NULL,
                CONSTRAINT PK_FACT_GRIESMAYER_SALES PRIMARY KEY (SALES_DATE, SALES_TIME, SALES_CHANNEL, PRODUCT_ID, CUSTOMER_ID)
            )';
  end if;
END;
/
exit;


