*&---------------------------------------------------------------------*
*& Report Z_UPLOAD_TO_APP_SERVER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_upload_to_app_server.

SELECTION-SCREEN: BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_file TYPE string DEFAULT 'C:\miarchivo.txt'  OBLIGATORY,
              p_name TYPE string DEFAULT 'abap_02.txt'.
SELECTION-SCREEN: END OF BLOCK b1.

* Poner el parametro de solo lectura.
AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN INTO DATA(ls_screen).

    IF ls_screen-name = 'P_FILE'.

      ls_screen-input = 0. " Lo hace solo de lectura.
      MODIFY SCREEN FROM ls_screen.

    ENDIF.

  ENDLOOP.

  CONSTANTS: c_app_path TYPE string VALUE '/usr/sap/trans/prueba1/'.

  TYPES: tt_bin TYPE STANDARD TABLE OF x255 WITH EMPTY KEY.

  DATA:
    lt_data TYPE tt_bin,
    lv_full TYPE string,
    lv_rc   TYPE sy-subrc.

  CALL METHOD cl_gui_frontend_services=>gui_upload
    EXPORTING
      filename = p_file           " Name of file
      filetype = 'BIN'            " File Type (ASCII, Binary)
    CHANGING
      data_tab = lt_data          " Transfer table for file contents
    EXCEPTIONS
      OTHERS   = 19.

  IF sy-subrc <> 0.
    MESSAGE i002(sy) WITH 'Error al leer el fichero'.
  ENDIF.

* Construir ruta completa en application server
  lv_full = c_app_path && p_name.

* Abrir dataset en App-Server
  OPEN DATASET lv_full FOR OUTPUT IN BINARY MODE.

  IF sy-subrc <> 0.

    MESSAGE i002(sy) WITH 'No se puede abrir el archivo en el servidor'.
    RETURN.

  ENDIF.

* Tranferir datos.
  LOOP AT lt_data INTO DATA(lx_line).

    IF lx_line IS NOT INITIAL.

      TRANSFER lx_line TO lv_full NO END OF LINE.

    ENDIF.

  ENDLOOP.

  CLOSE DATASET lv_full.

* Mensaje final
  MESSAGE |Archivo «{ p_name }» subido exitosamente a { c_app_path }| TYPE 'S'.