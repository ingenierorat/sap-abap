DATA: lt_result TYPE TABLE OF <estructura_resultado>.

SELECT t1~campo1,
       t1~campo2,
       t2~campo3
  INTO TABLE lt_result
  FROM tabla1 AS t1
  INNER JOIN tabla2 AS t2
  ON t1~campo_comun = t2~campo_comun
  WHERE t1~campo1 = 'valor_deseado'.