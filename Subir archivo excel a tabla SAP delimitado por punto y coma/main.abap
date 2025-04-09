*&---------------------------------------------------------------------*
*& Report ZMANEJO_ARCHIVO_RTORRES
*&---------------------------------------------------------------------*

************************************************************************
*  PROGRAM--INITIAL CREATION
*
*  Program name                         : ZMANEJO_ARCHIVO_RTORRES.
*----------------------------------------------------------------------*
*  Development specification ID         : REQ-0001.
*  Process team contact person          : Bryan Pena.
*  Date created                         : 22/08/2022.
*  Author                               : Rafael Torres.
*  Title                                : Subir archivo a tabla de BW.
*
*	DESCRIPTION:
*       1. Sube a una tabla de BW un archivo de Excel/txt,
*          esta a su vez serán procesados por otra funciones BW.
*
************************************************************************

REPORT zmanejo_archivo_rtorres
       NO STANDARD PAGE HEADING
       LINE-COUNT 40
       LINE-SIZE 50.

* Include a utilizar.
INCLUDE zmanejo_archivo_rtorres_top.
INCLUDE zmanejo_archivo_rtorres_sel.
INCLUDE zmanejo_archivo_rtorres_f01.

* Evento que inicia el programa.
START-OF-SELECTION.

* Elimina el analista actual.
  PERFORM delete_analy USING gv_anali.

* Sube el archivo a db.
  PERFORM upload_file  USING gp_delim.