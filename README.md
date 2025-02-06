# Base de Datos

Este repositorio contiene la definición de la base de datos utilizada en el proyecto. La base de datos gestiona información clave para la aplicación, incluyendo la inserción de pedidos mediante un procedimiento almacenado (**Stored Procedure**).

## 📂 Resumen

La base de datos incluye un procedimiento almacenado para la inserción de pedidos. Este procedimiento facilita la gestión de pedidos en la plataforma y asegura la integridad de los datos.

### 📌 Stored Procedure: Insertar Pedido

### Uso de SP 

EXEC InsertarPedido @UsuarioID = 2, @ProductoID = 5, @Estado = 'Pendiente';
