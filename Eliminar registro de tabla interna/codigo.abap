*&---------------------------------------------------------------------*
*& Report Z_TABLA_INTERNA_DELETE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_tabla_interna_delete.

DATA: git_factura TYPE STANDARD TABLE OF vbrk, " Tabla interna
      gwa_factura TYPE vbrk. " Àrea de trabajo

SELECT *
FROM vbrk
UP TO 5 ROWS
INTO TABLE git_factura.

WRITE / 'Recorrer la Tabla'.
LOOP AT git_factura INTO gwa_factura.
  WRITE: / gwa_factura-vbeln.
ENDLOOP.

SKIP 2. " Espacio

DELETE git_factura INDEX 4. " Borra el Index 4 de la lista
DELETE git_factura WHERE vbeln EQ 90000763. " Borra la factura que se le indique aqui
* DELETE TABLE git_factura FROM gwa_factura. " Esta es otra forma

WRITE / 'Recorrer la Tabla con los cambios'.

LOOP AT git_factura INTO gwa_factura.
  WRITE: / gwa_factura-vbeln.
ENDLOOP.

SKIP 2.