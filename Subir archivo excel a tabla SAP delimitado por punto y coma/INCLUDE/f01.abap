*&---------------------------------------------------------------------*
*& Include          ZMANEJO_ARCHIVO_RTORRES_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form delete_analy
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM delete_analy USING p_anali TYPE zclientes_asc-zanalista.

  DATA: lv_name         TYPE string,
        lv_word         TYPE string,
        lv_words        TYPE TABLE OF string,
        lv_result       TYPE string.


  lv_name = p_anali.

* Dividir el nombre en palabras
  SPLIT lv_name AT space INTO TABLE lv_words.

  LOOP AT lv_words INTO lv_word.

*   Convertir cada palabra a minúsculas
    TRANSLATE lv_word TO LOWER CASE.

*   Convertir la primera letra a mayúsculas
    lv_word = to_upper( lv_word+0(1) ) && lv_word+1.

*   Concatenar las palabras de nuevo
    CONCATENATE lv_result lv_word INTO lv_result SEPARATED BY space.

  ENDLOOP.

  SHIFT lv_result LEFT DELETING LEADING space.

  DELETE FROM zclientes_asc WHERE zanalista EQ lv_result.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form upload_file
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM upload_file USING p_delim TYPE c.

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

    SPLIT lv_line AT p_delim  INTO TABLE lt_field.

    READ TABLE lt_field INDEX 1 INTO it_cliente-zcliente.
    READ TABLE lt_field INDEX 2 INTO it_cliente-zanalista.

    APPEND it_cliente.

    IF sy-subrc EQ 0. " Validar si hubo algun error al momento de la validación.*

      INSERT zclientes_asc FROM it_cliente. " Inserta registro en la db.

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

ENDFORM.