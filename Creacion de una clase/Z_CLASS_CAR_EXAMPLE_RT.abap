*&---------------------------------------------------------------------*
*& Report Z_CLASS_CAR_EXAMPLE_RT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_class_car_example_rt.

INCLUDE z_class_car_example_rt_cl.


CLASS lcl_car DEFINITION. " Definición de la clase.

  PUBLIC SECTION.
    METHODS:
      drive IMPORTING im_deiving_speed TYPE i,
      turn  IMPORTING im_direction     TYPE c,
      stop.

  PRIVATE SECTION.
    DATA: make          TYPE string, " Marca.
          model         TYPE string, " Modelo.
          color         TYPE string, " Color.
          driving_speed TYPE i.      " Velocidad.

ENDCLASS.

CLASS lcl_car IMPLEMENTATION. " Implementación de la clase

  METHOD drive.

    driving_speed = im_deiving_speed.
    WRITE: / 'La velocidad actual es:', driving_speed.

  ENDMETHOD.

  METHOD turn.

    IF im_direction EQ 'L'.

      WRITE: / 'Girando a la izquierda'.

    ELSE.
      WRITE: / 'Girando a la derecha'.

    ENDIF.

  ENDMETHOD.

  METHOD stop.

    driving_speed = 0.
    WRITE: / 'Detenido'.

  ENDMETHOD.


ENDCLASS.


START-OF-SELECTION.

DATA: lr_car TYPE REF TO lcl_car.

create OBJECT lr_car.

lr_car->drive( 55 ).
lr_car->turn( 'R' ).
lr_car->stop( ).