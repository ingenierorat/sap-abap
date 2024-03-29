*&---------------------------------------------------------------------*
*&  Include           ZCONTROL_COMPUTER_SEL
*&---------------------------------------------------------------------*



  SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-b01. " Pantalla principal

  SELECTION-SCREEN SKIP.

  SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME TITLE TEXT-b03. " Pantalla de opciones

  SELECTION-SCREEN BEGIN OF LINE. " odena elementos horizontal

  PARAMETERS pa_entr RADIOBUTTON GROUP rgb.
  SELECTION-SCREEN COMMENT (10) c_pa_ent.

  PARAMETERS pa_sal RADIOBUTTON GROUP rgb.
  SELECTION-SCREEN COMMENT (10) c_pa_sal.

  PARAMETERS pa_read RADIOBUTTON GROUP rgb.
  SELECTION-SCREEN COMMENT (10) c_pa_red.

  PARAMETERS pa_updt RADIOBUTTON GROUP rgb.
  SELECTION-SCREEN COMMENT (10) c_pa_upd.

  PARAMETERS pa_del RADIOBUTTON GROUP rgb.
  SELECTION-SCREEN COMMENT (10) c_pa_del.

  SELECTION-SCREEN END OF LINE.

  SELECTION-SCREEN END OF BLOCK b3.

  SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-b02.
  PARAMETERS: pa_cod   TYPE c LENGTH 15 OBLIGATORY,
              pa_desc  TYPE c LENGTH 50,
              pa_fecha TYPE zfecha,
              pa_npers TYPE c LENGTH 30,
              pa_centr TYPE zcentro.

  SELECTION-SCREEN END OF BLOCK b2.




  SELECTION-SCREEN END OF BLOCK b1.