*&---------------------------------------------------------------------*
*& Report ZCONTROL_COMPUTER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcontrol_computer.

INCLUDE zcontrol_computer_top. " Guarda las varibles globales y demas
INCLUDE zcontrol_computer_sel. " Guarda las definiciòn y deseño de la pantalla
INCLUDE zcontrol_computer_f01. " Guarda las rutinas a utilizar



* Inicializacion de variables y demàs
INITIALIZATION.
  c_pa_ent = TEXT-c01. " Entrada
  c_pa_sal = TEXT-c02. " Salida
  c_pa_red = TEXT-c03. " lectura
  c_pa_upd = TEXT-c04. " Actualizaciòn
  c_pa_del = TEXT-c05. " Borrar


* Evento al ejecutar la tecla f8 o el reloj
START-OF-SELECTION.

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