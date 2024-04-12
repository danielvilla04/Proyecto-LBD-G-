-- Archivo para crear las vistas materializadas que trajarán dentro de la DB



--VISTAS MATERIALIZADAS PARA EL APARTADO DE fACTURACION

-- Vista Materializada de Total de Ventas por Cliente
CREATE MATERIALIZED VIEW vm_ventas_por_cliente AS
SELECT f.id_cliente, COUNT(*) AS total_ventas 
FROM historial_ventas hv
INNER JOIN factura_tb f ON hv.id_factura = f.id_factura 
GROUP BY f.id_cliente;


--Vista Materializada de Facturas Pendientes:

CREATE MATERIALIZED VIEW mv_facturas_pendientes AS
SELECT id_factura, id_cliente, fecha_facturacion, total
FROM factura_tb
WHERE estado = 'pendiente';


--Total de Ventas por Mes
CREATE MATERIALIZED VIEW vm_ventas_por_mes AS
SELECT TO_CHAR(fecha_facturacion, 'YYYY-MM') AS mes,
       SUM(total) AS total_ventas
FROM factura_tb
GROUP BY TO_CHAR(fecha_facturacion, 'YYYY-MM');

--Productos Más Vendidos:

CREATE MATERIALIZED VIEW mv_productos_mas_vendidos AS
SELECT id_producto,
       SUM(cantidad_productos) AS total_vendido
FROM detalle_factura_tb
GROUP BY id_producto
ORDER BY SUM(cantidad_productos) DESC;


--Clientes con Mayor Gasto:
CREATE MATERIALIZED VIEW mv_clientes_mayor_gasto AS
SELECT id_cliente,
       SUM(total) AS total_gastado
FROM factura_tb
GROUP BY id_cliente
ORDER BY SUM(total) DESC;


--Resumen de Ventas por Empleado
CREATE MATERIALIZED VIEW mv_ventas_por_empleado AS
SELECT id_empleado,
       COUNT(*) AS total_ventas,
       SUM(total) AS total_ventas_valor
FROM factura_tb
GROUP BY id_empleado;

