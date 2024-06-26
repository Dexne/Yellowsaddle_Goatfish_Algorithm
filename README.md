# Yellowsaddle Goatfish Algorithm

Yellow Saddle Goatfish Algorithm (YSGA)                                    
       Source Paper:
           Bernardo Morales, Daniel Zaldívar, Alma Rodríguez, Arturo Valdivia-G, Erik Cuevas and Marco Pérez-Cisneros
           "A novel bio-inspired optimization model based on Yellow Saddle Goatfish behavior"
           https://doi.org/10.1016/j.biosystems.2018.09.007

       Coded by: [ Dexne ]
       Questions about the code: Send a mail to [ jaredmonje65@gmail.com ]

---

Este es un algoritmo de optimización bioinspirado basado en el comportamiento del pez Cofre Amarillo (Yellow Saddle Goatfish).

## Descripción

El algoritmo YSGA está inspirado en el comportamiento de caza y formación de grupos del pez Cofre Amarillo. Utiliza una combinación de persecución por el líder del grupo, acorralamiento por peces bloqueadores y otros operadores de movimiento para encontrar soluciones óptimas a problemas de optimización.

## Funcionamiento

El algoritmo YSGA se implementa en MATLAB y consta de varias etapas:

1. **Inicialización**: Se establecen los parámetros del algoritmo, como el número máximo de iteraciones, el tamaño de la población, el número de dimensiones, etc.
2. **Agrupamiento inicial**: Se utiliza el algoritmo K-means para agrupar aleatoriamente la población inicial en varios grupos.
3. **Ciclo principal**: En cada iteración, se aplican operadores de movimiento para actualizar las posiciones de los individuos en cada grupo. Estos operadores incluyen persecución por el líder del grupo, acorralamiento por peces bloqueadores, cambio de roles y cambio de zona.
4. **Finalización**: El algoritmo termina después de un número predeterminado de iteraciones o cuando se cumple un criterio de parada.

## Uso

Para utilizar el algoritmo YSGA, sigue estos pasos:

1. Clona el repositorio en tu máquina local.
2. Abre MATLAB y navega hasta el directorio donde se encuentra el código.
3. Ejecuta el script principal `YSGA.m`.
4. Espera a que el algoritmo termine de ejecutarse.
5. Revisa los resultados en la ventana de comandos de MATLAB o en las variables guardadas.

## Referencias

- Bernardo Morales, Daniel Zaldívar, Alma Rodríguez, Arturo Valdivia-G, Erik Cuevas and Marco Pérez-Cisneros. "A novel bio-inspired optimization model based on Yellow Saddle Goatfish behavior". [Link al artículo](https://doi.org/10.1016/j.biosystems.2018.09.007)

## Contribuciones

Las contribuciones a este proyecto son bienvenidas. Si tienes sugerencias de mejoras, por favor crea un issue o envía un pull request.

## Autor

[ Jared Isaías Monje Flores - Dexne ]

## Contacto

Para preguntas sobre el código o colaboraciones, contáctame en [ jaredmonje65@gmail.com ].

