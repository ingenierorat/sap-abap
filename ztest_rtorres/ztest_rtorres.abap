***Prueba de un ENDSELECT***

**DATA: lv_carrid TYPE s_carr_id,
**      lv_connid TYPE s_conn_id.
**
**
**SELECT carrid connid
**  FROM spfli
**  INTO (lv_carrid, lv_connid)
**  UP TO 1 ROWS
**  WHERE carrid = 'LH'.**
**
**  WRITE: / lv_carrid,lv_connid.
**
**ENDSELECT.

Ini----------------------------------------------------------------------------------------------------------Fin

***Loop con SELECT y endselect***

DATA: BEGIN OF st_spfli OCCURS 0,
        carrid TYPE s_carr_id,
        connid TYPE s_conn_id,
      END OF st_spfli.

SELECT *
  FROM spfli
  INTO CORRESPONDING FIELDS OF st_spfli
  WHERE carrid = 'LH'.

  WRITE: / st_spfli-carrid,
           st_spfli-connid.
ENDSELECT.