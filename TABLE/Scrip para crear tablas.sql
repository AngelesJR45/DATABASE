CREATE TABLE Usuario (
    UsuarioID INT IDENTITY(1,1) PRIMARY KEY,
    NombreUsu VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    Contrasenia VARCHAR(255) NOT NULL,
    Rol VARCHAR(50) CHECK (Rol IN ('admin', 'cliente')) DEFAULT 'cliente',
    RefreshToken VARCHAR(255)
);

CREATE TABLE Producto (
    ProductoID INT IDENTITY(1,1) PRIMARY KEY,
    NombreP VARCHAR(255) NOT NULL,
    Precio DECIMAL(10,2) NOT NULL,
    Stock INT NOT NULL,
    createdAt DATETIME DEFAULT GETDATE(),
    updatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE Pedido (
    PedidoID INT IDENTITY(1,1) PRIMARY KEY,
    UsuarioID INT NOT NULL,
    ProductoID INT NOT NULL,
    FechaPedido DATETIME DEFAULT GETDATE(),
    Estado VARCHAR(50) CHECK (Estado IN ('Pendiente', 'Enviado', 'Entregado')) DEFAULT 'Pendiente',
    FOREIGN KEY (UsuarioID) REFERENCES Usuario(UsuarioID),
    FOREIGN KEY (ProductoID) REFERENCES Producto(ProductoID)
);

CREATE TABLE DetallesPedido (
    DetalleID INT IDENTITY(1,1) PRIMARY KEY,
    PedidoID INT NOT NULL,
    ProductoID INT NOT NULL,
    FOREIGN KEY (PedidoID) REFERENCES Pedido(PedidoID),
    FOREIGN KEY (ProductoID) REFERENCES Producto(ProductoID)
);