 METHOD empleadoset_get_entityset.
**TRY.
*CALL METHOD SUPER->EMPLEADOSET_GET_ENTITYSET
*  EXPORTING
*    IV_ENTITY_NAME           =
*    IV_ENTITY_SET_NAME       =
*    IV_SOURCE_NAME           =
*    IT_FILTER_SELECT_OPTIONS =
*    IS_PAGING                =
*    IT_KEY_TAB               =
*    IT_NAVIGATION_PATH       =
*    IT_ORDER                 =
*    IV_FILTER_STRING         =
*    IV_SEARCH_STRING         =
**    io_tech_request_context  =
**  IMPORTING
**    et_entityset             =
**    es_response_context      =
*    .
**  CATCH /iwbep/cx_mgw_busi_exception.
**  CATCH /iwbep/cx_mgw_tech_exception.
**ENDTRY.


    " Estructura de datos para la tabla final.
    TYPES:
      BEGIN OF ts_empleado_base,
        CodigoEmpleado           TYPE pernr_d,
        NombreEmpleado           TYPE pad_vorna,
        Cedula                   TYPE prdni,
        FechaAlta                TYPE datum,
        FechaNacimiento_Original TYPE datum,
        CorreoEmpleado           TYPE ad_smtpadr,
        Direccion                TYPE string,
        CentroCostoT             TYPE ltext,
        Posicion                 TYPE stext,
        Departamento             TYPE stext,
        " --- NUEVOS CAMPOS DEL SUPERVISOR ---
        Supervisor               TYPE pad_vorna,
        CodigoSupervisor         TYPE pernr_d,
        CorreoSupervisor         TYPE ad_smtpadr,
        Area                     TYPE name1,
        DiasPendientes           TYPE i, 
        Extension                TYPE string,
        Flota                    TYPE string,
        Gerencia                 TYPE stext,
        " --- Campos ID necesarios para las búsquedas ---
        costl                    TYPE kostl,
        plans                    TYPE plans,
        orgeh                    TYPE orgeh,
        werks                    TYPE werks_d, " <-- NUEVO ID

      END OF ts_empleado_base.

    TYPES: BEGIN OF ty_jerarquia,
             plvar TYPE plvar,
             otype TYPE otype,
             objid TYPE objid,
             begda TYPE begdatum,
             endda TYPE enddatum,
             istat TYPE istat_d,
             histo TYPE histo,
             short TYPE short_d,
             stext TYPE stext,
             realo TYPE pd_objid_r,
             level TYPE i, " <-- Campo adicional para el nivel
           END OF ty_jerarquia.

    DATA: lt_jerarquia TYPE TABLE OF ty_jerarquia,
          ls_jerarquia TYPE ty_jerarquia.

    " Declaración de la tabla final.
    DATA: lt_empleados_final TYPE TABLE OF ts_empleado_base.

    " Nuevo rango de subtipos para una solo consulta.
    TYPES: ty_range_subty TYPE RANGE OF subty.

    " Procesar el filtro (Ejemplo con CodigoEmpleado).
    DATA lt_range_empleado TYPE RANGE OF pernr_d.

    LOOP AT it_filter_select_options INTO DATA(ls_filter).

      LOOP AT ls_filter-select_options INTO DATA(ls_option).

        CASE ls_filter-property.

          WHEN 'CodigoEmpleado'.
            APPEND VALUE #( sign   = ls_option-sign
                            option = ls_option-option
                            low    = ls_option-low
                            high   = ls_option-high ) TO lt_range_empleado.
        ENDCASE.
      ENDLOOP.
    ENDLOOP.

    " Leer datos de las tablas principales.
    SELECT
        pa1~pernr AS CodigoEmpleado,
        pa2~vorna AS NombreEmpleado,
        pa2~perid AS Cedula,
        pa1~begda AS FechaAlta, " Fecha de alta en la posición
        pa2~gbdat AS FechaNacimiento_Original, " Fecha de nacimiento.
        pa1~kostl AS costl, " <-- ID del Centro de Costo
        pa1~plans AS plans, " <-- ID de la Posición
        pa1~orgeh AS orgeh, " <-- ID de la Unidad Organizativa
        pa1~werks AS werks  " <-- ID del Área de Personal
        INTO TABLE @DATA(lt_empleados_temp) " Usamos una tabla temporal.
        FROM pa0001 AS pa1
        INNER JOIN pa0002 AS pa2 ON pa1~pernr = pa2~pernr
        WHERE pa1~pernr IN @lt_range_empleado.

    IF lt_empleados_temp IS INITIAL. " Si la tabla esta vacia, retorna.
      RETURN.
    ENDIF.

    " Prepara la lista de subtipos que queremos buscar
    DATA(lt_subtipos) = VALUE ty_range_subty(
      ( sign = 'I' option = 'EQ' low = '0010' )      " Email.
      ( sign = 'I' option = 'EQ' low = 'BEEP' )      " Extensión.
      ( sign = 'I' option = 'EQ' low = 'BEEP' )      " Flota.
    ).

    " Lee TODOS los datos de comunicación de una vez
    SELECT pernr, subty, usrid_long, usrid FROM pa0105
      INTO TABLE @DATA(lt_comunicaciones)
      FOR ALL ENTRIES IN @lt_empleados_temp
      WHERE pernr = @lt_empleados_temp-CodigoEmpleado
        AND subty IN @lt_subtipos
        AND endda = '99991231'. " Solo el empleado que este activo.

    " Leer direcciones de la tabla PA0006.
    SELECT pernr, stras, ort01 FROM pa0006
      INTO TABLE @DATA(lt_direcciones)
      FOR ALL ENTRIES IN @lt_empleados_temp
      WHERE pernr = @lt_empleados_temp-CodigoEmpleado
        AND subty = '1' " Subtipo estándar para 'Dirección permanente'
        AND endda = '99991231'.

    " Leer textos de Centros de Costo de la tabla CSKT.
    SELECT ktext, kostl FROM cskt
      INTO TABLE @DATA(lt_textos_cc)
      FOR ALL ENTRIES IN @lt_empleados_temp
      WHERE spras = @sy-langu
        AND kostl = @lt_empleados_temp-costl.

    " Leer textos de Posiciones y Unidades Organizativas de HRP1000.
    SELECT stext, objid FROM hrp1000
      INTO TABLE @DATA(lt_textos_om)
      FOR ALL ENTRIES IN @lt_empleados_temp
      WHERE plvar = '01' " Versión del plan activa
        AND otype IN ('S', 'O') " S=Posición, O=Unidad Organizativa
        AND ( objid = @lt_empleados_temp-plans OR
              objid = @lt_empleados_temp-orgeh ).

    " Encontrar la POSICIÓN del supervisor (Relación A002 "reporta a")
    SELECT objid, sobid FROM hrp1001
      INTO TABLE @DATA(lt_rel_sup_pos)
      FOR ALL ENTRIES IN @lt_empleados_temp
      WHERE otype = 'S' " El objeto es una Posición
        AND objid = @lt_empleados_temp-plans " La posición del empleado
        AND rsign = 'A' AND relat = '002'   " Relación A002 = reporta a
        AND endda >= @sy-datum AND begda <= @sy-datum.

    " Encontrar al EMPLEADO que ocupa la posición de supervisor (Relación B008 "es titular de")
    IF lt_rel_sup_pos IS NOT INITIAL.
      SELECT objid, sobid FROM hrp1001
        INTO TABLE @DATA(lt_rel_holder)
        FOR ALL ENTRIES IN @lt_rel_sup_pos
        WHERE otype = 'P' " El objeto es una Persona (PERNR)
          AND rsign = 'B' AND relat = '008' " Relación B008 = es titular de
          AND sobid = @lt_rel_sup_pos-sobid " La posición del supervisor que encontramos
          AND endda >= @sy-datum AND begda <= @sy-datum.
    ENDIF.

    " Obtener los DATOS del supervisor (Nombre y Correo)
    IF lt_rel_holder IS NOT INITIAL.
      SELECT pernr, vorna FROM pa0002
        INTO TABLE @DATA(lt_sup_nombres)
        FOR ALL ENTRIES IN @lt_rel_holder
        WHERE pernr = @lt_rel_holder-objid
          AND endda = '99991231'.

      SELECT pernr, usrid_long AS CorreoSupervisor FROM pa0105
        INTO TABLE @DATA(lt_sup_correos)
        FOR ALL ENTRIES IN @lt_rel_holder
        WHERE pernr = @lt_rel_holder-objid
          AND subty = '0010'
          AND endda = '99991231'.
    ENDIF.

    " Lectura para texto de Area
    SELECT persa, name1 FROM t500p
      INTO TABLE @DATA(lt_areas_texto)
      FOR ALL ENTRIES IN @lt_empleados_temp
      WHERE persa = @lt_empleados_temp-werks.

    " Leer Días Pendientes de Vacaciones (PA2006)
    SELECT pernr, anzhl FROM pa2006
      INTO TABLE @DATA(lt_vacaciones)
      FOR ALL ENTRIES IN @lt_empleados_temp
      WHERE pernr = @lt_empleados_temp-CodigoEmpleado
        AND subty = '75' " <-- VERIFICA ESTE SUBTIPO! Es el de contingente de vacaciones.
        AND endda >= @sy-datum AND begda <= @sy-datum.

    " Leer Extensión telefónica (PA0105)
    SELECT pernr, usrid AS Extension FROM pa0105
      INTO TABLE @DATA(lt_extensiones)
      FOR ALL ENTRIES IN @lt_empleados_temp
      WHERE pernr = @lt_empleados_temp-CodigoEmpleado
        AND subty = 'CELL' " <-- VERIFICA ESTE SUBTIPO! Es el de teléfono del trabajo.
        AND endda = '99991231'.

    " Unir toda la información
    lt_empleados_final = CORRESPONDING #( lt_empleados_temp ).

    " Ahora, recorremos la tabla final para asignar los datos.
    LOOP AT lt_empleados_final ASSIGNING FIELD-SYMBOL(<fs_empleado>).

      " Asignar Correo
      READ TABLE lt_comunicaciones INTO DATA(ls_comm_email)
                                   WITH KEY pernr = <fs_empleado>-CodigoEmpleado
                                            subty = '0010'. " Correo.
      IF sy-subrc = 0.
        <fs_empleado>-CorreoEmpleado = ls_comm_email-usrid_long.
      ENDIF.

      " Asignar Extensión
      READ TABLE lt_comunicaciones INTO DATA(ls_comm_ext)
                                   WITH KEY pernr = <fs_empleado>-CodigoEmpleado
                                            subty = 'BEEP'. " Extensión.
      IF sy-subrc = 0.
        <fs_empleado>-Extension = ls_comm_ext-usrid.
      ENDIF.

      " Asignar Flota
      READ TABLE lt_comunicaciones INTO DATA(ls_comm_flota)
                                   WITH KEY pernr = <fs_empleado>-CodigoEmpleado
                                            subty = 'BEEP'. " Flota.
      IF sy-subrc = 0.
        <fs_empleado>-Flota = ls_comm_flota-usrid.
      ENDIF.

      " Leemos la tabla de dirreciones para el empleado actual
      READ TABLE lt_direcciones INTO DATA(ls_direccion)
                                WITH KEY pernr = <fs_empleado>-CodigoEmpleado.
      IF sy-subrc = 0.

        " Concatenamos la calle y la ciudad para formar la dirección completa
        CONCATENATE ls_direccion-stras ls_direccion-ort01 INTO <fs_empleado>-Direccion SEPARATED BY ', '.

      ENDIF.

      " Asignar Centro de Costo
      READ TABLE lt_textos_cc INTO DATA(ls_texto_cc) WITH KEY kostl = <fs_empleado>-costl.
      IF sy-subrc = 0.
        <fs_empleado>-CentroCostoT = ls_texto_cc-kostl.
      ENDIF.

      " Asignar texto de Posición
      READ TABLE lt_textos_om INTO DATA(ls_texto_om_s) WITH KEY objid = <fs_empleado>-plans.
      IF sy-subrc = 0.
        <fs_empleado>-Posicion = ls_texto_om_s-stext.
      ENDIF.

      " Asignar texto de Departamento (Unidad Organizativa)
      READ TABLE lt_textos_om INTO DATA(ls_texto_om_o) WITH KEY objid = <fs_empleado>-orgeh.
      IF sy-subrc = 0.
        <fs_empleado>-Departamento = ls_texto_om_o-stext.
      ENDIF.

      " Nuevas asignación para los datos del supervisor.
      READ TABLE lt_rel_sup_pos INTO DATA(ls_rel_sup) WITH KEY objid = <fs_empleado>-plans.
      IF sy-subrc = 0.

        READ TABLE lt_rel_holder INTO DATA(ls_holder) WITH KEY sobid = ls_rel_sup-sobid.
        IF sy-subrc = 0.
          <fs_empleado>-CodigoSupervisor = ls_holder-objid. " Asignamos el código

          " Buscamos y asignamos el nombre del supervisor
          READ TABLE lt_sup_nombres INTO DATA(ls_sup_nombre) WITH KEY pernr = ls_holder-objid.
          IF sy-subrc = 0.
            <fs_empleado>-Supervisor = ls_sup_nombre-vorna.
          ENDIF.

          " Buscamos y asignamos el correo del supervisor.
          READ TABLE lt_sup_correos INTO DATA(ls_sup_correo) WITH KEY pernr = ls_holder-objid.
          IF sy-subrc = 0.
            <fs_empleado>-CorreoSupervisor = ls_sup_correo-CorreoSupervisor.
          ENDIF.
        ENDIF.
      ENDIF.

      " Asignación de Area.
      READ TABLE lt_areas_texto INTO DATA(ls_area_texto)
                                WITH KEY persa = <fs_empleado>-werks.
      IF sy-subrc = 0.
        <fs_empleado>-Area = ls_area_texto-name1.
      ENDIF.

      " Asignar Días Pendientes.
      READ TABLE lt_vacaciones INTO DATA(ls_vacaciones)
                               WITH KEY pernr = <fs_empleado>-CodigoEmpleado.
      IF sy-subrc = 0.
        <fs_empleado>-DiasPendientes = ls_vacaciones-anzhl.
      ENDIF.

      " --- NUEVA LÓGICA PARA ENCONTRAR LA GERENCIA ---
      " Usaremos un Módulo de Funciones para escalar la jerarquía organizativa.
      IF <fs_empleado>-orgeh IS NOT INITIAL.
        CALL FUNCTION 'RH_STRUC_GET'
          EXPORTING
            act_otype      = 'O' " Empezamos desde una Unidad Organizativa (O)
            act_objid      = <fs_empleado>-orgeh " El ID del departamento del empleado
            act_wegid      = 'O-O_LINE' " <-- RUTA DE EVALUACIÓN CLAVE (jerarquía de Unidades Org.)
          TABLES
            result_tab     = lt_jerarquia
          EXCEPTIONS
            no_plvar_found = 1
            no_entry_found = 2
            OTHERS         = 3.

        IF sy-subrc = 0.
          " La función devuelve una tabla con la jerarquía. El nivel 1 es el departamento actual,
          " el nivel 2 es el padre directo (probablemente la Gerencia), el nivel 3 es el abuelo, etc.
          " Buscamos el primer nivel superior (nivel 2).
          READ TABLE lt_jerarquia INTO ls_jerarquia WITH KEY level = 2.
          IF sy-subrc = 0.
            " Asignamos el nombre de esa unidad organizativa encontrada.
            <fs_empleado>-Gerencia = ls_jerarquia-stext.
          ENDIF.
        ENDIF.
      ENDIF.

    ENDLOOP.

    " Asignar resultado final
    et_entityset = CORRESPONDING #( lt_empleados_final ).

  ENDMETHOD.