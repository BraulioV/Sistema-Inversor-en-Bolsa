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
