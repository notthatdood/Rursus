/*
 * Gramatica.c
 *
 * 2023/01/17 18:04:38
 *
 * Archivo generado por GikGram 2.0
 *
 * Copyright © Olminsky 2011 Derechos reservados
 * Reproducción sin fines de lucro permitida
 */
#include "Gramatica.h"

/* Tabla de parsing */
const int TablaParsing[35][NO_TERMINAL_INICIAL] =
{
	/* <S> */ {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	/* <seccion> */ {7,7,7,7,7,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,6,-1,-1,7,-1,7,7,-1,7,-1,7,7,-1,-1,7,-1,-1,7,7,-1,-1,-1,-1,-1,1,2,3,4,5,7,7,7,7,-1,-1,-1,-1,-1,7,-1,-1,7},
/* Doble predicción en la línea siguiente con el terminal id */
	/* <constante> */ {9,8,9,9,9,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,9,-1,-1,9,-1,9,9,-1,9,-1,9,9,-1,-1,9,-1,-1,9,9,-1,-1,-1,-1,-1,9,9,9,9,9,9,9,9,9,-1,-1,-1,-1,-1,9,-1,-1,9},
/* Doble predicción en la línea siguiente con el terminal id */
	/* <declararTipo> */ {11,10,11,11,11,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,11,-1,-1,11,-1,11,11,-1,11,-1,11,11,-1,-1,11,-1,-1,11,11,-1,-1,-1,-1,-1,11,11,11,11,11,11,11,11,11,-1,-1,-1,-1,-1,11,-1,-1,11},
/* Doble predicción en la línea siguiente con el terminal id */
/* Doble predicción en la línea siguiente con el terminal . */
	/* <declararVariable> */ {13,12,13,13,13,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,12,12,12,12,12,12,12,-1,12,-1,13,-1,-1,13,-1,13,13,-1,13,-1,13,13,-1,-1,13,-1,-1,13,13,-1,-1,-1,-1,-1,13,13,13,13,13,13,13,13,12,-1,-1,-1,-1,-1,13,-1,-1,13},
/* Doble predicción en la línea siguiente con el terminal . */
	/* <declararVariable_aux> */ {16,16,16,16,16,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,16,-1,16,16,-1,16,-1,16,16,-1,-1,16,-1,-1,16,16,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,16,16,16,15,14,-1,-1,-1,-1,16,-1,-1,16},
	/* <simboloVariable> */ {18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,-1,-1,18,18,18,18,18,18,18,18,18,18,18,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,18,18,18,18,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,18,-1,18,18,-1,18,-1,18,18,-1,-1,18,-1,-1,18,18,-1,17,-1,-1,-1,-1,-1,-1,-1,-1,18,18,18,18,18,-1,-1,-1,-1,18,-1,-1,18},
/* Doble predicción en la línea siguiente con el terminal < */
	/* <asignarVariable> */ {20,20,20,20,19,19,19,19,19,19,19,19,19,19,19,19,19,-1,-1,19,19,19,19,19,19,19,19,19,19,19,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,19,19,19,19,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,20,-1,20,20,-1,20,-1,20,20,-1,-1,20,-1,-1,20,20,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,20,20,20,20,20,-1,-1,-1,-1,20,-1,-1,20},
/* Doble predicción en la línea siguiente con el terminal id */
	/* <declararPrototipo> */ {22,21,22,22,22,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,22,-1,22,22,-1,22,-1,22,22,-1,-1,22,-1,-1,22,22,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,22,22,22,22,-1,-1,-1,-1,-1,22,-1,-1,22},
/* Doble predicción en la línea siguiente con el terminal id */
	/* <declararRutina> */ {24,23,24,24,24,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,24,-1,24,24,-1,24,-1,24,24,-1,-1,24,-1,-1,24,24,23,-1,-1,-1,-1,-1,-1,-1,-1,-1,24,24,24,24,-1,-1,-1,-1,-1,24,-1,23,24},
	/* <rutina> */ {-1,27,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,26,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,25,-1},
/* Doble predicción en la línea siguiente con el terminal entero */
/* Doble predicción en la línea siguiente con el terminal id */
/* Doble predicción en la línea siguiente con el terminal caracter */
/* Doble predicción en la línea siguiente con el terminal strings */
/* Doble predicción en la línea siguiente con el terminal < */
/* Doble predicción en la línea siguiente con el terminal > */
/* Doble predicción en la línea siguiente con el terminal = */
/* Doble predicción en la línea siguiente con el terminal >= */
/* Doble predicción en la línea siguiente con el terminal <= */
/* Doble predicción en la línea siguiente con el terminal >< */
/* Doble predicción en la línea siguiente con el terminal [>>] */
/* Doble predicción en la línea siguiente con el terminal [<<] */
/* Doble predicción en la línea siguiente con el terminal [&?] */
/* Doble predicción en la línea siguiente con el terminal [#?] */
/* Doble predicción en la línea siguiente con el terminal $+ */
/* Doble predicción en la línea siguiente con el terminal $# */
/* Doble predicción en la línea siguiente con el terminal $ */
/* Doble predicción en la línea siguiente con el terminal $? */
/* Doble predicción en la línea siguiente con el terminal + */
/* Doble predicción en la línea siguiente con el terminal - */
/* Doble predicción en la línea siguiente con el terminal * */
/* Doble predicción en la línea siguiente con el terminal % */
/* Doble predicción en la línea siguiente con el terminal / */
/* Doble predicción en la línea siguiente con el terminal := */
/* Doble predicción en la línea siguiente con el terminal += */
/* Doble predicción en la línea siguiente con el terminal *= */
/* Doble predicción en la línea siguiente con el terminal %= */
/* Doble predicción en la línea siguiente con el terminal /= */
/* Doble predicción en la línea siguiente con el terminal >> */
/* Doble predicción en la línea siguiente con el terminal << */
/* Doble predicción en la línea siguiente con el terminal incrementum */
/* Doble predicción en la línea siguiente con el terminal decrementum */
/* Doble predicción en la línea siguiente con el terminal neco */
/* Doble predicción en la línea siguiente con el terminal aeger */
/* Doble predicción en la línea siguiente con el terminal initum */
/* Doble predicción en la línea siguiente con el terminal itero */
/* Doble predicción en la línea siguiente con el terminal sigla */
/* Doble predicción en la línea siguiente con el terminal panis */
/* Doble predicción en la línea siguiente con el terminal tempus */
/* Doble predicción en la línea siguiente con el terminal pergo */
/* Doble predicción en la línea siguiente con el terminal claudeo */
/* Doble predicción en la línea siguiente con el terminal in */
/* Doble predicción en la línea siguiente con el terminal falsidicus */
/* Doble predicción en la línea siguiente con el terminal veridicus */
/* Doble predicción en la línea siguiente con el terminal . */
/* Doble predicción en la línea siguiente con el terminal , */
/* Doble predicción en la línea siguiente con el terminal ] */
/* Doble predicción en la línea siguiente con el terminal { */
/* Doble predicción en la línea siguiente con el terminal } */
/* Doble predicción en la línea siguiente con el terminal  EOF  */
	/* <literal> */ {28,30,29,30,30,30,30,30,30,30,30,30,30,30,30,30,30,-1,-1,30,30,30,30,30,30,30,30,30,30,30,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,30,30,30,30,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,30,-1,30,30,-1,30,-1,30,30,-1,-1,30,-1,-1,30,30,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,30,30,30,30,30,-1,-1,-1,30,30,30,-1,30},
	/* <tipoDato> */ {-1,44,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,36,37,38,39,40,41,42,-1,43,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,44,-1,-1,-1,-1,-1,-1,-1,-1,-1},
/* Doble predicción en la línea siguiente con el terminal id */
/* Doble predicción en la línea siguiente con el terminal . */
	/* <variable> */ {46,45,46,46,46,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,46,46,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,45,45,45,45,45,45,45,-1,45,46,46,-1,-1,46,-1,46,46,-1,46,-1,46,46,-1,-1,46,-1,-1,46,46,-1,-1,-1,-1,-1,46,46,46,46,46,46,46,46,45,46,46,46,-1,-1,46,-1,-1,-1},
	/* <index> */ {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,48,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,47,-1,-1,-1,-1,-1},
/* Doble predicción en la línea siguiente con el terminal falsidicus */
/* Doble predicción en la línea siguiente con el terminal veridicus */
	/* <booleano> */ {51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,-1,-1,51,51,51,51,51,51,51,51,51,51,51,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,51,51,51,51,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,51,-1,51,51,-1,51,-1,51,51,-1,-1,51,-1,-1,51,51,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,51,50,49,51,51,-1,-1,-1,51,51,51,-1,51},
/* Doble predicción en la línea siguiente con el terminal { */
	/* <conjunto> */ {53,53,53,53,53,53,53,53,53,53,53,53,53,53,53,53,53,-1,-1,53,53,53,53,53,53,53,53,53,53,53,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,53,53,53,53,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,53,-1,53,53,-1,53,-1,53,53,-1,-1,53,-1,-1,53,53,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,53,53,53,53,53,-1,-1,-1,53,52,53,-1,53},
/* Doble predicción en la línea siguiente con el terminal { */
	/* <arreglo> */ {55,55,55,55,55,55,55,55,55,55,55,55,55,55,55,55,55,-1,-1,55,55,55,55,55,55,55,55,55,55,55,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,55,55,55,55,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,55,-1,55,55,-1,55,-1,55,55,-1,-1,55,-1,-1,55,55,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,55,55,55,55,55,-1,-1,-1,55,54,55,-1,55},
/* Doble predicción en la línea siguiente con el terminal < */
	/* <registro> */ {57,57,57,57,56,57,57,57,57,57,57,57,57,57,57,57,57,-1,-1,57,57,57,57,57,57,57,57,57,57,57,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,57,57,57,57,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,57,-1,57,57,-1,57,-1,57,57,-1,-1,57,-1,-1,57,57,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,57,57,57,57,57,-1,-1,-1,57,57,57,-1,57},
/* Doble predicción en la línea siguiente con el terminal < */
/* Doble predicción en la línea siguiente con el terminal > */
/* Doble predicción en la línea siguiente con el terminal = */
/* Doble predicción en la línea siguiente con el terminal >= */
/* Doble predicción en la línea siguiente con el terminal <= */
/* Doble predicción en la línea siguiente con el terminal >< */
/* Doble predicción en la línea siguiente con el terminal [>>] */
/* Doble predicción en la línea siguiente con el terminal [<<] */
/* Doble predicción en la línea siguiente con el terminal [&?] */
/* Doble predicción en la línea siguiente con el terminal [#?] */
/* Doble predicción en la línea siguiente con el terminal $+ */
/* Doble predicción en la línea siguiente con el terminal $# */
/* Doble predicción en la línea siguiente con el terminal $ */
/* Doble predicción en la línea siguiente con el terminal $? */
/* Doble predicción en la línea siguiente con el terminal + */
/* Doble predicción en la línea siguiente con el terminal - */
/* Doble predicción en la línea siguiente con el terminal * */
/* Doble predicción en la línea siguiente con el terminal % */
/* Doble predicción en la línea siguiente con el terminal / */
/* Doble predicción en la línea siguiente con el terminal := */
/* Doble predicción en la línea siguiente con el terminal += */
/* Doble predicción en la línea siguiente con el terminal *= */
/* Doble predicción en la línea siguiente con el terminal %= */
/* Doble predicción en la línea siguiente con el terminal /= */
/* Doble predicción en la línea siguiente con el terminal >> */
/* Doble predicción en la línea siguiente con el terminal << */
/* Doble predicción en la línea siguiente con el terminal incrementum */
/* Doble predicción en la línea siguiente con el terminal decrementum */
/* Doble predicción en la línea siguiente con el terminal ] */
/* Doble predicción en la línea siguiente con el terminal } */
	/* <elementos> */ {58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,58,-1,-1,58,58,58,58,58,58,58,58,58,58,58,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,58,58,58,58,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,58,-1,58,58,-1,58,-1,58,58,-1,-1,58,-1,-1,58,58,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,58,58,58,58,58,-1,-1,-1,58,58,58,-1,58},
	/* <elemento> */ {-1,-1,-1,-1,61,61,61,61,61,61,61,61,61,61,61,61,61,-1,-1,61,61,61,61,61,61,61,61,61,61,61,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,61,61,61,61,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,60,-1,-1,-1,61,-1,61,-1,-1},
	/* <operacion> */ {-1,-1,-1,-1,62,63,64,65,66,67,68,69,70,71,72,73,74,-1,-1,75,76,77,78,79,80,81,82,83,84,85,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,89,88,86,87,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
/* Doble predicción en la línea siguiente con el terminal entero */
/* Doble predicción en la línea siguiente con el terminal id */
/* Doble predicción en la línea siguiente con el terminal caracter */
/* Doble predicción en la línea siguiente con el terminal strings */
/* Doble predicción en la línea siguiente con el terminal < */
/* Doble predicción en la línea siguiente con el terminal dixi */
/* Doble predicción en la línea siguiente con el terminal neco */
/* Doble predicción en la línea siguiente con el terminal aeger */
/* Doble predicción en la línea siguiente con el terminal initum */
/* Doble predicción en la línea siguiente con el terminal itero */
/* Doble predicción en la línea siguiente con el terminal usque */
/* Doble predicción en la línea siguiente con el terminal sigla */
/* Doble predicción en la línea siguiente con el terminal panis */
/* Doble predicción en la línea siguiente con el terminal tempus */
/* Doble predicción en la línea siguiente con el terminal mentiri */
/* Doble predicción en la línea siguiente con el terminal pergo */
/* Doble predicción en la línea siguiente con el terminal claudeo */
/* Doble predicción en la línea siguiente con el terminal in */
/* Doble predicción en la línea siguiente con el terminal falsidicus */
/* Doble predicción en la línea siguiente con el terminal veridicus */
/* Doble predicción en la línea siguiente con el terminal . */
/* Doble predicción en la línea siguiente con el terminal { */
/* Doble predicción en la línea siguiente con el terminal  EOF  */
	/* <bloqueDeCodigo> */ {91,91,91,91,91,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,91,-1,-1,-1,91,91,91,90,-1,91,91,91,91,-1,-1,91,-1,91,91,91,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,91,91,91,91,-1,-1,-1,-1,-1,91,-1,-1,91},
/* Doble predicción en la línea siguiente con el terminal entero */
/* Doble predicción en la línea siguiente con el terminal id */
/* Doble predicción en la línea siguiente con el terminal caracter */
/* Doble predicción en la línea siguiente con el terminal strings */
/* Doble predicción en la línea siguiente con el terminal < */
/* Doble predicción en la línea siguiente con el terminal neco */
/* Doble predicción en la línea siguiente con el terminal aeger */
/* Doble predicción en la línea siguiente con el terminal initum */
/* Doble predicción en la línea siguiente con el terminal itero */
/* Doble predicción en la línea siguiente con el terminal sigla */
/* Doble predicción en la línea siguiente con el terminal panis */
/* Doble predicción en la línea siguiente con el terminal tempus */
/* Doble predicción en la línea siguiente con el terminal pergo */
/* Doble predicción en la línea siguiente con el terminal claudeo */
/* Doble predicción en la línea siguiente con el terminal in */
/* Doble predicción en la línea siguiente con el terminal falsidicus */
/* Doble predicción en la línea siguiente con el terminal veridicus */
/* Doble predicción en la línea siguiente con el terminal . */
/* Doble predicción en la línea siguiente con el terminal { */
/* Doble predicción en la línea siguiente con el terminal  EOF  */
	/* <lineaDeCodigo> */ {93,93,93,93,93,93,93,93,93,93,93,93,93,93,93,93,93,-1,-1,93,93,93,93,93,93,93,93,93,93,93,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,93,93,93,93,-1,-1,-1,-1,-1,-1,-1,-1,-1,103,-1,-1,-1,93,103,93,93,-1,93,103,93,93,-1,-1,93,-1,103,93,93,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,93,93,93,93,93,-1,-1,-1,93,93,93,-1,93},
/* Doble predicción en la línea siguiente con el terminal id */
/* Doble predicción en la línea siguiente con el terminal . */
	/* <expresion> */ {104,104,104,104,104,104,104,104,104,104,104,104,104,104,104,104,104,-1,-1,104,104,104,104,104,104,104,104,104,104,104,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,104,104,104,104,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,104,-1,104,104,-1,104,-1,104,104,-1,-1,104,-1,-1,104,104,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,104,104,104,104,104,-1,-1,-1,104,104,104,-1,104},
/* Doble predicción en la línea siguiente con el terminal id */
	/* <expresion_aux> */ {107,107,107,107,107,107,107,107,107,107,107,107,107,107,107,107,107,-1,-1,107,107,107,107,107,107,107,107,107,107,107,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,107,107,107,107,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,107,-1,107,107,-1,107,-1,107,107,-1,-1,107,-1,-1,107,107,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,107,107,107,107,107,-1,-1,-1,107,107,107,-1,107},
	/* <while> */ {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,109,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	/* <for> */ {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,110,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	/* <with> */ {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,111,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	/* <repeatUntil> */ {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,112,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	/* <switch> */ {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,113,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	/* <switchCase> */ {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,115,114,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	/* <if> */ {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,116,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	/* <funcion> */ {-1,117,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,118,-1,-1,-1,-1,-1,-1,-1,-1,-1},
/* Doble predicción en la línea siguiente con el terminal |> */
/* Doble predicción en la línea siguiente con el terminal |< */
/* Doble predicción en la línea siguiente con el terminal . */
/* Doble predicción en la línea siguiente con el terminal , */
/* Doble predicción en la línea siguiente con el terminal ( */
/* Doble predicción en la línea siguiente con el terminal ) */
	/* <simbolo> */ {125,125,125,125,125,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,119,120,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,125,125,125,125,125,125,125,-1,125,125,125,-1,-1,125,-1,125,125,-1,125,-1,125,125,-1,-1,125,-1,-1,125,125,-1,-1,-1,-1,-1,125,125,125,125,125,125,125,125,124,123,121,122,-1,-1,125,-1,-1,-1}
};

/* Tabla de lados derechos */
const int LadosDerechos[126][MAX_LADO_DER] =
{
	{100,89,1,80,-1,-1,-1,-1,-1,-1,-1},
	{101,81,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{102,82,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{103,83,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{107,84,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{108,85,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{121,57,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{101,89,110,79,1,-1,-1,-1,-1,-1,-1},
	{100,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{102,89,111,78,1,-1,-1,-1,-1,-1,-1},
	{100,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{104,106,110,105,1,111,-1,-1,-1,-1,-1},
	{100,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{103,90,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{89,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{77,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{120,118,120,-1,-1,-1,-1,-1,-1,-1,-1},
	{-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{89,133,112,133,1,-1,-1,-1,-1,-1,-1},
	{-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{89,121,100,133,112,133,1,109,-1,-1,-1},
	{-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{97,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{76,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{2,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{114,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{115,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{3,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{116,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{117,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{47,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{48,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{49,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{50,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{51,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{52,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{111,54,113,94,0,93,53,-1,-1,-1,-1},
	{56,112,55,-1,-1,-1,-1,-1,-1,-1,-1},
	{-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{112,133,1,111,-1,-1,-1,-1,-1,-1,-1},
	{-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{94,0,93,-1,-1,-1,-1,-1,-1,-1,-1},
	{-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{88,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{87,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{96,118,95,-1,-1,-1,-1,-1,-1,-1,-1},
	{-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{96,94,118,93,95,-1,-1,-1,-1,-1,-1},
	{-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{5,118,4,-1,-1,-1,-1,-1,-1,-1,-1},
	{-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{119,110,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{118,90,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{4,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{5,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{6,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{7,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{8,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{9,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{10,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{11,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{12,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{13,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{14,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{15,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{0,133,0,16,-1,-1,-1,-1,-1,-1,-1},
	{2,19,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{20,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{21,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{22,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{23,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{24,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{25,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{26,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{27,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{28,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{29,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{45,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{46,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{44,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{43,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{61,122,63,-1,-1,-1,-1,-1,-1,-1,-1},
	{122,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{122,123,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{122,131,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{122,125,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{122,126,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{122,127,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{122,128,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{122,129,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{122,89,60,-1,-1,-1,-1,-1,-1,-1,-1},
	{122,89,74,-1,-1,-1,-1,-1,-1,-1,-1},
	{122,89,75,-1,-1,-1,-1,-1,-1,-1,-1},
	{-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{89,110,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{89,124,120,1,-1,-1,-1,-1,-1,-1,-1},
	{89,132,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{110,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{89,121,64,123,71,-1,-1,-1,-1,-1,-1},
	{89,121,64,0,70,0,69,0,25,1,68},
	{56,121,64,1,67,-1,-1,-1,-1,-1,-1},
	{123,66,121,65,-1,-1,-1,-1,-1,-1,-1},
	{61,130,63,1,62,-1,-1,-1,-1,-1,-1},
	{122,64,0,59,-1,-1,-1,-1,-1,-1,-1},
	{122,58,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{89,121,73,121,72,123,86,-1,-1,-1,-1},
	{89,133,112,133,1,-1,-1,-1,-1,-1,-1},
	{-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{17,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{18,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{91,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{92,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{90,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{89,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	{-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1}
};
