/****** Object:  Table [dbo].[26_TDGLegislation]    Script Date: 5/14/2021 10:50:15 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SOURCE__LEGISLATION]') AND type in (N'U'))
DROP TABLE [dbo].[SOURCE__LEGISLATION]
GO

/****** Object:  Table [dbo].[26_TDGLegislation]    Script Date: 5/14/2021 10:50:15 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SOURCE__LEGISLATION](
	[(Do Not Modify) Legislation] [nvarchar](4000) NULL,
	[(Do Not Modify) Row Checksum] [nvarchar](4000) NULL,
	[(Do Not Modify) Modified On] [nvarchar](4000) NULL,
	[Name] [nvarchar](4000) NULL,
	[Legislation Source] [nvarchar](4000) NULL,
	[Parent Legislation] [nvarchar](4000) NULL,
	[English Text] [nvarchar](4000) NULL,
	[Legislation Type] [nvarchar](4000) NULL,
	[Label] [nvarchar](4000) NULL,
	[Enabling Act] [nvarchar](4000) NULL,
	[Enabling Regulation] [nvarchar](4000) NULL,
	[Order] [nvarchar](4000) NULL,
	[French Text] [nvarchar](4000) NULL,
	[Violation Display Text EN] [nvarchar](4000) NULL,
	[Violation Display Text FR] [nvarchar](4000) NULL,
	[Violation Text] [nvarchar](4000) NULL
) ON [PRIMARY]
GO


