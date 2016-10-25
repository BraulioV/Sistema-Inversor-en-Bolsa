# Sistema Experto Inversor en Bolsa

##Práctica final de la asignatura de Ingeniería del Conocimiento de la UGR 2015-2016

La práctica consistía en implementar un sistema experto capaz de invertir en la bolsa del IBEX 35, haciendo uso del conocimiento "experto" que se extrajo del profesor de la asignatura. 

El sistema primero añadirá a la base de hechos, el conocimiento que dispone del mundo leyendo la información de los diferentes ficheros que existe, para obtener qué empresas hay en el IBEX 35, la información de nuestra cartera, las noticias que han sucedido, el estado de los sectores, etc. 

Una vez hecho esto, el sistema **pasará a analizar qué valores son inestables y cuales no**, e introducir este conocimiento deducido en su base de hechos y hacer uso de esto más adelante. Tras esto, pasará a **detectar los valores sobrevalorados**, **los infravalorados** para finalmente pasar a **detectar los valores peligrosos**.

Una vez finalizado todo el proceso de razonamiento, **el sistema razonará cuáles son las mejores propuestas** que puede ofrecer y mostrará al usuario las 5 mejores, junto con una explicación de por qué ha deducido eso y le dará al usuario la opción de aplicar una de las 5 opciones o salir del sistema. 

Una vez escogida una opción, el sistema actualizará la base de hechos y volverá a realizar el proceso de razonamiento para volver a ofrecer al usuario nuevas propuestas, si así lo desea.

##Cómo ejecutarlo

Para ejecutarlo, es necesario tener instalado `CLIPS` y hacer lo siguiente:

```
(load sistemaInversor.clp)
(reset)
(run)
``` 

Para compilar la memoria, tenemos que introducir en la consola lo siguiente:

```
pdflatex memoria.tex
```
