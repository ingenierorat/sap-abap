*&---------------------------------------------------------------------*
*& Report ZCREAR_CARPETA_SISTEMA_RTORRES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcrear_carpeta_sistema_rtorres.

DATA: lv_directory TYPE string,
      lv_command   TYPE string,
      lv_result    TYPE string.

lv_directory = '/usr/sap/tmp/rat/'. " Ruta principal donde se creará la carpeta


* Comando para crear la carpeta en el sistema de archivo SAP.
lv_command = | mkdir -p  { lv_directory }|. " Para Windows, se debería usar md en lugar de (mkdir -p (UNIX/Linux.).

* Ejecutar el comando en el sistema operativo
CALL 'SYSTEM' ID 'COMMAND' FIELD lv_command
              ID 'RESULT'  FIELD lv_result.

IF lv_result IS INITIAL.

  WRITE: 'Carpeta creada exitosamente', lv_directory.

ELSE.

  WRITE: 'Error al crear la carpeta', lv_directory.

ENDIF.