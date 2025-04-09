*&---------------------------------------------------------------------*
*& Include          ZMANEJO_ARCHIVO_RTORRES_TOP
*&---------------------------------------------------------------------*

* Declaración de variable.
DATA: gv_file TYPE rlgrap-filename,
      flags   TYPE abap_bool VALUE abap_true.

* Declaraciáón de tabla interna.
DATA: it_cliente     TYPE ZCLIENTES_ASC OCCURS 0 WITH HEADER LINE.
      