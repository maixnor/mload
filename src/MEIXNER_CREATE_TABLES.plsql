CREATE OR REPLACE PROCEDURE PROC_MEIXNER_CREATE_TABLES IS
  v_tabcnt number;
BEGIN

  SELECT count(*) into v_tabcnt
  FROM   ALL_TABLES
  WHERE  OWNER = SCHEMA_NAME and
         TABLE_NAME = 'FACT_MEIXNER_RIDES_STAGING';

  if v_tabcnt = 0 then
      EXECUTE IMMEDIATE
            'CREATE TABLE FACT_MEIXNER_RIDES_STAGING
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
         TABLE_NAME = 'FACT_MEIXNER_RIDES';

  if v_tabcnt = 0 then
      EXECUTE IMMEDIATE
            'CREATE TABLE FACT_MEIXNER_RIDES
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
            )';
  end if;
END;
/
exit;


