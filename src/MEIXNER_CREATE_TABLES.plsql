CREATE OR REPLACE PROCEDURE PROC_MEIXNER_CREATE_TABLES IS
  v_tabcnt number;
BEGIN

  SELECT count(*) into v_tabcnt
  FROM   ALL_TABLES
  WHERE  OWNER = SCHEMA_NAME and
         TABLE_NAME = 'FACT_MEIXNER_RIDES_STAGING';

  if v_tabcnt = 0 then
      EXECUTE IMMEDIATE
            'CREATE TABLE FACT_MEIXNER_RIDES_STAGING(
                VendorID int NOT NULL,
                tpep_pickup_datetime datetime NOT NULL,
                tpep_dropoff_datetime datetime NOT NULL,
                passenger_count int NOT NULL,
                trip_distance decimal(18, 0) NOT NULL,
                RatecodeID int NOT NULL,
                store_and_fwd_flag varchar(1) NOT NULL,
                payment_type int NOT NULL,
                fare_amount decimal(18, 0) NOT NULL,
                extra decimal(18, 0) NOT NULL,
                mta_tax decimal(18, 0) NOT NULL,
                tip_amount decimal(18, 0) NOT NULL,
                tolls_amount decimal(18, 0) NOT NULL,
                improvement_surcharge decimal(18, 0) NOT NULL,
                total_amount decimal(18, 0) NOT NULL,
                congestion_surcharge decimal(18, 0) NOT NULL
            )';
  end if;



  SELECT count(*) into v_tabcnt
  FROM   ALL_TABLES
  WHERE  OWNER = SCHEMA_NAME and
         TABLE_NAME = 'FACT_MEIXNER_RIDES';

  if v_tabcnt = 0 then
      EXECUTE IMMEDIATE
            'CREATE TABLE FACT_MEIXNER_RIDES(
                VendorID int NOT NULL,
                tpep_pickup_datetime datetime NOT NULL,
                tpep_dropoff_datetime datetime NOT NULL,
                passenger_count int NOT NULL,
                trip_distance decimal(18, 0) NOT NULL,
                RatecodeID int NOT NULL,
                store_and_fwd_flag varchar(1) NOT NULL,
                payment_type int NOT NULL,
                fare_amount decimal(18, 0) NOT NULL,
                extra decimal(18, 0) NOT NULL,
                mta_tax decimal(18, 0) NOT NULL,
                tip_amount decimal(18, 0) NOT NULL,
                tolls_amount decimal(18, 0) NOT NULL,
                improvement_surcharge decimal(18, 0) NOT NULL,
                total_amount decimal(18, 0) NOT NULL,
                congestion_surcharge decimal(18, 0) NOT NULL,
                actual_temp decimal(5,2) NOT NULL
            )';
  end if;
END;
/
exit;


