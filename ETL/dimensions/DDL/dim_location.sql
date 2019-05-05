CREATE TABLE [dbo].[dim_location](
	[loc_id] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[loc_key] [varchar](3) NOT NULL,
	[loc_name] [varchar](100) NOT NULL,
	[loc_type] [int] NOT NULL
)
