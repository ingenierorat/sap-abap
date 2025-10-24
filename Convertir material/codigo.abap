    CALL FUNCTION 'CONVERSION_EXIT_MATN1_INPUT'
            EXPORTING
              input        = keyfield-matnr
            IMPORTING
              output       = keyfield-matnr
            EXCEPTIONS
              length_error = 1
              OTHERS       = 2.
          IF sy-subrc <> 0.
* Implement suitable error handling here
          ENDIF.