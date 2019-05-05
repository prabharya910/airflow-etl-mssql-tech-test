CREATE TABLE [dbo].[fact_sales](
	[sales_id] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[fk_loc_id] [int] NULL,
	[fk_loc_type_id] [int] NULL,
	[fk_item_id] [int] NULL,
	[sales_date] [date] NULL,
	[sales_amount] [float] NULL
)
