*&---------------------------------------------------------------------*
*& Report Z_CLASS_MESSAGE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_class_message.

* Definición de la clase.
CLASS lcl_message DEFINITION.

  PUBLIC SECTION.
    METHODS: mensaje IMPORTING im_nombre TYPE string, " Mensaje.
      constructor.                                    " Constructor.

  PRIVATE SECTION.
    DATA: nombre   TYPE string, " Nombre.
          apellido TYPE string. " Apellidos.

ENDCLASS.

* Implementación de la clase.
CLASS lcl_message IMPLEMENTATION.

  METHOD constructor.

    apellido = 'Torres'.

  ENDMETHOD.

  METHOD mensaje.

    DATA: lv_saludo TYPE string.

    nombre = im_nombre.

    CONCATENATE nombre apellido INTO lv_saludo SEPARATED BY space.

    WRITE: / 'Hola: ', lv_saludo.

  ENDMETHOD.


ENDCLASS.

START-OF-SELECTION.

  DATA: lr_menssage TYPE REF TO lcl_message. " Instancia el objeto.

  CREATE OBJECT lr_menssage. " Crea el objeto.

* Invocar el metodo.
  lr_menssage->mensaje( 'Rafael' ).