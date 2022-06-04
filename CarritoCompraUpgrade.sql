
IF NOT EXISTS (SELECT * FROM sysdatabases WHERE (name = 'CarritoCompra')) 
BEGIN
	
	CREATE DATABASE [CarritoCompra] ON  PRIMARY 
	( NAME = N'CarritoCompra', FILENAME = N'C:\temporal\CarritoCompra.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
	 LOG ON 
	( NAME = N'CarritoCompra_log', FILENAME = N'C:\temporal\CarritoCompra_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
END




IF EXISTS (SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[Usuario]') AND [type]='U')
    DROP TABLE [dbo].[Usuario];

IF EXISTS (SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[producto]') AND [type]='U')
    DROP TABLE [dbo].[producto];
	
IF EXISTS (SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[Plan]') AND [type]='U')
    DROP TABLE [dbo].[Plan];

IF EXISTS (SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[ProductosPlan]') AND [type]='U')
    DROP TABLE [dbo].[ProductosPlan];


IF EXISTS (SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[OrdenUsuario]') AND [type]='U')
    DROP TABLE [dbo].[OrdenUsuario];	
	
--Crea Tablas  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


IF NOT (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[Usuario]') AND [type]='U'))
BEGIN
CREATE TABLE [dbo].[Usuario](
	[idusuario] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[telefono] [varchar](50) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[password] [varchar](200) NOT NULL,
	[UsuarioCrea] [varchar](20) NOT NULL,
	[FechaCrea] [datetime] NOT NULL,
	[UsuarioModifica] [varchar](20) NULL,
	[FechaModifica] [datetime] NULL,
 CONSTRAINT [Usuario_idusuario_PK] PRIMARY KEY CLUSTERED 
(
	[idusuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

END

-----------------------------------------------------------------------------------------------------------

IF NOT (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[producto]') AND [type]='U'))
BEGIN
CREATE TABLE [dbo].[producto](
	[idproducto] [int] IDENTITY(1,1) NOT NULL,
	[CodProducto] [int] NOT NULL,
	[descripcion] [varchar](50) NOT NULL,
	[precio] [money] NOT NULL,
	[estado] [varchar](10) NOT NULL,
	[detalle] [varchar](max) NOT NULL,
	[imagen] [varchar](100) NOT NULL,
	[UsuarioCrea] [varchar](20) NOT NULL,
	[FechaCrea] [datetime] NOT NULL,
	[UsuarioModifica] [varchar](20) NULL,
	[FechaModifica] [datetime] NULL,
 CONSTRAINT [Producto_idproducto_PK] PRIMARY KEY CLUSTERED 
(
	[idproducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

END

-----------------------------------------------------------------------------------------------------------


IF NOT (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[Plan]') AND [type]='U'))
BEGIN
CREATE TABLE [dbo].[Plan](
	[idPlan] [int] IDENTITY(1,1) NOT NULL,
	[codigoplan] [int] NULL,
	[nombre] [varchar](50) NOT NULL,
	[icono] [varchar](50)  NULL,
	[descripcion] [varchar](max) NOT NULL,
	[valor] [money] NOT NULL,
	[frecuencia] [varchar](50)  NULL,	
	[planb] [int] NULL,
	[UsuarioCrea] [varchar](20) NOT NULL,
	[FechaCrea] [datetime] NOT NULL,
	[UsuarioModifica] [varchar](20) NULL,
	[FechaModifica] [datetime] NULL,
 CONSTRAINT [Plan_idPlan_PK] PRIMARY KEY CLUSTERED 
(
	[idPlan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

END


-----------------------------------------------------------------------------------------------------------


IF NOT (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[ProductosPlan]') AND [type]='U'))
BEGIN
CREATE TABLE [dbo].[ProductosPlan](
	[idprodplan] [int] IDENTITY(1,1) NOT NULL,
	[codigoplan] [int] NULL,
	[CodProducto] [int] NOT NULL,
	[descripcion] [varchar](max)  NULL,	
	[cantidad] [int] NULL,
	[UsuarioCrea] [varchar](20) NOT NULL,
	[FechaCrea] [datetime] NOT NULL,
	[UsuarioModifica] [varchar](20) NULL,
	[FechaModifica] [datetime] NULL,
 CONSTRAINT [ProductosPlan_idprodplan_PK] PRIMARY KEY CLUSTERED 
(
	[idprodplan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

END

-----------------------------------------------------------------------------------------------------------

IF NOT (EXISTS(SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID(N'[dbo].[OrdenUsuario]') AND [type]='U'))
BEGIN
CREATE TABLE [dbo].[OrdenUsuario](
	[idorden] [int] IDENTITY(1,1) NOT NULL,
	[CodProducto] [int] NOT NULL,
	[idusuario] [int] NOT NULL,
	[descripcion] [varchar](50)  NULL,	
	[cantidad] [int] NULL,
	[UsuarioCrea] [varchar](20) NOT NULL,
	[FechaCrea] [datetime] NOT NULL,
	[UsuarioModifica] [varchar](20) NULL,
	[FechaModifica] [datetime] NULL,
 CONSTRAINT [OrdenUsuario_idorden_PK] PRIMARY KEY CLUSTERED 
(
	[idorden] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

END

--Crea indices  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

IF EXISTS (SELECT * FROM sys.indexes WHERE name='Idx_Producto_CodProducto' AND object_id = OBJECT_ID('[dbo].[producto]')) 
 DROP INDEX Idx_Producto_CodProducto  ON [dbo].[producto]; 


CREATE INDEX Idx_Producto_CodProducto
ON [dbo].[producto] (CodProducto);

------------------------------------------------------------------------------------------------


IF EXISTS (SELECT * FROM sys.indexes WHERE name='Idx_ProductosPlan_codigoplan' AND object_id = OBJECT_ID('[dbo].[ProductosPlan]')) 
 DROP INDEX Idx_ProductosPlan_codigoplan  ON [dbo].[ProductosPlan]; 


CREATE INDEX Idx_ProductosPlan_codigoplan
ON [dbo].[ProductosPlan] (codigoplan);


--inserta datos  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



IF NOT EXISTS (SELECT *  FROM [CarritoCompra].[dbo].[Usuario] where nombre='Daniel Silva Orrego')
	BEGIN 
		
		Insert	Into [CarritoCompra].[dbo].[Usuario]
				(nombre,telefono,email,password,UsuarioCrea,FechaCrea)
		Values	( 'Daniel Silva Orrego','0981222673','danielsilvaorrego@gmail.com','89e495e7941cf9e40e6980d14a16bf023ccd4c91','SYSADMIN',GETDATE()  )	
		
	END
--

IF NOT EXISTS (SELECT *  FROM [CarritoCompra].[dbo].[producto] where CodProducto=44)
	BEGIN 
		
		Insert	Into [CarritoCompra].[dbo].[producto]
				(CodProducto,descripcion,precio,estado,detalle,imagen,UsuarioCrea,FechaCrea)
		Values	( 44,'TERNO 2 PIEZAS SECO',8.5,'true','El terno de 2 piezas incluye la leva y el pantalón, el lavado es en seco, se entrega en armador y con su respectiva funda','seco-terno2.jpg', 'SYSADMIN',GETDATE()  )	
		
	END
--

IF NOT EXISTS (SELECT *  FROM [CarritoCompra].[dbo].[producto] where CodProducto=45)
	BEGIN 
		
		Insert	Into [CarritoCompra].[dbo].[producto]
				(CodProducto,descripcion,precio,estado,detalle,imagen,UsuarioCrea,FechaCrea)
		Values	( 45,'TERNO 3 PIEZAS SECO',9.5,'true','El terno de 3 piezas incluye la leva, el chaleco y el pantalón, el lavado es en seco, se entrega en armador y con su respectiva funda','seco-terno3.jpg','SYSADMIN',GETDATE()  )	
		
	END
--

IF NOT EXISTS (SELECT *  FROM [CarritoCompra].[dbo].[producto] where CodProducto=46)
	BEGIN 
		
		Insert	Into [CarritoCompra].[dbo].[producto]
				(CodProducto,descripcion,precio,estado,detalle,imagen,UsuarioCrea,FechaCrea)
		Values	( 46,'LEVA SECO',4.75,'true','La leva es lavada en seco  con el mayor cuidado de la prenda, se entrega en armador y con su respectiva funda','seco-leva.jpg','SYSADMIN',GETDATE()  )	
		
	END
--


IF NOT EXISTS (SELECT *  FROM [CarritoCompra].[dbo].[producto] where CodProducto=47)
	BEGIN 
		
		Insert	Into [CarritoCompra].[dbo].[producto]
				(CodProducto,descripcion,precio,estado,detalle,imagen,UsuarioCrea,FechaCrea)
		Values	( 47,'CAMISA SECO',3.00,'true','La camisa es lavada en seco  con el mayor cuidado de la prenda, se entrega en armador y con su respectiva funda','seco-camisa.jpg','SYSADMIN',GETDATE()  )	
		
	END
--



IF NOT EXISTS (SELECT *  FROM  [CarritoCompra].[dbo].[Plan] where codigoplan=001)
	BEGIN 
		
		Insert	Into [CarritoCompra].[dbo].[Plan]
				(codigoplan,nombre,icono,descripcion,valor,frecuencia,planb,UsuarioCrea,FechaCrea)
		Values	( 1,'Plan Estudiantil','plan3.jpg','¿Necesitas más tiempo para estudiar y tienes ropa que lavar? Este plan es para ti',21.00,'',6,'SYSADMIN',GETDATE()  )	
		
	END
--


IF NOT EXISTS (SELECT *  FROM  [CarritoCompra].[dbo].[ProductosPlan] where CodProducto=64)
	BEGIN 
		
		Insert	Into  [CarritoCompra].[dbo].[ProductosPlan]
				(codigoplan,CodProducto,descripcion,cantidad,UsuarioCrea,FechaCrea)
		Values	( 1,64,'FUNDA DE LAVANDERÍA',2.00,'SYSADMIN',GETDATE()  )	
		
	END
--



--Scaffold-DbContext “Server=RGT40-131\DELISOFT;Database=CarritoCompra;User ID=TuUsuario;Password=TuContraseña” Microsoft.EntityFrameworkCore.SqlServer -OutputDir Models

--Scaffold-DbContext "Server=GT40-131\DELISOFT;Database=CarritoCompra;Trusted_Connection=True;" Microsoft.EntityFrameworkCore.SqlServer -OutputDir Models
