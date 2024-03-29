* Cargar los dato de la tabla interna
  PERFORM cargar_datos.
* Carga los datos de wa
  PERFORM cargar_wa.


* Case para elegir la opciòn correcta
  CASE abap_true.

    WHEN pa_entr.
      PERFORM entrada_pc.

    WHEN pa_sal.
      PERFORM salida_pc.

    WHEN pa_read.
      PERFORM read_pc.

    WHEN pa_updt.
     PERFORM update_pc.

     WHEN pa_del.
       PERFORM delete_pc.

    WHEN OTHERS.
     MESSAGE i016(zusert1).

  ENDCASE.