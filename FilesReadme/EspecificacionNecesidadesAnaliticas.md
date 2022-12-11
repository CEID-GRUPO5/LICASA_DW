# **Especificación de necesidades analíticas que el modelo dimensional propuesto solventará**

Mediante entrevistas con diferentes usuarios con conocimiento del negocio, funcionamiento de la herramienta ERP Softland e interesados en la solución del modelo de Data Warehouse, logramos identificar algunas necesidades analíticas con las que se pretende brindar un apoyo al proceso de análisis sobre la situación de la empresa en el tiempo desde la perspectiva de sus clientes y vendedores. Los usuarios manifestaron el interés de contar con dos reportes, los cuales se detallan a continuación:

### **Reporte de ventas:**

Informe donde se desea conocer valores montos totales sobre sus transacciones. En el desean conocer los siguientes valores:

- La utilidad total de las ventas
- El costo total de las ventas
- El total de lo vendido
- La cantidad de ventas hechas
- El total de artículos vendidos
- El total de impuesto de las ventas
- El total de descuento
- El producto más y menos vendido
- El tiempo de recompra de cada cliente

### **Reporte comparativo de ingresos y crecimiento entre periodos:**

Este informe busca brindar información acerca de incrementos en los montos vendidos para determinar si esos posibles incrementos en los ingresos generados se deben al aumento de precios por factores económicos externos, como la inflación, o a un crecimiento el número de articulos vendidos en los diferentes periodos. 

Lo que se busca mostrar son los montos vendidos y la cantidad de articulos vendidos por periodos iguales a un año para que los usuarios interesados puedan observar los valores y comparar si hay un aumento en los ingresos y si se debe a una mayor cantidad de articulos vendidos. Dado que la empresa vende todos sus productos de forma individual, la unidad de medida para cada uno es la misma: Unidad. 

### **Reporte de rendimiento de vendedores:**

El informe de rendimiento de los vendedores busca conocer la situación de la ventas que cada empleado genera para poder conocer el avance en el tiempo hacia la meta planteada por la empresa año con año y tambien para brindar incentivos a los empleados según su rendimiento. Lo que se desea conocer son el margen de utilidad que cada empleado aporta con relación a la meta establecida para cada uno. 

La meta del periodo se desea calcular como el promedio de lo vendido en los ultimos 6 meses por cada vendedor más el 20% de ese valor en relación al rango de fechas que se desea evaluar. Para, posteriormente, utilizar dicho valor y calcular el margen de utilidad que representa cada venta hecha en el periodo en cuestión. 

La fórmula a utilizar seria:

Margen=(TotalVendido/MetaDelPeriodo)×100 


---
[Anterior](ResultadosDataProfiling.md)

[Siguiente](ModeloDimensional.md)

[Regresar a pagina principal](../README.md)