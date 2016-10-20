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