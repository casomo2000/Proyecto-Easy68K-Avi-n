*// --------------------------------------------------------------------
*// Universitat Politècnica de València
*// Escuela Técnica Superior de Ingenieros de Telecomunicación
*// --------------------------------------------------------------------
*// Sistemas de Microprocesadores
*// Curso 2022-23
*// --------------------------------------------------------------------
*//
*// Autor: Carlos Soria Mora y Alejandro Cano Segovia
*//
*// --------------------------------------------------------------------    
    
    ORG $1000

START
    MOVE.L #BASEDATOS,A0
    
    MOVE.L #14,D0
    MOVE.L #MENSAJE_MENU,A1
    TRAP #15
    
    MOVE.L #14,D0
    MOVE.L #MENSAJE_DIMENSION_AVION,A1
    TRAP #15
    
    MOVE.L #14,D0
    MOVE.L #MENU_DIMENSION1,A1
    TRAP #15
    
    MOVE.L #14,D0
    MOVE.L #MENU_DIMENSION2,A1
    TRAP #15
    
    MOVE.L #14,D0
    MOVE.L #MENU_DIMENSION3,A1
    TRAP #15
    
    MOVE.L #14,D0
    MOVE.L #MENU_DIMENSION4,A1
    TRAP #15
    
    MOVE.L #4,D0
    TRAP #15
    
    CMP.L #1,D1
    BEQ DIMENSION1
 
    CMP.L #2,D1
    BEQ DIMENSION2
    
    CMP.L #3,D1
    BEQ DIMENSION3
    
    CMP.L #4,D1
    BEQ DIMENSION4
    
    JMP START
    
DIMENSION1
    MOVE.B #1,D4
    JMP MULTIPLICADOR1
DIMENSION2
    MOVE.B #2,D4
    JMP MULTIPLICADOR1
DIMENSION3
    MOVE.B #4,D4
    JMP MULTIPLICADOR1
DIMENSION4
    MOVE.B #6,D4
    JMP MULTIPLICADOR1
    
MULTIPLICADOR1
    MOVE.L #MULTIPLICADOR,A4    *GUARDAMOS EL MULTIPLICADOR, YA QUE LO USAREMOS A LO LARGO DEL PROGRAMA Y NOS FALTARAN REGISTROS
    MOVE.B D4,(A4)
    
    MOVE.L #50,D1    
    MULU D4,D1
    MOVE.L #0,D0
GENERADOR_ASIENTOS
    ADD.L #1,D0
    MOVE.W D0,(A0)
    ADD.L #32,A0
    CMP.L D1,D0
    BNE GENERADOR_ASIENTOS    
    
MENU_PRINCIPAL
    JSR LIMPIA_PANTALLAS
    MOVE.L #BASEDATOS,A3
    MOVE.L #CODIGO_TABLA_INTERFAZ,A5
    
    MOVE.L #14,D0
    MOVE.L #MENSAJE_MENU1,A1
    TRAP #15
    
    MOVE.L #14,D0
    MOVE.L #MENU_SELECCION1,A1
    TRAP #15

    MOVE.L #14,D0
    MOVE.L #MENU_SELECCION2,A1
    TRAP #15

    MOVE.L #14,D0
    MOVE.L #MENU_SELECCION3,A1
    TRAP #15
    
    MOVE.L #14,D0
    MOVE.L #MENU_SELECCION4,A1
    TRAP #15
    
    MOVE.L #14,D0
    MOVE.L #MENU_SELECCION5,A1
    TRAP #15
    
    MOVE.L #4,D0
    TRAP #15
    
    JSR LIMPIA_PANTALLAS
    
    CMP.L #1,D1
    BEQ CONSULTAR 
 
    CMP.L #2,D1
    BEQ ASIGNAR
    
    CMP.L #3,D1
    BEQ INICIALIZAR
    
    CMP.L #4,D1
    BEQ TABLA
    
    CMP.L #5,D1
    BEQ INTERFAZ_AVION
    
    JMP MENU_PRINCIPAL
    
    
CONSULTAR
    MOVE.B (A4),D4
    MOVE.L #50,D5      *hexadecimal de 50 en decimal
    MULU D4,D5         *ESTABLECEMOS EL LÍMITE DE CONSULTA
    
    MOVE.L #14,D0
    MOVE.L #SALTO_LINEA,A1
    TRAP #15
    
    MOVE.L #14,D0
    MOVE.L #MENU_SELECCION1_N_ASIENTO,A1
    TRAP #15
    
    MOVE.L #4,D0
    TRAP #15
    
    JSR LIMPIA_PANTALLAS
    
        
    CMP.L D5,D1        *Si es mayor que el numero de asientos no existe
    BHI NO_EXISTE
    
    CMP.L #1,D1        *Si es menor que 1 no existe
    BCS NO_EXISTE
    
    SUB.L #1,D1
    MOVE.L #32,D2
    MULU D1,D2
    MOVE.L D2,A0
    ADD.L #2,A0
    ADD.L #BASEDATOS,A0 
    CMP.B #0,(A0)
    BEQ OCUPADO_CONSULTAR
    JMP LIBRE_CONSULTAR

LIBRE_CONSULTAR
    MOVE.L #14,D0
    MOVE.L #ASIENTO_LIBRE,A1
    TRAP #15
    
    JMP MENU_PRINCIPAL
OCUPADO_CONSULTAR
    ADD.L #1,A0
    MOVE.L #14,D0
    MOVE.L #ASIENTO_OCUPADO,A1
    TRAP #15
    
    MOVE.L #14,D0
    MOVE.L A0,A1
    TRAP #15
    
    ADD.L #10,A0
    
    MOVE.L #14,D0
    MOVE.L #ESPACIO_BLANCO,A1
    TRAP #15
    
    MOVE.L #14,D0
    MOVE.L A0,A1
    TRAP #15
    
    MOVE.L #14,D0
    MOVE.L #SALTO_LINEA,A1
    TRAP #15

    JMP MENU_PRINCIPAL
NO_EXISTE
    MOVE.L #14,D0
    MOVE.L #ASIENTO_NO_EXISTE,A1
    TRAP #15
    
    JMP MENU_PRINCIPAL
        
ASIGNAR
    MOVE.B (A4),D4
    MOVE.L #14,D0
    MOVE.L #SALTO_LINEA,A1
    TRAP #15
    MOVE.L #14,D0
    MOVE.L #MENSAJE1_MENU_SELECCION2,A1
    TRAP #15
    
    MOVE.L #14,D0
    MOVE.L #CLASE1MSG,A1
    TRAP #15
    
    MOVE.L #14,D0
    MOVE.L #CLASE2MSG,A1
    TRAP #15
    
    MOVE.L #4,D0
    TRAP #15
    
    MOVE.L #14,D0
    MOVE.L #SALTO_LINEA,A1
    TRAP #15
    
    MOVE.L #14,D0
    MOVE.L #MENSAJE2_MENU_SELECCION2,A1
    TRAP #15
    
    
    MOVE.L #14,D0
    MOVE.L #VENTANA,A1
    TRAP #15
    
    MOVE.L #14,D0
    MOVE.L #PASILLO,A1
    TRAP #15
    
    CMP.B #1,D1 *SI ES PRIMERA CLASE...
    BEQ CLASE1
    
    CMP.B #2,D1 *SI ES SEGUNDA CLASE...
    BEQ CLASE2
    
    JMP MENU_PRINCIPAL
    
CLASE1
    MOVE.L #4,D0
    TRAP #15
    
    MOVE.L #14,D0
    MOVE.L #SALTO_LINEA,A1
    TRAP #15
    
    MOVE.L #4,D7
    MULU D4,D7
    
    CMP.B #1,D1    *SI ES EN LA VENTANA...
    BEQ CLASEVENTANA1
    CMP.B #2,D1    *SI ES EN EL PASILLO...
    BEQ CLASEPASILLO1
    
    JMP MENU_PRINCIPAL

CLASEVENTANA1
    MOVE.L #0,D3
    MOVE.L #3,D5
    MOVE.L #1,D6
    JMP COMPROBADOR_ASIENTO_INICIAL
    
CLASEPASILLO1
    MOVE.L #1,D3
    MOVE.L #1,D5
    MOVE.L #3,D6
    JMP COMPROBADOR_ASIENTO_INICIAL

CLASE2
    MOVE.L #14,D0
    MOVE.L #CENTRO,A1
    TRAP #15
    
    MOVE.L #4,D0
    TRAP #15
    
    MOVE.L #14,D0
    MOVE.L #SALTO_LINEA,A1
    TRAP #15
    
    MOVE.L #14,D7
    MULU D4,D7
    
    CMP.B #1,D1    *SI ES EN LA VENTANA....
    BEQ CLASEVENTANA2

    CMP.B #3,D1    *SI ES EN EL CENTRO...
    BEQ CLASECENTRO2

    CMP.B #2,D1    *SI ES EN EL PASILLO...
    BEQ CLASEPASILLO2
    
    JMP MENU_PRINCIPAL
    
CLASEVENTANA2
    MOVE.L #8,D3
    MOVE.L #5,D5
    MOVE.L #1,D6
    JMP CALCULO_POS_INICIAL

CLASECENTRO2
    MOVE.L #9,D3
    MOVE.L #3,D5
    MOVE.L #3,D6
    JMP CALCULO_POS_INICIAL
CLASEPASILLO2
    MOVE.L #10,D3
    MOVE.L #1,D5
    MOVE.L #5,D6
    JMP CALCULO_POS_INICIAL
    
CALCULO_POS_INICIAL
    CMP.L #2,D4
    BEQ POS_INI_100
    
    CMP.L #4,D4
    BEQ POS_INI_200
    
    CMP.L #6,D4
    BEQ POS_INI_300
    
    JMP COMPROBADOR_ASIENTO_INICIAL
   
POS_INI_100
    ADD.L #8,D3
    JMP COMPROBADOR_ASIENTO_INICIAL
POS_INI_200
    ADD.L #24,D3
    JMP COMPROBADOR_ASIENTO_INICIAL
POS_INI_300
    ADD.L #40,D3
    JMP COMPROBADOR_ASIENTO_INICIAL
    
COMPROBADOR_ASIENTO_INICIAL
    MOVE.L #1,D1
    MOVE.L #32,D2
    MULU D3,D2
    MOVE.L D2,A0
    ADD.L #2,A0
    ADD.L #BASEDATOS,A0 
    CMP.B #0,(A0)
    BEQ CALCULADORA
    JMP LIBRE_ASIGNAR
    
CALCULADORA
    CMP.B D1,D7
    BEQ OCUPADO_ASIGNAR
    ADD.L #1,D1
    MOVE.B D5,D0
    MULU #32,D0
    ADD.L D0,A0
    
    CMP.B #$FF,(A0)
    BEQ LIBRE_ASIGNAR
    
    CMP.B D1,D7
    BEQ OCUPADO_ASIGNAR
    
    ADD.L #1,D1
    
    MOVE.B D6,D0
    MULU #32,D0
    ADD.L D0,A0
    
    CMP.B #0,(A0)
    BEQ CALCULADORA

LIBRE_ASIGNAR
    
    MOVE.B #0,(A0)+
    MOVE.L #14,D0
    MOVE.L #MENSAJE3_MENU_SELECCION2,A1
    TRAP #15
    
    MOVE.L #14,D0
    MOVE.L #INTRODUCE_DNI,A1
    TRAP #15

    MOVE.L #2,D0
    MOVE.L A0,A1
    TRAP #15
    
    MOVE.L #14,D0
    MOVE.L #SALTO_LINEA,A1
    TRAP #15
    
    ADD.L #10,A0
    
    MOVE.L #14,D0
    MOVE.L #INTRODUCE_NOMBRE,A1
    TRAP #15
    
    MOVE.L #2,D0
    MOVE.L A0,A1
    TRAP #15
    
    JMP MENU_PRINCIPAL
OCUPADO_ASIGNAR
    MOVE.L #14,D0
    MOVE.L #OCUPADO_MENU_SELECCION2,A1
    TRAP #15
    JMP ASIGNAR
    
INICIALIZAR
    MOVE.B #$FF,(A3)+
    CMP.L #$4FFF,A3
    BEQ BORRAR_CODIGO_TABLA
    JMP INICIALIZAR
BORRAR_CODIGO_TABLA
    MOVE.B #$FF,(A5)+
    CMP.B #0,(A5)
    BEQ START
    JMP BORRAR_CODIGO_TABLA



***SUBRUTINA CREADORA DEL CÓDIGO TANTO PARA LA TABLA COMO PARA LA INTERFAZ DEL AVIÓN
GENERADOR_CODIGO
    MOVE.B (A4),D4
    JSR LIMPIA_PANTALLAS
    MOVE.L #0,D1 *contador asientos
    MOVE.L #0,D3 *contador total huecos
    MOVE.L #0,A0
    MOVE.L #CODIGO_TABLA_INTERFAZ,A1
    MOVE.L #54,D7
    MULU D4,D7   * MULTIPLICADOR = TOTAL PASAJEROS
    * EJEMPLO 50  0####00####0#################################...
    * EJEMPLO 100 0####00####00####00####0##########################################...
    * EJEMPLO 200 0####00####00####00####00####00####00####00####0############################################...
    * EJEMPLO 200 0####00####00####00####00####00####00####00####00####00####00####00####0################################################...
GENERADOR_HUECOS_CODIGO    
    **PARA 50
    CMP.L #0,D3
    BEQ HUECO
    CMP.L #5,D3
    BEQ HUECO
    CMP.L #6,D3
    BEQ HUECO
    CMP.L #11,D3
    BEQ HUECO
    
    CMP.L #1,D4
    BEQ RECORREDOR_MEMORIA_GEN_COD
    
    **PARA 100
    CMP.L #12,D3
    BEQ HUECO
    CMP.L #17,D3
    BEQ HUECO
    CMP.L #18,D3
    BEQ HUECO
    CMP.L #23,D3
    BEQ HUECO
    
    CMP.L #2,D4
    BEQ RECORREDOR_MEMORIA_GEN_COD
    *PARA 200
    
    CMP.L #24,D3
    BEQ HUECO
    CMP.L #29,D3
    BEQ HUECO
    CMP.L #30,D3
    BEQ HUECO
    CMP.L #35,D3
    BEQ HUECO
    CMP.L #36,D3
    BEQ HUECO
    CMP.L #41,D3
    BEQ HUECO
    CMP.L #42,D3
    BEQ HUECO
    CMP.L #47,D3
    BEQ HUECO
    
    CMP.L #4,D4
    BEQ RECORREDOR_MEMORIA_GEN_COD
    
    *PARA 300
    
    CMP.L #48,D3
    BEQ HUECO
    CMP.L #53,D3
    BEQ HUECO
    CMP.L #54,D3
    BEQ HUECO
    CMP.L #59,D3
    BEQ HUECO
    CMP.L #60,D3
    BEQ HUECO
    CMP.L #65,D3
    BEQ HUECO
    CMP.L #66,D3
    BEQ HUECO
    CMP.L #71,D3
    BEQ HUECO

    
RECORREDOR_MEMORIA_GEN_COD
    CMP.L D7,D3
    BEQ FIN_GENERADOR_CODIGO

    MOVE.L #32,D2
    MULU D1,D2
    MOVE.L D2,A0
    ADD.L #2,A0
    ADD.L #BASEDATOS,A0
    

    ADD.L #1,D1
    ADD.L #1,D3

    CMP.B #0,(A0)
    BEQ OCUPADO_COD
    JMP LIBRE_COD
    
OCUPADO_COD
    MOVE.B #'X',(A1)+
    JMP GENERADOR_HUECOS_CODIGO
LIBRE_COD
    MOVE.B #'#',(A1)+
    JMP GENERADOR_HUECOS_CODIGO
HUECO
    MOVE.B #'0',(A1)+
    ADD.L #1,D3
    JMP GENERADOR_HUECOS_CODIGO
    
FIN_GENERADOR_CODIGO
    MOVE.B #0,(A1)
    RTS
*/////////////////////////////////////////////////////////////////////////////////////////////////////////////
TABLA
    JSR GENERADOR_CODIGO
    MOVE.L #0,D1 *nºfila
    MOVE.L #CODIGO_TABLA_INTERFAZ,A0
    
    MOVE.L #14,D0
    MOVE.L #RAYA_H,A1
    TRAP #15
    
    MOVE.L #14,D0
    MOVE.L #FILA1,A1
    TRAP #15
FILA_NUEVA_TABLA
    MOVE.L #0,D6 *contador columnas
    
    MOVE.L #14,D0
    MOVE.L #SALTO_LINEA,A1
    TRAP #15
    
    MOVE.L #14,D0
    MOVE.L #RAYA_H,A1
    TRAP #15
    
    CMP.B #0,(A0)   *FIN TABLA SI SE ACABA EL CODIGO
    BEQ MENU_PRINCIPAL
    
    ADD.L #1,D1
    
    MOVE.L #14,D0
    MOVE.L #RAYA_V,A1
    TRAP #15
    
    MOVE.L #3,D0
    MOVE.L D1,D1
    TRAP #15
    
    CMP.L #10,D1 *HUECOBLANCO4
    BCC HUECO4   *MAYOR IGUAL O QUE 10
    
    MOVE.L #14,D0
    MOVE.L #HUECO_BLANCO5,A1
    TRAP #15
    JMP FIN_COL_0
HUECO4
    MOVE.L #14,D0
    MOVE.L #HUECO_BLANCO4,A1
    TRAP #15
FIN_COL_0    
    MOVE.L #14,D0
    MOVE.L #RAYA_V,A1
    TRAP #15
    
COLUMNAS_TABLA
    CMP.B #'#',(A0)
    BEQ ALMOHADILLA_TABLA
    
    CMP.B #'X',(A0)
    BEQ EQUIS_TABLA
    
    CMP.B #'0',(A0)
    BEQ EN_BLANCO_TABLA
    
    JMP START
ALMOHADILLA_TABLA
    MOVE.L #14,D0
    MOVE.L #SIGNO1,A1
    TRAP #15
    
    MOVE.L #14,D0
    MOVE.L #RAYA_V,A1
    TRAP #15
    
    ADD.L #1,D6
    ADD.L #1,A0
    CMP.L #6,D6
    BEQ FILA_NUEVA_TABLA
    JMP COLUMNAS_TABLA
EQUIS_TABLA
    MOVE.L #14,D0
    MOVE.L #SIGNO2,A1
    TRAP #15
    
    MOVE.L #14,D0
    MOVE.L #RAYA_V,A1
    TRAP #15
    
    ADD.L #1,D6
    ADD.L #1,A0
    CMP.L #6,D6
    BEQ FILA_NUEVA_TABLA
    JMP COLUMNAS_TABLA
EN_BLANCO_TABLA
    MOVE.L #14,D0
    MOVE.L #HUECO_BLANCO11,A1
    TRAP #15
    
    MOVE.L #14,D0
    MOVE.L #RAYA_V,A1
    TRAP #15
    
    ADD.L #1,D6
    ADD.L #1,A0
    CMP.L #6,D6
    BEQ FILA_NUEVA_TABLA
    JMP COLUMNAS_TABLA
    

LIMPIA_PANTALLAS
    MOVE.L #0,D2
BUCLE_LIMPIA_PANTALLAS
    MOVE.L #14,D0
    MOVE.L #SALTO_LINEA,A1
    TRAP #15
    ADD.L #1,D2
    CMP.L #2,D2
    BNE BUCLE_LIMPIA_PANTALLAS
    RTS
    
INTERFAZ_AVION
    JSR GENERADOR_CODIGO
    
    MOVE.B (A4),D4
    MOVE.L #CODIGO_TABLA_INTERFAZ,A0
    MOVE.L #1,D7    *CONTADOR ASIENTOS
    
    JSR SUB_RUT_COLOR_AQUA
    
    JSR SUB_RUT_RELLENO1
    JSR SUB_RUT_RELLENO1
    JSR SUB_RUT_RELLENO1
    JSR SUB_RUT_RELLENO1
    JSR SUB_RUT_RELLENO1
    JSR SUB_RUT_RELLENO1
    
FILA_NUEVA_INTERFAZ
    
    MOVE.L #0,D6    *contador columnas
    
    JSR SUB_RUT_COLOR_AQUA
    
    CMP.B #0,(A0)
    BEQ FIN_INTERFAZ

    JSR SUB_RUT_ESPACIO_IZQUIERDA
    
COLUMNAS_INTERFAZ
    CMP.B #3,D6
    BEQ HUECO_PASILLO_INTERFAZ
    
    JSR HUECOS_INTERFAZ
    
    ADD.L #1,D6
    
    CMP.B #'#',(A0)
    BEQ ALMOHADILLA_INTERFAZ
    
    CMP.B #'X',(A0)
    BEQ EQUIS_INTERFAZ
    
    CMP.B #'0',(A0)
    BEQ EN_BLANCO_INTERFAZ
    
    JMP START
    
ALMOHADILLA_INTERFAZ
    MOVE.L #21,D0
    MOVE.L #$00FFFFFF,D1                        *LETRA EN BLANCO
    TRAP #15
    
    MOVE.L #81,D0
    MOVE.L #$00008000,D1
    TRAP #15
    
    JSR NUMERO_INTERFAZ
    JMP COLUMNAS_INTERFAZ

EQUIS_INTERFAZ
    MOVE.L #21,D0
    MOVE.L #$00FFFFFF,D1                        *LETRA EN BLANCO
    TRAP #15
    
    MOVE.L #81,D0
    MOVE.L #$000000FF,D1
    TRAP #15
    JSR NUMERO_INTERFAZ
    JMP COLUMNAS_INTERFAZ
EN_BLANCO_INTERFAZ
    MOVE.L #81,D0
    MOVE.L #$00FFFFFF,D1
    TRAP #15
    
    MOVE.L #14,D0
    MOVE.L #ESPACIO2,A1
    TRAP #15
    
    ADD.L #1,A0
    JSR HUECOS_INTERFAZ
    CMP.L #7,D6
    BEQ ESPACIO_AZUL_DERECHA
    
    JMP COLUMNAS_INTERFAZ
    
NUMERO_INTERFAZ
    MOVE.L #0,D3
    MOVE.L D7,D4
    
    DIVU #100,D4
    MOVE.B D4,D3
    
    ADD.B #$30,D3
    
    MOVE.L #6,D0        *SACA CENTENAS
    MOVE.L D3,D1
    TRAP #15
    
    MOVE.L #0,D3
    
    SWAP D4
    
    MOVE.B D4,D3
    
    DIVU #10,D3        *DECENAS
    MOVE.L D3,D4
    ADD.B #$30,D4
    
    
    MOVE.L #6,D0        *SACA DECENAS
    MOVE.L D4,D1
    TRAP #15
    
    MOVE.L #0,D4
    
    SWAP D3
    
    MOVE.B D3,D4
    ADD.B #$30,D4
    
    MOVE.L #6,D0        *SACA UNIDADES
    MOVE.L D4,D1
    TRAP #15

    ADD.L #1,D7
    ADD.L #1,A0
    JSR HUECOS_INTERFAZ
    
    CMP.L #7,D6         *CONTAMOS EL HUECO DEL PASILLO COMO UNA COLUMNA, ESTE SERÁ NUESTRO SALTO DE FILA
    BEQ ESPACIO_AZUL_DERECHA
    
    RTS

ESPACIO_AZUL_DERECHA
    JSR SUB_RUT_COLOR_AQUA
    JSR SUB_RUT_RELLENO2
    JMP FILA_NUEVA_INTERFAZ
    
FIN_INTERFAZ
    MOVE.L #81,D0
    MOVE.L #$00FFFF00,D1                        *AQUA
    TRAP #15
    
    JSR SUB_RUT_RELLENO1
    JSR SUB_RUT_RELLENO1
    JSR SUB_RUT_RELLENO1
    JSR SUB_RUT_RELLENO1
    
    MOVE.L #81,D0
    MOVE.L #$00000000,D1                        *LETRA EN NEGRO
    TRAP #15
    
    MOVE.L #14,D0
    MOVE.L #SALTO_LINEA,A1
    TRAP #15
    MOVE.L #14,D0
    MOVE.L #SALTO_LINEA,A1
    TRAP #15
    JMP MENU_PRINCIPAL

HUECO_PASILLO_INTERFAZ
    MOVE.L #81,D0
    MOVE.L #$00808080,D1                        *GRIS
    TRAP #15
    
    MOVE.L #14,D0
    MOVE.L #ESPACIO_PASILLO,A1
    TRAP #15
    ADD.L #1,D6
    JMP COLUMNAS_INTERFAZ
    
HUECOS_INTERFAZ
    MOVE.L #81,D0
    MOVE.L #$00FFFFFF,D1                        *BLANCO
    TRAP #15
    
    MOVE.L #14,D0
    MOVE.L #ESPACIO,A1
    TRAP #15
    
    RTS
    
SUB_RUT_RELLENO1
    MOVE.L #14,D0
    MOVE.L #RELLENO1,A1
    TRAP #15
    RTS
SUB_RUT_RELLENO2
    MOVE.L #14,D0
    MOVE.L #RELLENO2,A1
    TRAP #15
    RTS
SUB_RUT_COLOR_AQUA
    MOVE.L #81,D0
    MOVE.L #$00FFFF00,D1
    TRAP #15
    RTS
SUB_RUT_ESPACIO_IZQUIERDA
    MOVE.L #14,D0
    MOVE.L #ESPACIO_IZQUIERDA,A1
    TRAP #15
    RTS
    SIMHALT
    
    
    
    ORG $2000
BASEDATOS DS.B 3000 *Cada pasajero ocupa 32 posiciones de memoria (2B Nºasiento, 1B (libre/ocupado), 9B DNI, 20B Nombre )

    ORG $5000
MENSAJE_MENU DC.B 'Usted se encuentra en el menu principal de la aeronave ALECAR',13,10,0
MENSAJE_DIMENSION_AVION DC.B 'Selecciona el número de pasajeros de su avión',13,10,0

MENU_DIMENSION1 DC.B 'Pulse " 1 " para elegir dimensión de 50',13,10,0
MENU_DIMENSION2 DC.B 'Pulse " 2 " para elegir dimensión de 100',13,10,0
MENU_DIMENSION3 DC.B 'Pulse " 3 " para elegir dimensión de 200',13,10,0
MENU_DIMENSION4 DC.B 'Pulse " 4 " para elegir dimensión de 300',13,10,0

MENSAJE_MENU1 DC.B 'Seleccione la operación que desee realizar',13,10,0

MENU_SELECCION1 DC.B 'Pulse " 1 " para Consultar los asientos',13,10,0
MENU_SELECCION2 DC.B 'Pulse " 2 " para asignar asientos',13,10,0
MENU_SELECCION3 DC.B 'Pulse " 3 " para inicializar la base de datos ',13,10,0
MENU_SELECCION4 DC.B 'Pulse " 4 " para mostrar la disponibilidad de todos los asientos ',13,10,0
MENU_SELECCION5 DC.B 'Pulse " 5 " para mostrar la interfaz gráfica del avión ',13,10,0

MENU_SELECCION1_N_ASIENTO DC.B 'Elija el número de asiento que desea consultar >',0
ASIENTO_OCUPADO DC.B 'El asiento esta ocupado por el pasajero, ',0
ASIENTO_LIBRE DC.B 'El asiento esta disponible',13,10,0
ASIENTO_NO_EXISTE DC.B 'El asiento no Existe',13,10,0


MENSAJE1_MENU_SELECCION2 DC.B 'Seleccione la clase del asiento que desea ocupar',13,10,0
CLASE1MSG DC.B 'Pulse " 1 " para Primera Clase',13,10,0
CLASE2MSG DC.B 'Pulse " 2 " para Clase Turista',13,10,0

MENSAJE2_MENU_SELECCION2 DC.B 'Seleccione la ubicación del asiento que desea ocupar',13,10,0

VENTANA DC.B 'Pulse " 1 " para un asiento al lado de la ventana',13,10,0
PASILLO DC.B 'Pulse " 2 " para un asiento al lado del pasillo',13,10,0
CENTRO DC.B 'Pulse " 3 " para un asiento en el centro',13,10,0


MENSAJE3_MENU_SELECCION2 DC.B 'Introduzca los datos personales del pasajero',13,10,0
INTRODUCE_DNI DC.B 'Escriba el DNI >',13,10,0
INTRODUCE_NOMBRE DC.B 'Escriba el nombre >',13,10,0

OCUPADO_MENU_SELECCION2 DC.B 'No hay asientos libres',13,10,0

SALTO_LINEA DC.B ' ',13,10,0
ESPACIO_BLANCO DC.B '  ',0
RAYA_V DC.B '|',0
RAYA_H DC.B '--------------------------------------------------------------------------------',13,10,0
FILA1 DC.B '| FILA | ASIENTO A | ASIENTO B | ASIENTO C | ASIENTO D | ASIENTO E | ASIENTO F |',0
SIGNO1 DC.B '     #     ',0
SIGNO2 DC.B '     X     ',0
HUECO_BLANCO11 DC.B '           ',0
HUECO_BLANCO5 DC.B '     ',0
HUECO_BLANCO4 DC.B '    ',0

ESPACIO_IZQUIERDA DC.B '                          ',0
ESPACIO_PASILLO DC.B '   ',0
ESPACIO DC.B ' ',0
ESPACIO2 DC.B '   ',0
RELLENO1 DC.B '                                                                                                             ',13,10,0
RELLENO2 DC.B '                                                  ',13,10,0
    ORG $8000
CODIGO_TABLA_INTERFAZ DS.B 325
*CODIGO_TABLA_INTERFAZ DC.B '0####00####0##########################################',0
MULTIPLICADOR DS.B 1
    END    START









*~Font name~Courier New~
*~Font size~8~
*~Tab type~1~
*~Tab size~4~
