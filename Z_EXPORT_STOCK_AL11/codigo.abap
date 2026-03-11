*&---------------------------------------------------------------------*
*& Report Z_EXPORT_STOCK_AL11
*& Descripción: Exportación de Stock de Materiales a Servidor (AL11)
*&---------------------------------------------------------------------*
REPORT z_export_stock_al11.

TABLES: mara, mard.

" -----------------------------------------------------------------------
" PANTALLA DE SELECCIÓN
" -----------------------------------------------------------------------
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS: s_matnr FOR mara-matnr,      " Material
                  s_werks FOR mard-werks.      " Tienda / Centro
  " Ruta del archivo en el servidor de aplicaciones
  PARAMETERS: p_file TYPE string DEFAULT '/usr/sap/trans/prueba1/reporte_stock.txt' LOWER CASE.
SELECTION-SCREEN END OF BLOCK b1.

" -----------------------------------------------------------------------
" LÓGICA PRINCIPAL
" -----------------------------------------------------------------------

START-OF-SELECTION.

  " Extracción y consolidación de datos usando Open SQL moderno
  SELECT a~matnr,
         b~maktx,
         c~werks,
         SUM( c~labst ) AS total_stock
    FROM mara AS a
    INNER JOIN makt AS b ON a~matnr = b~matnr AND b~spras = @sy-langu
    INNER JOIN mard AS c ON a~matnr = c~matnr
    WHERE a~matnr IN @s_matnr
      AND c~werks IN @s_werks
    GROUP BY a~matnr, b~maktx, c~werks
  INTO TABLE @DATA(lt_stock).

  IF sy-subrc <> 0.
    MESSAGE 'No se encontraron datos de stock para los criterios ingresados.' TYPE 'I'.
    RETURN.
  ENDIF.

  " -----------------------------------------------------------------------
  " GENERACIÓN DEL ARCHIVO EN EL SERVIDOR (OPEN DATASET)
  " -----------------------------------------------------------------------
  OPEN DATASET p_file FOR OUTPUT IN TEXT MODE ENCODING DEFAULT.
  IF sy-subrc = 0.

    " Escribir cabecera del archivo alineada con anchos fijos
    DATA(lv_header) = |{ 'Material' WIDTH = 18 }\|{ 'Descripción' WIDTH = 40 }\|{ 'Tienda' WIDTH = 6 }\|{ 'Stock' WIDTH = 15 }|.
    TRANSFER lv_header TO p_file.

    " Procesar y escribir cada registro
    LOOP AT lt_stock INTO DATA(ls_stock).

      " Formatear el material para quitar los ceros a la izquierda en el TXT
      DATA(lv_matnr_out) = ls_stock-matnr.
      SHIFT lv_matnr_out LEFT DELETING LEADING '0'.

      " Construir la línea usando String Templates con anchos fijos y alineación
      DATA(lv_line) = |{ lv_matnr_out WIDTH = 18 ALIGN = LEFT }\|{ ls_stock-maktx WIDTH = 40 ALIGN = LEFT }\|{ ls_stock-werks WIDTH = 6 ALIGN = LEFT }\|{ ls_stock-total_stock WIDTH = 15 ALIGN = RIGHT }|.

      TRANSFER lv_line TO p_file.
    ENDLOOP.

    CLOSE DATASET p_file.

    " Obtener la cantidad total de registros de la tabla interna
    DATA(lv_registros) = lines( lt_stock ).

    " Enviar mensaje de éxito dinámico con String Templates
    MESSAGE |Archivo generado exitosamente. Total de registros: { lv_registros }| TYPE 'S'.
  ELSE.
    MESSAGE 'Error al intentar crear el archivo en la ruta especificada.' TYPE 'E'.
  ENDIF.