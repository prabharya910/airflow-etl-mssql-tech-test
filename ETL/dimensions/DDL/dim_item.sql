CREATE TABLE [dbo].[dim_item](
	[item_id] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[item_Key] [int] NOT NULL,
	[item_Name] [varchar](100) NULL)
