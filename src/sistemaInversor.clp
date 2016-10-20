;##############################################################################
;#                       TEMPLATES QUE UTILIZA EL SISTEMA                     #
;#                                                                            #
;#      En esta seccion se declaran todos los templates de los que hace uso   #
;#          el sistema, ademas de una expliacion de cada uno de los slots     #
;##############################################################################

;-----------------------------------------------
;   Template para los datos de las empresas
;-----------------------------------------------

(deftemplate Empresa
    ; Nombre de la empresa
    (multislot Nombre)
    ; Precio de las acciones
    (slot Precio (type FLOAT))
    ; Porcentaje de variacion del dia
    (slot Var_dia (type FLOAT))
    ; Capitalizacion en miles de euros
    (slot Capitalizacion (type FLOAT))
    ; PER -->  Price Earning Ratio o relacion precio-beneficio
    (slot PER (type FLOAT))
    ; RPD --> Rentabilidad por dividendo
    (slot RPD (type FLOAT))
    ; Tamanio de la empresa --> Pequenio, Mediano, Grande
    (slot Tamanio)
    ; Porcentaje en el IBEX35
    (slot Porcentaje_IBEX (type FLOAT))
    ; Etiqueta asociada al PER --> Alto, Medio, Bajo
    (slot Etiq_PER)
    ; Etiqueta asociada al RPD ---> Alto, Medio, Bajo
    (slot Etiq_RPD)
    ; Sector al que pertenece la empresa
    (slot Sector)
    ; Porcentaje asociado a la variacion del valor durante los ultimos 5 dias
    (slot Porcentaje_Var_5_Dias (type FLOAT))
    ; Flag que se activa si el valor pierde durante 3 dias consecutivos o mas
    (slot Perd_3consec)
    ; Flag que se activa si el valor pierde durante 5 dias consecutivos o mas
    (slot Perd_5consec)
    ; Porcentaje de variacion respecto al sector en los ultimos 5 dias
    (slot Perd_VarRespSector5Dias (type FLOAT))
    ; Variacion respecto al sector los ultimos 5 dias
    (slot VRS5_5)
    ; Variacion mensual del precio 
    (slot Porcentaje_VarMen (type FLOAT))
    ; Variacion trimestral del precio
    (slot Porcentaje_VarTri (type FLOAT))
    ; Variacion del precio durante un semestre
    (slot Porcentaje_VarSem (type FLOAT))
    ; Variacion del precio durante un anio
    (slot Porcentaje_Var12meses (type FLOAT))
)

;-----------------------------------------------
;   Template para los sectores
;-----------------------------------------------

(deftemplate Sector
    ; Nombre de la empresa
    (multislot Nombre)
    ; Porcentaje de variacion del dia
    (slot Var_dia (type FLOAT))
    ; Capitalizacion en miles de euros
    (slot Capitalizacion (type FLOAT))
    ; PER -->  Price Earning Ratio o relacion precio-beneficio
    (slot PER (type FLOAT))
    ; RPD --> Rentabilidad por dividendo
    (slot RPD (type FLOAT))
    ; Porcentaje en el IBEX35
    (slot Porcentaje_IBEX (type FLOAT))
    ; Porcentaje asociado a la variacion del sector durante los ultimos 5 dias
    (slot Porcentaje_Var_5_Dias (type FLOAT))
    ; Flag que se activa si el sector pierde durante 3 dias consecutivos o mas
    (slot Perd_3consec)
    ; Flag que se activa si el sector pierde durante 5 dias consecutivos o mas
    (slot Perd_5consec)
    ; Variacion mensual del precio 
    (slot Porcentaje_VarMen (type FLOAT))
    ; Variacion trimestral del precio
    (slot Porcentaje_VarTri (type FLOAT))
    ; Variacion del precio durante un semestre
    (slot Porcentaje_VarSem (type FLOAT))
    ; Variacion del precio durante un anio
    (slot Porcentaje_Var12meses (type FLOAT))
)

;-----------------------------------------------
;   Template para las noticias
;-----------------------------------------------

(deftemplate Noticia
    ; Indica a que afecta la noticia
    (slot Sobre)
    ; El tipo de noticia --> Buena o Mala
    (slot Tipo)
    ; El numero de dias de antigüedad de la noticia
    (slot Antiguedad (type NUMBER))
)

;-----------------------------------------------
;   Template para los datos pertenecientes a la
;                   cartera
;
;-----------------------------------------------
;       Los datos del dinero en efectivo o
;       DISPONIBLE tendran el mismo valor tanto
;       en "Acciones" como en "ValorActual"
;-----------------------------------------------

(deftemplate Cartera
    ; Nombre de la empresa de la que tenemos acciones
    (slot Nombre)
    ; Numero de acciones que tenemos de esa empresa
    (slot Acciones (type NUMBER))
    ; Valor real de las acciones que tenemos para esa empresa
    (slot ValorActual (type FLOAT))
)

;-----------------------------------------------
;   Template para modelar una propuesta que 
;           genere el sistema experto
;-----------------------------------------------

(deftemplate Propuesta
    ; Almacena el tipo de propuesta que genera
    ;  - Vender empresas peligrosas
    ;  - Vender empresas sobrevaloradas
    ;  - Comprar empresa infravalorada
    ;  - Intercambiar a más rentable
    (slot Tipo)
    ; Nombre de la empresa a la que afecta principalmente
    (slot Nombre1)
    ; Nombre de la segunda empresa, se usa en los intercambios
    (slot Nombre2)
    ; Rendimiento esperado de la propuesta
    (slot RE)
    ; Explicación que genera el sistema 
    (slot Explicacion)
)

;##############################################################################
;#                       MODULO INICIAL DEL PROGRAMA                          #
;#                                                                            #
;#     Cargar el fichero de datos sobre el cierre de la bolsa y dar paso al   #
;#                         resto de modulos del sistema                       #
;##############################################################################

;---------------------------------------------------------------
; Funcion que inicia el sistema
;   - Inserta en la base de hechos IniciarSistema para
;     poder disparar la regla que carga los datos del cierre
;
;   El salience es necesario para obligar a que sea la primera
;   regla que se ejecute 
;---------------------------------------------------------------

(defrule start
    (declare (salience 100))
    => 
    (printout t crlf "¡Bienvenido!" crlf)
    (assert (IniciarSistema))
)

;---------------------------------------------------------------
; Funcion para abrir el fichero de datos del cierre
;---------------------------------------------------------------

(defrule cargarAnalisis
    ?f <- (IniciarSistema)
    =>
    ; (open "../../../../../../DatosIbex35/Analisis.txt" mydata)
    (open "./Analisis.txt" mydata)
    (assert (SeguirLeyendo))
    (retract ?f)
)

;---------------------------------------------------------------
; Funcion que lee los datos y los carga en la base de hechos
;---------------------------------------------------------------

(defrule leerValoresCierreFromFile
    ?f <- (SeguirLeyendo)
    =>
    (bind ?valor (read mydata))
    (retract ?f)
    (if (neq ?valor EOF) then
        (assert (Empresa
                    (Nombre ?valor)
                    (Precio (read mydata))
                    (Var_dia (read mydata))
                    (Capitalizacion (read mydata))
                    (PER (read mydata))
                    (RPD (read mydata))
                    (Tamanio (read mydata))
                    (Porcentaje_IBEX (read mydata))
                    (Etiq_PER (read mydata))
                    (Etiq_RPD (read mydata))
                    (Sector (read mydata))
                    (Porcentaje_Var_5_Dias (read mydata))
                    (Perd_3consec (read mydata))
                    (Perd_5consec (read mydata))
                    (Perd_VarRespSector5Dias (read mydata))
                    (VRS5_5 (read mydata))
                    (Porcentaje_VarMen (read mydata))
                    (Porcentaje_VarTri (read mydata))
                    (Porcentaje_VarSem (read mydata))
                    (Porcentaje_Var12meses (read mydata)))
        )
        (assert (SeguirLeyendo)))
)

;---------------------------------------------------------------
;   Funcion que cierra el fichero sobre el cierre y da paso
;   al modulo que carga los datos sobre los sectores
;---------------------------------------------------------------

(defrule cerrarFicheroValoresCierre
    =>
    (close mydata)
    (assert (leerSectores))
)

;##############################################################################
;#                   MODULO PARA LEER LOS DATOS DE LOS SECTORES               #
;##############################################################################

;---------------------------------------------------------------
; Funcion para abrir el fichero
;---------------------------------------------------------------

(defrule abrirFicheroSectores
    ?f <- (leerSectores)
    =>
    ; (open "../../../../../../DatosIbex35/AnalisisSectores.txt" sectores)
    (open "./AnalisisSectores.txt" sectores)
    (assert (continuarConSectores))
    (retract ?f)
)

;---------------------------------------------------------------
; Funcion que lee los datos y los carga en la base de hechos
;---------------------------------------------------------------

(defrule LeerValoresSectoresFromFile
    ?f <- (continuarConSectores)
    =>
    (bind ?valor (read sectores))
    (retract ?f)
    (if (neq ?valor EOF) then
        (assert (Sector
                    (Nombre ?valor)
                    (Var_dia (read sectores))
                    (Capitalizacion (read sectores))
                    (PER (read sectores))
                    (RPD (read sectores))
                    (Porcentaje_IBEX (read sectores))
                    (Porcentaje_Var_5_Dias(read sectores))
                    (Perd_3consec(read sectores))
                    (Perd_5consec(read sectores))
                    (Porcentaje_VarMen (read sectores))
                    (Porcentaje_VarTri (read sectores))
                    (Porcentaje_VarSem (read sectores))
                    (Porcentaje_Var12meses (read sectores)))
        )
        (assert (continuarConSectores))
        else
            (assert (finalizarSectores))
    )
)

;---------------------------------------------------------------
;   Funcion que cierra el fichero sobre los sectores y da paso
;   al modulo que carga las noticias
;---------------------------------------------------------------

(defrule cerrarFicheroSectores
    ?f <- (finalizarSectores)
    =>
    (close sectores)
    (assert (leerNoticias))
)

;##############################################################################
;#                MODULO PARA LEER LOS DATOS DE LA NOTICIAS                   #
;##############################################################################

;---------------------------------------------------------------
; Funcion para abrir el fichero
;---------------------------------------------------------------

(defrule abrirFicheroNoticias
    ?f <- (leerNoticias)
    =>
    ; (open "../../../../../../DatosIbex35/Noticias.txt" noticias)
    (open "./Noticias.txt" noticias)
    (assert (continuarConNoticias))
    (retract ?f)
)

;---------------------------------------------------------------
; Funcion que lee los datos y los carga en la base de hechos
;---------------------------------------------------------------

(defrule LeerNoticiasFromFile
    ?f <- (continuarConNoticias)
    =>
    (bind ?valor (read noticias))
    (retract ?f)
    (if (neq ?valor EOF) then
        (assert (Noticia
                    (Sobre ?valor)
                    (Tipo (read noticias))
                    (Antiguedad (read noticias))
        ))
        (assert (continuarConNoticias))
        else
            (assert (finLeerNoticias))
    )
)

;---------------------------------------------------------------
;   Funcion que cierra el fichero sobre las noticias y da paso
;   al modulo que carga la cartera
;---------------------------------------------------------------

(defrule cerrarFicheroNoticias
    ?f <- (finLeerNoticias)
    =>
    (close noticias)
    (retract ?f)
    (assert (leerCartera))
)
