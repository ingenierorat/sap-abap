*&---------------------------------------------------------------------*
*& Report ZHOLA_MUNDO_RTORRES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zhola_mundo_rtorres MESSAGE-ID zrtorres.

*Primera forma de usar la clase message
*MESSAGE i000(zrtorres).

*MESSAGE s000. "Segunda forma de la declaración de message, primero en la cebcera se declara "MESSAGE-ID zrtorres y luego se llama MESSAGE s000"

*Tercera forma de declaración sin clases.
MESSAGE 'Hola mundo' type 'I'.