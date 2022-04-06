#!/bin/bash

sqlplus system/oracle @MEIXNER_CREATE_USER.sql
sqlplus meixner/oracle @MEIXNER_CREATE_TABLES.plsql
sqlplus meixner/oracle @MEIXNER_CREATE_TABLES.sql
sqlplus system/oracle @MEIXNER_RIGHTS.sql

for FILE_NAME in ../data/split_*.csv
do
    export BASE_NAME=`basename $FILE_NAME`
    export JUST_NAME=`echo $BASE_NAME | sed -e 's/\..*//'`
    echo $FILE_NAME
    echo $BASE_NAME
    echo $JUST_NAME
 
    sed -e 's/"//g' $FILE_NAME | sed -e 's/ ;/;/' | sed -e 's/,/./g' | dos2unix >../data/RIDES_MEIXNER.csv

    if [ `wc -l ../data/RIDES_MEIXNER.csv | sed -e 's/ .*//'` -lt 20000 ]
    then
       >&2 echo Missing data in file $FILE_NAME.
       >&2 echo The file has only `wc -l ../data/RIDES_MEIXNER.csv | sed -e 's/ .*//'` lines.
       exit 16
    fi

    sqlldr meixner/oracle skip=1 data=../data/RIDES_MEIXNER.csv control=meixner_sales_staging.ldr log=../log/$JUST_NAME.log bad=../log/$JUST_NAME.bad errors=20

    if [ $? -ne 0 ]
    then
       >&2 echo Wrong data in file $FILE_NAME.
       >&2 echo Check log ../log/$JUST_NAME.log
       exit 17
    fi

    export ACT_TEMP=`curl -k https://wetter.orf.at/oes/ | grep 'temperature' | head -n 1 | sed -e 's/[^>]*>//' | sed -e 's/&thinsp;.*//' | sed -e 's/&minus;/-/' | sed -e 's/,/./'`

    sqlplus meixner/oracle <<!
      INSERT INTO FACT_MEIXNER_RIDES
      SELECT VendorID,
             tpep_pickup_datetime,
             tpep_dropoff_datetime,
             passenger_count,
             trip_distance,
             RatecodeID,
             store_and_fwd_flag,
             payment_type,
             fare_amount,
             extra,
             mta_tax,
             tip_amount,
             tolls_amount,
             improvement_surcharge,
             total_amount,
             congestion_surcharge,
             $ACT_TEMP
      FROM   FACT_MEIXNER_RIDES_STAGING
      GROUP BY DATE, SALES_TIME, SALES_CHANNEL, PRODUCT_ID, CUSTOMER_ID;
      COMMIT;
      exit;
!
done

