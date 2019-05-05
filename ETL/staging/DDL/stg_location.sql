CREATE TABLE [dbo].[stg_location](
	[loc_key] [varchar](3) NOT NULL,
	[loc_name] [varchar](100) NOT NULL,
	[loc_type] [int] NULL,
	[parent_key] [varchar](3) NULL
)
