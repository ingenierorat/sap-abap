*&---------------------------------------------------------------------*
*& Report ZCONTRO_EXC_RTORRES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcontro_exc_rtorres.

DATA: resultado TYPE p DECIMALS 2,
      ref_exc   TYPE REF TO cx_root,
      error     TYPE string.

PARAMETERS: p_num1 TYPE i DEFAULT 10,
            p_num2 TYPE i DEFAULT 0.

TRY .

    resultado = p_num1 / p_num2.
    WRITE: / 'El resultado es : ' && resultado.

  CATCH cx_sy_zerodivide INTO ref_exc.
    error = ref_exc->get_text( ).
    MESSAGE 'No es posible:' && error TYPE 'I'.
ENDTRY.