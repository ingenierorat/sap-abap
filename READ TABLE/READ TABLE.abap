**Read table**

**TYPES: BEGIN OF st_spfli,
**         carrid TYPE s_carr_id,
**         connid type s_conn_id,
**       END OF st_spfli.
**
**DATA: it_spfli TYPE STANDARD TABLE OF st_spfli,
**      wa_spfli TYPE st_spfli.
**
**SELECT *
**  FROM spfli
**  INTO CORRESPONDING FIELDS OF TABLE it_spfli.
**
**
**  READ TABLE it_spfli WITH KEY carrid = 'LH' INTO wa_spfli.
**
**  WRITE:/10 wa_spfli-carrid,
**            wa_spfli-connid.