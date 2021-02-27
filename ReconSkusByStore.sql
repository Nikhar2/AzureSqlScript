USE [${Environment}International]
GO

/****** Object:  UserDefinedTableType [dbo].[ReconSkusByStore]    Script Date: 28-12-2020 23:41:50 ******/
CREATE TYPE [dbo].[ReconSkusByStore] AS TABLE(
	[StoreID] [int] NOT NULL,
	[SkuStore] [varchar](100) NOT NULL,
	[Description] [varchar](max) NULL,
	[Quantity] [int] NULL,
	PRIMARY KEY CLUSTERED 
(
	[StoreID] ASC,
	[SkuStore] ASC
)WITH (IGNORE_DUP_KEY = OFF)
)
GO


