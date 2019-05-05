CREATE TABLE [dbo].[location](
	[loc_key] [varchar](3) NOT NULL,
	[loc_name] [varchar](100) NOT NULL,
	[loc_type] [int] NOT NULL,
	[parent_key] [varchar](3) NULL
)