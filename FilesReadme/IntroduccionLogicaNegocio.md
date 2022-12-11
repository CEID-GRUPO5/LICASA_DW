# **Introducción a la lógica del negocio**

Las transacciones de ventas al sistema inician mediante pedidos, lo cuales pueden ser ingresados por un vendedor o por un validador (persona encargada de verificar el pedido y aprobar dicho pedido). Aunque el sistema permite la gestión de cotizaciones, la institución no hace uso de esa función en el sistema, sino que, proceden directamente a la gestión de los pedidos.

Durante la creación del pedido al asignarle el cliente al pedido, el usuario debe seleccionar el valor consecutivo que se le agregara al documento, pudiendo ser de tipo Factura de consumidor final o Crédito fiscal. Esta selección afectara los valores impreso en la factura. Si fuese crédito fiscal, al subtotal debe restársele un 1% de la venta neta, además de detallarse el valor del IVA de la venta. Caso, contrario solo se muestro los totales sin mayor detalle.

Una vez los pedidos han sido creados, estos son revisados por un validador, el cual es responsable de verificar, a través del ER, si se cuenta con el inventario suficiente en la bodega para cada uno de los productos que requiere el cliente. No se realizan pedidos parciales, la institución entrega la cantidad solicitada del producto o no lo entrega. En caso de no contar con la cantidad suficiente para surtir el pedido, el sistema permite la eliminación de las líneas del pedido cuyo inventario no es mayor o igual a lo solicitado. Cabe mencionar, que la institución únicamente hace uso de dos bodegas: General y Averías. Sus articulos sólo son despachados desde la bodega general, es por ello que, otro paso dentro de la validación es cerciorarse que los articulos serán tomados de la bodega correcta, previo a validar el inventario. Adicionalmente, en esta fase inicial, en la cual los pedidos están identificados con el estado de ‘Normal’, el ER permite aplicar descuentos sobre cada producto y de forma global a todo el pedido, si así se requiere. Otro paso que el validador debe realizar es asignarle un cobrador al pedido con base a la ruta configurada en el cliente, el cual es copiada al pedido, y una hoja de ruta que maneja la institución internamente donde detalla que ruta tendrá cada cobrador diariamente. Posterior a la verificación, el validador ‘Aprueba’ el pedido, cuando esto sucede, el ER cambia el estado del pedido de ‘Normal’ a ‘Aprobado’.

Debe mencionarse que el sistema permite la reserva de inventario para cada pedido en estado ‘Normal’ o ‘Aprobado’, esto causa que el inventario del producto en la bodega seleccionada se vea reducido cuando se consulta. Sin embargo, esta función no es utilizada por el cliente, lo que causa que el ER actualice el valor del inventario hasta que el pedido ha llegado a su fase final; es decir, ha sido facturado.

Cuando a un pedido se le ha aplicado descuentos por producto y, además, un descuento global, el sistema totaliza las líneas del pedido (total mercadería), dicho total ya ha sido afectado por el descuento por producto, sobre ese total mercadería se aplica el descuento global, el cual se maneja mediante porcentaje. El sistema no permite agregar el monto directamente.

Luego de que el pedido ha sido aprobado, pasa al departamento de facturación. Este departamento realiza una revisión muy parecida a la del validador para verificar que no se le haya escapado ningún detalle. En caso, de alguna inconsistencia, el departamento desaprueba el pedido, a lo cual el sistema reacciona actualizando el pedido a estado ‘Normal’. Si todo está en orden, el departamento utiliza la función de ‘Generar factura/Boleta’. Esta acción desencadena un proceso que realiza la creación de los registros en la base de datos en las tablas que almacenan la información del encabezado de la factura y sus líneas y se imprime el documento. Vale mencionar que una vez impresa la factura no se puede volver a imprimir el documento, de ser necesario se efectúa una refacturación; es decir, realizar todo el proceso nuevamente. A continuación, un diagrama BPMN del proceso que la institución lleva acabo en el sistema.

![BPMN](../FilesReadme/IntroduccionLogicaNegocio/BPMN.png)

---

[Anterior](Objetivos.md)

[Siguiente](DescripcionDataSet.md)

[Regresar a pagina principal](../README.md)