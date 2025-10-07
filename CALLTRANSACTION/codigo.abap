*&---------------------------------------------------------------------*
*& Report ZCALLTRANSACTION_USO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcalltransaction_uso.

*-- 1. Declaración de datos
DATA:
  bdcdata_tab TYPE TABLE OF bdcdata,  " Tabla BDC para los datos de pantalla
  bdcdata_wa  TYPE bdcdata,           " Área de trabajo para la tabla BDC
  messtab     TYPE TABLE OF bdcmsgcoll. " Tabla para capturar mensajes

*-- 2. Datos que queremos introducir en la transacción ZMBP
DATA:
  lv_rango_ini TYPE bdcdata-fval VALUE '7000',
  lv_rango_fin TYPE bdcdata-fval VALUE '10000',
  lv_monto_lim TYPE bdcdata-fval VALUE '2500',
  lv_benef_max TYPE bdcdata-fval VALUE '2500'.

*-- 3. Llenar la tabla BDC con la secuencia de pantallas y campos
*-- Pantalla inicial 1000 del programa ZSAP_PROGRAMA_MBP

CLEAR bdcdata_wa.
bdcdata_wa-program  = 'ZMB_PUNTO'. " <- ¡Usa el nombre real de tu programa!
bdcdata_wa-dynpro   = '1000'.              " <- ¡Usa el número real de tu dynpro!
bdcdata_wa-dynbegin = 'X'.                 " Marca el inicio de una nueva pantalla
APPEND bdcdata_wa TO bdcdata_tab.

*-- Rellenar los campos
PERFORM build_bdc_line USING 'p_insert' 'X'.                      " Seleccionar Radio Button 'Insertar'
PERFORM build_bdc_line USING 'p_ranini'   lv_rango_ini.           " Rellenar Rango inicio
PERFORM build_bdc_line USING 'p_ranfin'   lv_rango_fin.           " Rellenar Rango fin
PERFORM build_bdc_line USING 'p_monlim'   lv_monto_lim.           " Rellenar Monto límite
PERFORM build_bdc_line USING 'p_benmax'   lv_benef_max.           " Rellenar Beneficio máximo
PERFORM build_bdc_line USING 'BDC_OKCODE' '=ONLI'.                " Simular la ejecución (F8)

CALL TRANSACTION 'ZMBP' USING bdcdata_tab
                         MODE 'N'
                         UPDATE 'S'
                         MESSAGES INTO messtab.

*-- 5. Revisar el resultado y mostrar mensajes
LOOP AT messtab INTO DATA(wa_msg) WHERE msgtyp = 'E' OR msgtyp = 'A'.
  " Si encontramos un mensaje de Error (E) o Abortar (A), el proceso falló.
  MESSAGE wa_msg-msgv1 TYPE 'E'.
  RETURN. " Salimos del programa si hay error
ENDLOOP.

" Si el loop termina sin encontrar errores, la transacción fue exitosa.
MESSAGE 'La transacción ZMBP se ejecutó correctamente.' TYPE 'S'.


*-- Subrutina para hacer el código más limpio y reutilizable
FORM build_bdc_line USING    iv_fnam TYPE bdcdata-fnam
                             iv_fval TYPE bdcdata-fval.
  CLEAR bdcdata_wa.
  bdcdata_wa-fnam = iv_fnam.
  bdcdata_wa-fval = iv_fval.
  APPEND bdcdata_wa TO bdcdata_tab.

ENDFORM.