*&---------------------------------------------------------------------*
*& Report ZMANEJO_ARCHIVO_RTORRES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmanejo_archivo_rtorres
       NO STANDARD PAGE HEADING
       LINE-COUNT 40
       LINE-SIZE 30.

* Declaración de variable.
DATA: gv_file TYPE rlgrap-filename,
      flags   TYPE abap_bool VALUE abap_true.

* Declaraciáón de tabla interna.
DATA: it_cliente TYPE zclientes OCCURS 0 WITH HEADER LINE.

* Pantalla.
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.

  PARAMETERS: gp_delim TYPE c LENGTH 1. " Delimitador

SELECTION-SCREEN END OF BLOCK b1.

* Evento que inicia el programa.
START-OF-SELECTION.

* Buscar el nombre del archivo a cargar.
  CALL FUNCTION 'WS_FILENAME_GET'
    EXPORTING
      def_path         = 'C:\'
      mode             = 'O'   " S: SAVE, O: OPEN
      title            = 'Select input file name'
    IMPORTING
      filename         = gv_file
    EXCEPTIONS
      selection_cancel = 3
      OTHERS           = 5.

  IF sy-subrc <> 0.
    MESSAGE i002(sy) WITH 'Archivo no encontrado'.
  ENDIF.


* Subir archivo

  DATA: lv_raw TYPE TABLE OF string. " Variable local para manejar el archivo recibido.

  CALL FUNCTION 'UPLOAD'
    EXPORTING
      filename                = gv_file
      filetype                = 'ASC'
    TABLES
      data_tab                = lv_raw
    EXCEPTIONS
      conversion_error        = 1
      invalid_table_width     = 2
      invalid_type            = 3
      no_batch                = 4
      unknown_error           = 5
      gui_refuse_filetransfer = 6
      OTHERS                  = 7.
  IF sy-subrc <> 0.
    MESSAGE i002(sy) WITH 'Error al cargar el archivo'.
  ENDIF.

* Variable locales para manejar el archivo.
  DATA: lv_line  TYPE string,
        lt_field TYPE TABLE OF string.

* Recorrer el archivo y delimitar cada campo.
  LOOP AT lv_raw INTO lv_line.

    SPLIT lv_line AT gp_delim  INTO TABLE lt_field.

    READ TABLE lt_field INDEX 1 INTO it_cliente-id.
    READ TABLE lt_field INDEX 2 INTO it_cliente-nombre.

    APPEND it_cliente.

    IF sy-subrc EQ 0. " Validar si hubo algun error al momento de la validación.

      INSERT zclientes FROM it_cliente. " Inserta registro en la db.

      IF sy-subrc <> 0. " Valida si hay error de duplicado.
        flags = abap_false.
      ENDIF.

    ENDIF.

  ENDLOOP.

  IF flags = abap_false. " Si es false hay duplicado. De o contrario, todo fue bien.

    MESSAGE s002(sy) WITH 'Hay registros duplicados que no fueron insertado'.

  ELSE.

    MESSAGE s002(sy) WITH 'Registros insertados con éxito.'.

  ENDIF.