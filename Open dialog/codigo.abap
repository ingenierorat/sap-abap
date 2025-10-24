
PARAMETERS: p_file LIKE rlgrap-filename.




FORM f_call_open_dialog .

  CALL FUNCTION 'F4_FILENAME'
    EXPORTING
      program_name  = sy-repid
      dynpro_number = sy-dynnr
    IMPORTING
      file_name     = p_file.  "<-- nombre del parámetro

ENDFORM.

FORM f_cargar_archivo_txt .

  DATA: lv_file TYPE string.

  lv_file = p_file.

  CALL FUNCTION 'GUI_UPLOAD'
    EXPORTING
      filename                = lv_file
      filetype                = 'ASC'
    TABLES
      data_tab                = gt_file
    EXCEPTIONS
      file_open_error         = 1
      file_read_error         = 2
      no_batch                = 3
      gui_refuse_filetransfer = 4
      invalid_type            = 5
      no_authority            = 6
      unknown_error           = 7
      bad_data_format         = 8
      header_not_allowed      = 9
      separator_not_allowed   = 10
      header_too_long         = 11
      unknown_dp_error        = 12
      access_denied           = 13
      dp_out_of_memory        = 14
      disk_full               = 15
      dp_timeout              = 16
      OTHERS                  = 17.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDFORM.