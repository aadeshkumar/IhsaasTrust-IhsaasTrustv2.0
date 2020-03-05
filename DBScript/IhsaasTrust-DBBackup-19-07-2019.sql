
/****** Object:  Database [IhsaasTrust]    Script Date: 20/07/2019 12:05:14 AM ******/
CREATE DATABASE [IhsaasTrust]
GO
CREATE TABLE [dbo].[Applications](
	[ApplicationID] [int] IDENTITY(1,1) NOT NULL,
	[ApplicationCode] [nvarchar](30) NOT NULL,
	[Date] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
 CONSTRAINT [PK_Applications] PRIMARY KEY CLUSTERED 
(
	[ApplicationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ApprovalHierarchies]    Script Date: 20/07/2019 12:05:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ApprovalHierarchies](
	[ApprovalHierarchyID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[ReportedTo] [int] NULL,
	[CandidateID] [int] NULL,
	[IsExempt] [bit] NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
 CONSTRAINT [PK_ApprovalHierarchies] PRIMARY KEY CLUSTERED 
(
	[ApprovalHierarchyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Approvals]    Script Date: 20/07/2019 12:05:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Approvals](
	[ApprovalID] [int] IDENTITY(1,1) NOT NULL,
	[EntityID] [smallint] NOT NULL,
	[RowID] [int] NOT NULL,
	[StatusID] [smallint] NOT NULL,
	[UserID] [int] NOT NULL,
	[Reason] [nvarchar](1000) NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
 CONSTRAINT [PK_Approvals] PRIMARY KEY CLUSTERED 
(
	[ApprovalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Statuses]    Script Date: 20/07/2019 12:05:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Statuses](
	[StatusID] [smallint] NOT NULL,
	[StatusName] [nvarchar](50) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
 CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED 
(
	[StatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ApprovalRequests]    Script Date: 20/07/2019 12:05:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE View [dbo].[ApprovalRequests]
AS
Select A.ApprovalID, AH.ReportedTo, AH.CandidateID, A.UserID, A.EntityID, AP.ApplicationID, AP.ApplicationCode, A.StatusID, A.Reason, A.CreatedOn, A.CreatedBy, A.ModifiedOn, A.ModifiedBy, S.StatusName
From Approvals A
Inner Join ApprovalHierarchies AH
On A.UserID = AH.UserID 
Inner Join Applications AP
On AP.ApplicationID = A.RowID
Inner Join Statuses S
On S.StatusID = A.StatusID
Where AH.ReportedTo IS NOT NULL AND AH.IsActive = 1
GO
/****** Object:  Table [dbo].[AppConfigs]    Script Date: 20/07/2019 12:05:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppConfigs](
	[AppConfigKey] [varchar](64) NOT NULL,
	[AppConfigValue] [varchar](512) NOT NULL,
	[IsEditableByUser] [bit] NOT NULL,
	[Description] [varchar](1024) NULL,
 CONSTRAINT [PK_AppConfigs] PRIMARY KEY CLUSTERED 
(
	[AppConfigKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DynamicSetupScreens]    Script Date: 20/07/2019 12:05:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DynamicSetupScreens](
	[DynamicSetupScreenID] [int] IDENTITY(1,1) NOT NULL,
	[ScreenName] [nvarchar](150) NULL,
	[DS_TableName] [nvarchar](50) NOT NULL,
	[DS_Title] [nvarchar](250) NOT NULL,
	[DS_AllowAddEdit] [bit] NULL,
	[DS_AllowPreview] [bit] NULL,
	[DS_AllowSearchFilter] [bit] NULL,
	[DS_AllowListingGrid] [bit] NULL,
	[DS_GridColumns] [nvarchar](1024) NULL,
	[DS_AllowDelete] [bit] NULL,
	[DS_AllowEdit] [bit] NULL,
	[DS_AllowApprovals] [bit] NOT NULL,
	[DS_ExcludeAddEditColumns] [nvarchar](1024) NULL,
	[DS_ExcludeSearchColumns] [nvarchar](1024) NULL,
	[DS_ShowAddNewButton] [nchar](10) NULL,
	[DS_GridTitle] [nvarchar](100) NULL,
	[DS_OrderBy] [nvarchar](100) NULL,
	[DS_DoNotRenderJavaScript] [bit] NULL,
	[DS_ExtenderName] [nvarchar](250) NULL,
	[DS_DontLoadRecursiveData] [bit] NULL,
	[DS_AllowImport] [bit] NULL,
	[DS_ParentColumnNameForRecursiveGrid] [nvarchar](500) NULL,
	[DS_RecordsPerPage] [int] NULL,
	[DS_ImportURL] [nvarchar](500) NULL,
	[DS_ManualCrud] [bit] NULL,
	[DS_Filters] [nvarchar](1024) NULL,
	[DS_DisableSorting] [bit] NULL,
	[DS_ShowHistory] [bit] NULL,
	[DS_IsMenuNavigation] [bit] NULL,
	[DS_SecondaryTableConfigs] [nvarchar](max) NULL,
	[DS_CustomJavaScript] [nvarchar](max) NULL,
	[DS_Condition] [nvarchar](1024) NULL,
	[DS_CustomQuery] [nvarchar](max) NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
 CONSTRAINT [PK_DynamicScreens] PRIMARY KEY CLUSTERED 
(
	[DynamicSetupScreenID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Entities]    Script Date: 20/07/2019 12:05:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Entities](
	[EntityID] [smallint] NOT NULL,
	[NameEn] [varchar](64) NOT NULL,
	[DataVersion] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
 CONSTRAINT [PK4] PRIMARY KEY CLUSTERED 
(
	[EntityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EntityDetails]    Script Date: 20/07/2019 12:05:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EntityDetails](
	[EntityDetailsID] [int] IDENTITY(1,1) NOT NULL,
	[EntityID] [smallint] NOT NULL,
	[ColumnName] [nvarchar](256) NOT NULL,
	[DisplayNameEn] [nvarchar](256) NOT NULL,
	[DisplayNameAr] [nvarchar](256) NULL,
	[DbTypeID] [smallint] NOT NULL,
	[IsRequired] [bit] NOT NULL,
	[IsGroup] [bit] NULL,
	[ParentSubGroupID] [int] NULL,
	[ParentEntityDetailsID] [int] NULL,
	[IsForeignkey] [bit] NOT NULL,
	[RefrencedTableName] [varchar](256) NULL,
	[EnableAutoComplate] [bit] NOT NULL,
	[AutoCompleteSourceQuery] [nvarchar](max) NULL,
	[IsDigit] [bit] NULL,
	[ValidationExpression] [nvarchar](256) NULL,
	[AddEditVisible] [bit] NOT NULL,
	[GridVisible] [bit] NOT NULL,
	[SearchFilterVisible] [bit] NOT NULL,
	[MaxLength] [smallint] NOT NULL,
	[IsAutoID] [bit] NOT NULL,
	[IsPrimaryKey] [bit] NOT NULL,
	[DisplaySeqNo] [int] NULL,
	[IsFileUpload] [bit] NULL,
	[AllowedFiles] [nvarchar](256) NULL,
	[ShowGroupTitle] [bit] NOT NULL,
	[PlaceHolderText] [nvarchar](200) NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
 CONSTRAINT [PK_EntityDetails] PRIMARY KEY CLUSTERED 
(
	[EntityDetailsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fields]    Script Date: 20/07/2019 12:05:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fields](
	[FieldID] [int] IDENTITY(1,1) NOT NULL,
	[ParentFieldID] [int] NULL,
	[FieldName] [nvarchar](150) NOT NULL,
	[FieldTypeID] [smallint] NOT NULL,
	[DisplayName] [nvarchar](150) NOT NULL,
	[IsRequired] [bit] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[DisplaySeqNo] [int] NOT NULL,
	[Source] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
 CONSTRAINT [PK_Fields] PRIMARY KEY CLUSTERED 
(
	[FieldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FieldTypes]    Script Date: 20/07/2019 12:05:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FieldTypes](
	[FieldTypeID] [smallint] NOT NULL,
	[FieldTypeName] [nvarchar](50) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
 CONSTRAINT [PK_FieldTypes] PRIMARY KEY CLUSTERED 
(
	[FieldTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FieldValues]    Script Date: 20/07/2019 12:05:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FieldValues](
	[FieldValueID] [int] IDENTITY(1,1) NOT NULL,
	[ApplicationID] [int] NOT NULL,
	[FieldID] [int] NOT NULL,
	[Data] [nvarchar](max) NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
 CONSTRAINT [PK_FieldValues] PRIMARY KEY CLUSTERED 
(
	[FieldValueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RationAmounts]    Script Date: 20/07/2019 12:05:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RationAmounts](
	[RationAmountID] [smallint] IDENTITY(1,1) NOT NULL,
	[NoOfPerson] [int] NOT NULL,
	[Amount] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
 CONSTRAINT [PK_RationAmounts] PRIMARY KEY CLUSTERED 
(
	[RationAmountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rights]    Script Date: 20/07/2019 12:05:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rights](
	[RightID] [smallint] NOT NULL,
	[RightName] [nvarchar](50) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
 CONSTRAINT [PK_Rights] PRIMARY KEY CLUSTERED 
(
	[RightID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoleRights]    Script Date: 20/07/2019 12:05:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleRights](
	[RoleRightID] [int] IDENTITY(1,1) NOT NULL,
	[RoleID] [smallint] NOT NULL,
	[RightID] [smallint] NOT NULL,
	[EntityID] [smallint] NOT NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
 CONSTRAINT [PK_RoleRights] PRIMARY KEY CLUSTERED 
(
	[RoleRightID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 20/07/2019 12:05:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleID] [smallint] NOT NULL,
	[RoleName] [nvarchar](50) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRoles]    Script Date: 20/07/2019 12:05:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoles](
	[UserRoleID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[RoleID] [smallint] NOT NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
 CONSTRAINT [PK_UserRoles] PRIMARY KEY CLUSTERED 
(
	[UserRoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 20/07/2019 12:05:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](256) NOT NULL,
	[DisplayName] [nvarchar](32) NOT NULL,
	[Email] [nvarchar](256) NOT NULL,
	[Password] [nvarchar](256) NOT NULL,
	[PictureID] [int] NULL,
	[PictureURL] [nvarchar](1024) NULL,
	[MobileNo] [nvarchar](32) NULL,
	[StatusID] [smallint] NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedOn] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedBy] [int] NULL
) ON [PRIMARY]
GO
INSERT [dbo].[AppConfigs] ([AppConfigKey], [AppConfigValue], [IsEditableByUser], [Description]) VALUES (N'EnableRoleRights', N'false', 1, NULL)
GO
SET IDENTITY_INSERT [dbo].[Applications] ON 
GO
INSERT [dbo].[Applications] ([ApplicationID], [ApplicationCode], [Date], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (2, N'AppCode-20190710023451', CAST(N'2019-07-10T02:34:51.650' AS DateTime), 1, CAST(N'2019-07-10T02:34:51.650' AS DateTime), 1, CAST(N'2019-07-10T12:30:32.573' AS DateTime), 1)
GO
INSERT [dbo].[Applications] ([ApplicationID], [ApplicationCode], [Date], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (3, N'AppCode-20190716113235', CAST(N'2019-07-16T23:32:35.117' AS DateTime), 1, CAST(N'2019-07-16T23:32:35.117' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[Applications] ([ApplicationID], [ApplicationCode], [Date], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (4, N'AppCode-20190716113235', CAST(N'2019-07-16T23:32:35.633' AS DateTime), 1, CAST(N'2019-07-16T23:32:35.633' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[Applications] ([ApplicationID], [ApplicationCode], [Date], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (5, N'AppCode-20190716113236', CAST(N'2019-07-16T23:32:36.150' AS DateTime), 1, CAST(N'2019-07-16T23:32:36.150' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[Applications] ([ApplicationID], [ApplicationCode], [Date], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (6, N'AppCode-20190716113236', CAST(N'2019-07-16T00:00:00.000' AS DateTime), 1, CAST(N'2019-07-16T23:32:36.000' AS DateTime), 4, CAST(N'2019-07-18T21:07:05.000' AS DateTime), 1)
GO
INSERT [dbo].[Applications] ([ApplicationID], [ApplicationCode], [Date], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (7, N'AppCode-20190718090953', CAST(N'2019-07-18T21:09:53.493' AS DateTime), 1, CAST(N'2019-07-18T21:09:53.493' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[Applications] ([ApplicationID], [ApplicationCode], [Date], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (8, N'AppCode-20190718090954', CAST(N'2019-07-18T21:09:54.277' AS DateTime), 1, CAST(N'2019-07-18T21:09:54.277' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[Applications] ([ApplicationID], [ApplicationCode], [Date], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (9, N'AppCode-20190718104321', CAST(N'2019-07-18T22:43:21.357' AS DateTime), 1, CAST(N'2019-07-18T22:43:21.357' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[Applications] ([ApplicationID], [ApplicationCode], [Date], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (10, N'AppCode-20190719111715', CAST(N'2019-07-19T23:17:15.403' AS DateTime), 1, CAST(N'2019-07-19T23:17:15.403' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[Applications] ([ApplicationID], [ApplicationCode], [Date], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (11, N'AppCode-20190719111715', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Applications] OFF
GO
SET IDENTITY_INSERT [dbo].[ApprovalHierarchies] ON 
GO
INSERT [dbo].[ApprovalHierarchies] ([ApprovalHierarchyID], [UserID], [ReportedTo], [CandidateID], [IsExempt], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (1, 4, 2, 3, 0, 1, CAST(N'2019-07-12T01:04:13.000' AS DateTime), 1, CAST(N'2019-07-12T01:04:36.000' AS DateTime), NULL)
GO
INSERT [dbo].[ApprovalHierarchies] ([ApprovalHierarchyID], [UserID], [ReportedTo], [CandidateID], [IsExempt], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (2, 2, 3, NULL, 0, 1, CAST(N'2019-07-12T01:04:38.000' AS DateTime), 1, CAST(N'2019-07-12T01:04:51.000' AS DateTime), NULL)
GO
INSERT [dbo].[ApprovalHierarchies] ([ApprovalHierarchyID], [UserID], [ReportedTo], [CandidateID], [IsExempt], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (3, 3, 1, NULL, 0, 1, CAST(N'2019-07-12T01:04:53.000' AS DateTime), 1, CAST(N'2019-07-12T01:05:05.000' AS DateTime), NULL)
GO
SET IDENTITY_INSERT [dbo].[ApprovalHierarchies] OFF
GO
SET IDENTITY_INSERT [dbo].[Approvals] ON 
GO
INSERT [dbo].[Approvals] ([ApprovalID], [EntityID], [RowID], [StatusID], [UserID], [Reason], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (1, 2, 3, 4, 3, NULL, CAST(N'2019-07-12T02:12:21.797' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[Approvals] ([ApprovalID], [EntityID], [RowID], [StatusID], [UserID], [Reason], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (2, 2, 4, 4, 1, NULL, CAST(N'2019-07-19T22:43:16.773' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[Approvals] ([ApprovalID], [EntityID], [RowID], [StatusID], [UserID], [Reason], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (3, 2, 5, 4, 1, NULL, CAST(N'2019-07-19T22:52:26.043' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[Approvals] ([ApprovalID], [EntityID], [RowID], [StatusID], [UserID], [Reason], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (4, 2, 6, 4, 3, NULL, CAST(N'2019-07-12T02:12:21.797' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[Approvals] ([ApprovalID], [EntityID], [RowID], [StatusID], [UserID], [Reason], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (5, 2, 7, 4, 1, NULL, CAST(N'2019-07-19T22:43:16.773' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[Approvals] ([ApprovalID], [EntityID], [RowID], [StatusID], [UserID], [Reason], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (6, 2, 8, 4, 1, NULL, CAST(N'2019-07-19T22:52:26.043' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[Approvals] ([ApprovalID], [EntityID], [RowID], [StatusID], [UserID], [Reason], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (7, 2, 9, 4, 3, NULL, CAST(N'2019-07-12T02:12:21.797' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[Approvals] ([ApprovalID], [EntityID], [RowID], [StatusID], [UserID], [Reason], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (8, 2, 10, 4, 1, NULL, CAST(N'2019-07-19T22:43:16.773' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[Approvals] ([ApprovalID], [EntityID], [RowID], [StatusID], [UserID], [Reason], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (9, 2, 11, 4, 1, NULL, CAST(N'2019-07-19T22:52:26.043' AS DateTime), 1, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Approvals] OFF
GO
SET IDENTITY_INSERT [dbo].[DynamicSetupScreens] ON 
GO
INSERT [dbo].[DynamicSetupScreens] ([DynamicSetupScreenID], [ScreenName], [DS_TableName], [DS_Title], [DS_AllowAddEdit], [DS_AllowPreview], [DS_AllowSearchFilter], [DS_AllowListingGrid], [DS_GridColumns], [DS_AllowDelete], [DS_AllowEdit], [DS_AllowApprovals], [DS_ExcludeAddEditColumns], [DS_ExcludeSearchColumns], [DS_ShowAddNewButton], [DS_GridTitle], [DS_OrderBy], [DS_DoNotRenderJavaScript], [DS_ExtenderName], [DS_DontLoadRecursiveData], [DS_AllowImport], [DS_ParentColumnNameForRecursiveGrid], [DS_RecordsPerPage], [DS_ImportURL], [DS_ManualCrud], [DS_Filters], [DS_DisableSorting], [DS_ShowHistory], [DS_IsMenuNavigation], [DS_SecondaryTableConfigs], [DS_CustomJavaScript], [DS_Condition], [DS_CustomQuery], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (1, N'Dynamic Screen Setup', N'DynamicSetupScreens', N'DynamicSetupScreens', 0, 0, 0, 0, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, NULL, 0, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2019-07-19T23:53:36.000' AS DateTime), 1, CAST(N'2019-07-19T23:53:36.000' AS DateTime), 1)
GO
INSERT [dbo].[DynamicSetupScreens] ([DynamicSetupScreenID], [ScreenName], [DS_TableName], [DS_Title], [DS_AllowAddEdit], [DS_AllowPreview], [DS_AllowSearchFilter], [DS_AllowListingGrid], [DS_GridColumns], [DS_AllowDelete], [DS_AllowEdit], [DS_AllowApprovals], [DS_ExcludeAddEditColumns], [DS_ExcludeSearchColumns], [DS_ShowAddNewButton], [DS_GridTitle], [DS_OrderBy], [DS_DoNotRenderJavaScript], [DS_ExtenderName], [DS_DontLoadRecursiveData], [DS_AllowImport], [DS_ParentColumnNameForRecursiveGrid], [DS_RecordsPerPage], [DS_ImportURL], [DS_ManualCrud], [DS_Filters], [DS_DisableSorting], [DS_ShowHistory], [DS_IsMenuNavigation], [DS_SecondaryTableConfigs], [DS_CustomJavaScript], [DS_Condition], [DS_CustomQuery], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (2, N'User Types', N'UserTypes', N'Manage User Types', 1, 0, 1, 1, NULL, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, NULL, 0, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[DynamicSetupScreens] ([DynamicSetupScreenID], [ScreenName], [DS_TableName], [DS_Title], [DS_AllowAddEdit], [DS_AllowPreview], [DS_AllowSearchFilter], [DS_AllowListingGrid], [DS_GridColumns], [DS_AllowDelete], [DS_AllowEdit], [DS_AllowApprovals], [DS_ExcludeAddEditColumns], [DS_ExcludeSearchColumns], [DS_ShowAddNewButton], [DS_GridTitle], [DS_OrderBy], [DS_DoNotRenderJavaScript], [DS_ExtenderName], [DS_DontLoadRecursiveData], [DS_AllowImport], [DS_ParentColumnNameForRecursiveGrid], [DS_RecordsPerPage], [DS_ImportURL], [DS_ManualCrud], [DS_Filters], [DS_DisableSorting], [DS_ShowHistory], [DS_IsMenuNavigation], [DS_SecondaryTableConfigs], [DS_CustomJavaScript], [DS_Condition], [DS_CustomQuery], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (3, N'Roles', N'Roles', N'Manage Roles', 1, 0, 1, 1, NULL, 1, 1, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, NULL, 0, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2019-07-19T00:38:18.000' AS DateTime), 1, CAST(N'2019-07-19T00:38:18.000' AS DateTime), 1)
GO
INSERT [dbo].[DynamicSetupScreens] ([DynamicSetupScreenID], [ScreenName], [DS_TableName], [DS_Title], [DS_AllowAddEdit], [DS_AllowPreview], [DS_AllowSearchFilter], [DS_AllowListingGrid], [DS_GridColumns], [DS_AllowDelete], [DS_AllowEdit], [DS_AllowApprovals], [DS_ExcludeAddEditColumns], [DS_ExcludeSearchColumns], [DS_ShowAddNewButton], [DS_GridTitle], [DS_OrderBy], [DS_DoNotRenderJavaScript], [DS_ExtenderName], [DS_DontLoadRecursiveData], [DS_AllowImport], [DS_ParentColumnNameForRecursiveGrid], [DS_RecordsPerPage], [DS_ImportURL], [DS_ManualCrud], [DS_Filters], [DS_DisableSorting], [DS_ShowHistory], [DS_IsMenuNavigation], [DS_SecondaryTableConfigs], [DS_CustomJavaScript], [DS_Condition], [DS_CustomQuery], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (4, N'Rights', N'Rights', N'Manage Rights', 1, 0, 1, 1, NULL, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, NULL, 0, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[DynamicSetupScreens] ([DynamicSetupScreenID], [ScreenName], [DS_TableName], [DS_Title], [DS_AllowAddEdit], [DS_AllowPreview], [DS_AllowSearchFilter], [DS_AllowListingGrid], [DS_GridColumns], [DS_AllowDelete], [DS_AllowEdit], [DS_AllowApprovals], [DS_ExcludeAddEditColumns], [DS_ExcludeSearchColumns], [DS_ShowAddNewButton], [DS_GridTitle], [DS_OrderBy], [DS_DoNotRenderJavaScript], [DS_ExtenderName], [DS_DontLoadRecursiveData], [DS_AllowImport], [DS_ParentColumnNameForRecursiveGrid], [DS_RecordsPerPage], [DS_ImportURL], [DS_ManualCrud], [DS_Filters], [DS_DisableSorting], [DS_ShowHistory], [DS_IsMenuNavigation], [DS_SecondaryTableConfigs], [DS_CustomJavaScript], [DS_Condition], [DS_CustomQuery], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (5, N'User Roles', N'UserRoles', N'Manage Users Roles', 1, 0, 1, 1, NULL, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, NULL, 0, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[DynamicSetupScreens] ([DynamicSetupScreenID], [ScreenName], [DS_TableName], [DS_Title], [DS_AllowAddEdit], [DS_AllowPreview], [DS_AllowSearchFilter], [DS_AllowListingGrid], [DS_GridColumns], [DS_AllowDelete], [DS_AllowEdit], [DS_AllowApprovals], [DS_ExcludeAddEditColumns], [DS_ExcludeSearchColumns], [DS_ShowAddNewButton], [DS_GridTitle], [DS_OrderBy], [DS_DoNotRenderJavaScript], [DS_ExtenderName], [DS_DontLoadRecursiveData], [DS_AllowImport], [DS_ParentColumnNameForRecursiveGrid], [DS_RecordsPerPage], [DS_ImportURL], [DS_ManualCrud], [DS_Filters], [DS_DisableSorting], [DS_ShowHistory], [DS_IsMenuNavigation], [DS_SecondaryTableConfigs], [DS_CustomJavaScript], [DS_Condition], [DS_CustomQuery], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (6, N'Users', N'Users', N'Manage Users', 1, 0, 1, 1, NULL, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, NULL, 0, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[DynamicSetupScreens] ([DynamicSetupScreenID], [ScreenName], [DS_TableName], [DS_Title], [DS_AllowAddEdit], [DS_AllowPreview], [DS_AllowSearchFilter], [DS_AllowListingGrid], [DS_GridColumns], [DS_AllowDelete], [DS_AllowEdit], [DS_AllowApprovals], [DS_ExcludeAddEditColumns], [DS_ExcludeSearchColumns], [DS_ShowAddNewButton], [DS_GridTitle], [DS_OrderBy], [DS_DoNotRenderJavaScript], [DS_ExtenderName], [DS_DontLoadRecursiveData], [DS_AllowImport], [DS_ParentColumnNameForRecursiveGrid], [DS_RecordsPerPage], [DS_ImportURL], [DS_ManualCrud], [DS_Filters], [DS_DisableSorting], [DS_ShowHistory], [DS_IsMenuNavigation], [DS_SecondaryTableConfigs], [DS_CustomJavaScript], [DS_Condition], [DS_CustomQuery], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (7, N'Field Types', N'FieldTypes', N'Manage Field Types', 1, 0, 1, 1, NULL, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, 0, N'DynamicSetupScreenExtender', 0, 0, NULL, NULL, NULL, 0, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2019-07-09T18:51:00.000' AS DateTime), 1, CAST(N'2019-07-09T18:51:36.000' AS DateTime), NULL)
GO
INSERT [dbo].[DynamicSetupScreens] ([DynamicSetupScreenID], [ScreenName], [DS_TableName], [DS_Title], [DS_AllowAddEdit], [DS_AllowPreview], [DS_AllowSearchFilter], [DS_AllowListingGrid], [DS_GridColumns], [DS_AllowDelete], [DS_AllowEdit], [DS_AllowApprovals], [DS_ExcludeAddEditColumns], [DS_ExcludeSearchColumns], [DS_ShowAddNewButton], [DS_GridTitle], [DS_OrderBy], [DS_DoNotRenderJavaScript], [DS_ExtenderName], [DS_DontLoadRecursiveData], [DS_AllowImport], [DS_ParentColumnNameForRecursiveGrid], [DS_RecordsPerPage], [DS_ImportURL], [DS_ManualCrud], [DS_Filters], [DS_DisableSorting], [DS_ShowHistory], [DS_IsMenuNavigation], [DS_SecondaryTableConfigs], [DS_CustomJavaScript], [DS_Condition], [DS_CustomQuery], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (8, N'Fields', N'Fields', N'Manage Fields', 1, 0, 1, 1, NULL, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, NULL, 0, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2019-07-09T18:51:46.000' AS DateTime), 1, CAST(N'2019-07-09T18:52:15.000' AS DateTime), NULL)
GO
INSERT [dbo].[DynamicSetupScreens] ([DynamicSetupScreenID], [ScreenName], [DS_TableName], [DS_Title], [DS_AllowAddEdit], [DS_AllowPreview], [DS_AllowSearchFilter], [DS_AllowListingGrid], [DS_GridColumns], [DS_AllowDelete], [DS_AllowEdit], [DS_AllowApprovals], [DS_ExcludeAddEditColumns], [DS_ExcludeSearchColumns], [DS_ShowAddNewButton], [DS_GridTitle], [DS_OrderBy], [DS_DoNotRenderJavaScript], [DS_ExtenderName], [DS_DontLoadRecursiveData], [DS_AllowImport], [DS_ParentColumnNameForRecursiveGrid], [DS_RecordsPerPage], [DS_ImportURL], [DS_ManualCrud], [DS_Filters], [DS_DisableSorting], [DS_ShowHistory], [DS_IsMenuNavigation], [DS_SecondaryTableConfigs], [DS_CustomJavaScript], [DS_Condition], [DS_CustomQuery], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (9, N'Approval Hierarchy', N'ApprovalHierarchies', N'Manage Approval Hierarchy', 1, 0, 1, 1, NULL, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, NULL, 0, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2019-07-12T01:01:01.000' AS DateTime), 1, CAST(N'2019-07-12T01:01:29.000' AS DateTime), NULL)
GO
INSERT [dbo].[DynamicSetupScreens] ([DynamicSetupScreenID], [ScreenName], [DS_TableName], [DS_Title], [DS_AllowAddEdit], [DS_AllowPreview], [DS_AllowSearchFilter], [DS_AllowListingGrid], [DS_GridColumns], [DS_AllowDelete], [DS_AllowEdit], [DS_AllowApprovals], [DS_ExcludeAddEditColumns], [DS_ExcludeSearchColumns], [DS_ShowAddNewButton], [DS_GridTitle], [DS_OrderBy], [DS_DoNotRenderJavaScript], [DS_ExtenderName], [DS_DontLoadRecursiveData], [DS_AllowImport], [DS_ParentColumnNameForRecursiveGrid], [DS_RecordsPerPage], [DS_ImportURL], [DS_ManualCrud], [DS_Filters], [DS_DisableSorting], [DS_ShowHistory], [DS_IsMenuNavigation], [DS_SecondaryTableConfigs], [DS_CustomJavaScript], [DS_Condition], [DS_CustomQuery], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (10, N'Approval Requests', N'ApprovalRequests', N'Manage Approval Requests', 1, 0, 0, 1, N'ApprovalID,EntityID,ApplicationCode,UserID,ReportedTo,StatusID,Reason', 0, 1, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, NULL, 0, NULL, 0, 0, 0, NULL, NULL, N'ReportedTo', NULL, CAST(N'2019-07-12T02:13:12.000' AS DateTime), 4, CAST(N'2019-07-15T02:06:47.000' AS DateTime), 2)
GO
INSERT [dbo].[DynamicSetupScreens] ([DynamicSetupScreenID], [ScreenName], [DS_TableName], [DS_Title], [DS_AllowAddEdit], [DS_AllowPreview], [DS_AllowSearchFilter], [DS_AllowListingGrid], [DS_GridColumns], [DS_AllowDelete], [DS_AllowEdit], [DS_AllowApprovals], [DS_ExcludeAddEditColumns], [DS_ExcludeSearchColumns], [DS_ShowAddNewButton], [DS_GridTitle], [DS_OrderBy], [DS_DoNotRenderJavaScript], [DS_ExtenderName], [DS_DontLoadRecursiveData], [DS_AllowImport], [DS_ParentColumnNameForRecursiveGrid], [DS_RecordsPerPage], [DS_ImportURL], [DS_ManualCrud], [DS_Filters], [DS_DisableSorting], [DS_ShowHistory], [DS_IsMenuNavigation], [DS_SecondaryTableConfigs], [DS_CustomJavaScript], [DS_Condition], [DS_CustomQuery], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (11, N'Entity Details', N'EntityDetails', N'Manage Entity Details', 1, 0, 1, 1, NULL, 1, 1, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, NULL, 0, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2019-07-14T20:01:53.000' AS DateTime), 1, CAST(N'2019-07-14T20:02:16.000' AS DateTime), NULL)
GO
INSERT [dbo].[DynamicSetupScreens] ([DynamicSetupScreenID], [ScreenName], [DS_TableName], [DS_Title], [DS_AllowAddEdit], [DS_AllowPreview], [DS_AllowSearchFilter], [DS_AllowListingGrid], [DS_GridColumns], [DS_AllowDelete], [DS_AllowEdit], [DS_AllowApprovals], [DS_ExcludeAddEditColumns], [DS_ExcludeSearchColumns], [DS_ShowAddNewButton], [DS_GridTitle], [DS_OrderBy], [DS_DoNotRenderJavaScript], [DS_ExtenderName], [DS_DontLoadRecursiveData], [DS_AllowImport], [DS_ParentColumnNameForRecursiveGrid], [DS_RecordsPerPage], [DS_ImportURL], [DS_ManualCrud], [DS_Filters], [DS_DisableSorting], [DS_ShowHistory], [DS_IsMenuNavigation], [DS_SecondaryTableConfigs], [DS_CustomJavaScript], [DS_Condition], [DS_CustomQuery], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (12, N'Ration Per Person', N'RationAmounts', N'Manage Per Person Ration Amount', 1, 0, 1, 1, NULL, 1, 1, 0, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, NULL, 0, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, CAST(N'2019-07-19T22:56:09.000' AS DateTime), 1, CAST(N'2019-07-19T22:56:36.000' AS DateTime), NULL)
GO
SET IDENTITY_INSERT [dbo].[DynamicSetupScreens] OFF
GO
INSERT [dbo].[Entities] ([EntityID], [NameEn], [DataVersion], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (1, N'AppConfigs', 1, 1, CAST(N'2019-07-12T00:00:00.000' AS DateTime), 1, CAST(N'2019-07-12T00:56:34.000' AS DateTime), 1)
GO
INSERT [dbo].[Entities] ([EntityID], [NameEn], [DataVersion], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (2, N'Applications', 1, 1, CAST(N'2019-07-12T00:00:00.000' AS DateTime), 1, CAST(N'2019-07-12T00:56:53.000' AS DateTime), 1)
GO
INSERT [dbo].[Entities] ([EntityID], [NameEn], [DataVersion], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (3, N'ApprovalHierarchies', 1, 1, CAST(N'2019-07-12T00:00:00.000' AS DateTime), 1, CAST(N'2019-07-12T00:57:07.000' AS DateTime), 1)
GO
INSERT [dbo].[Entities] ([EntityID], [NameEn], [DataVersion], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (4, N'Approvals', 1, 1, CAST(N'2019-07-12T02:21:34.000' AS DateTime), 4, CAST(N'2019-07-12T02:21:42.000' AS DateTime), NULL)
GO
INSERT [dbo].[Entities] ([EntityID], [NameEn], [DataVersion], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (5, N'DynamicSetupScreens', 1, 1, CAST(N'2019-07-12T00:00:00.000' AS DateTime), 1, CAST(N'2019-07-12T00:57:24.000' AS DateTime), 1)
GO
INSERT [dbo].[Entities] ([EntityID], [NameEn], [DataVersion], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (6, N'Entities', 1, 1, CAST(N'2019-07-12T00:00:00.000' AS DateTime), 1, CAST(N'2019-07-12T00:57:35.000' AS DateTime), 1)
GO
INSERT [dbo].[Entities] ([EntityID], [NameEn], [DataVersion], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (7, N'EntityDetails', 1, 1, CAST(N'2019-07-12T00:57:38.000' AS DateTime), 1, CAST(N'2019-07-12T00:57:47.000' AS DateTime), NULL)
GO
INSERT [dbo].[Entities] ([EntityID], [NameEn], [DataVersion], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (8, N'Fields', 1, 1, CAST(N'2019-07-12T00:57:51.000' AS DateTime), 1, CAST(N'2019-07-12T00:57:56.000' AS DateTime), NULL)
GO
INSERT [dbo].[Entities] ([EntityID], [NameEn], [DataVersion], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (9, N'FieldTypes', 1, 1, CAST(N'2019-07-12T00:57:57.000' AS DateTime), 1, CAST(N'2019-07-12T00:58:02.000' AS DateTime), NULL)
GO
INSERT [dbo].[Entities] ([EntityID], [NameEn], [DataVersion], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (10, N'FieldValues', 1, 1, CAST(N'2019-07-12T00:58:07.000' AS DateTime), 1, CAST(N'2019-07-12T00:58:12.000' AS DateTime), NULL)
GO
INSERT [dbo].[Entities] ([EntityID], [NameEn], [DataVersion], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (11, N'Rights', 1, 1, CAST(N'2019-07-12T00:58:12.000' AS DateTime), 1, CAST(N'2019-07-12T00:58:18.000' AS DateTime), NULL)
GO
INSERT [dbo].[Entities] ([EntityID], [NameEn], [DataVersion], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (12, N'RoleRights', 1, 1, CAST(N'2019-07-12T00:58:25.000' AS DateTime), 1, CAST(N'2019-07-12T00:58:34.000' AS DateTime), NULL)
GO
INSERT [dbo].[Entities] ([EntityID], [NameEn], [DataVersion], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (13, N'Roles', 1, 1, CAST(N'2019-07-12T00:58:35.000' AS DateTime), 1, CAST(N'2019-07-12T00:58:45.000' AS DateTime), NULL)
GO
INSERT [dbo].[Entities] ([EntityID], [NameEn], [DataVersion], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (14, N'Statuses', 1, 1, CAST(N'2019-07-12T00:58:46.000' AS DateTime), 1, CAST(N'2019-07-12T00:59:00.000' AS DateTime), NULL)
GO
INSERT [dbo].[Entities] ([EntityID], [NameEn], [DataVersion], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (16, N'UserRoles', 1, 1, CAST(N'2019-07-12T00:59:19.000' AS DateTime), 1, CAST(N'2019-07-12T00:59:24.000' AS DateTime), NULL)
GO
INSERT [dbo].[Entities] ([EntityID], [NameEn], [DataVersion], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (17, N'Users', 1, 1, CAST(N'2019-07-12T00:59:27.000' AS DateTime), 1, CAST(N'2019-07-12T00:59:32.000' AS DateTime), NULL)
GO
INSERT [dbo].[Entities] ([EntityID], [NameEn], [DataVersion], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (18, N'ApprovalRequests', 1, 1, CAST(N'2019-07-15T01:18:10.000' AS DateTime), 1, CAST(N'2019-07-15T01:18:17.000' AS DateTime), NULL)
GO
INSERT [dbo].[Entities] ([EntityID], [NameEn], [DataVersion], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (19, N'RationAmounts', 1, 1, CAST(N'2019-07-19T22:58:00.000' AS DateTime), 1, CAST(N'2019-07-19T22:58:13.000' AS DateTime), NULL)
GO
SET IDENTITY_INSERT [dbo].[EntityDetails] ON 
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (1, 1, N'AppConfigKey', N'AppConfigKey', N'AppConfigKey', 167, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 64, 0, 1, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (2, 1, N'AppConfigValue', N'AppConfigValue', N'AppConfigValue', 167, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 512, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (3, 1, N'IsEditableByUser', N'IsEditableByUser', N'IsEditableByUser', 104, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (4, 1, N'Description', N'Description', N'Description', 167, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 1024, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (5, 2, N'ApplicationID', N'ApplicationID', N'ApplicationID', 56, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 1, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (6, 2, N'ApplicationCode', N'ApplicationCode', N'ApplicationCode', 231, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 60, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (7, 2, N'Date', N'Date', N'Date', 61, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 8, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (8, 2, N'IsActive', N'IsActive', N'IsActive', 104, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (9, 2, N'CreatedOn', N'CreatedOn', N'CreatedOn', 61, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 8, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (10, 2, N'CreatedBy', N'CreatedBy', N'CreatedBy', 56, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (11, 2, N'ModifiedOn', N'ModifiedOn', N'ModifiedOn', 61, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 8, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (12, 2, N'ModifiedBy', N'ModifiedBy', N'ModifiedBy', 56, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (13, 3, N'ApprovalHierarchyID', N'ApprovalHierarchyID', N'ApprovalHierarchyID', 56, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 1, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (14, 3, N'UserID', N'UserID', N'UserID', 56, 1, 0, NULL, NULL, 1, N'Users', 0, NULL, NULL, NULL, 0, 0, 0, 4, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (15, 3, N'ReportedTo', N'ReportedTo', N'ReportedTo', 56, 0, 0, NULL, NULL, 1, N'Users', 0, NULL, NULL, NULL, 0, 0, 0, 4, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (16, 3, N'CandidateID', N'CandidateID', N'CandidateID', 56, 0, 0, NULL, NULL, 1, N'Users', 0, NULL, NULL, NULL, 0, 0, 0, 4, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (17, 3, N'IsExempt', N'IsExempt', N'IsExempt', 104, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (18, 3, N'IsActive', N'IsActive', N'IsActive', 104, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (19, 3, N'CreatedOn', N'CreatedOn', N'CreatedOn', 61, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 8, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (20, 3, N'CreatedBy', N'CreatedBy', N'CreatedBy', 56, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (21, 3, N'ModifiedOn', N'ModifiedOn', N'ModifiedOn', 61, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 8, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (22, 3, N'ModifiedBy', N'ModifiedBy', N'ModifiedBy', 56, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (33, 5, N'DynamicSetupScreenID', N'DynamicSetupScreenID', N'DynamicSetupScreenID', 56, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 1, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (34, 5, N'ScreenName', N'ScreenName', N'ScreenName', 231, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 300, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (35, 5, N'DS_TableName', N'DS_TableName', N'DS_TableName', 231, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 100, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (36, 5, N'DS_Title', N'DS_Title', N'DS_Title', 231, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 500, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (37, 5, N'DS_AllowAddEdit', N'DS_AllowAddEdit', N'DS_AllowAddEdit', 104, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (38, 5, N'DS_AllowPreview', N'DS_AllowPreview', N'DS_AllowPreview', 104, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (39, 5, N'DS_AllowSearchFilter', N'DS_AllowSearchFilter', N'DS_AllowSearchFilter', 104, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (40, 5, N'DS_AllowListingGrid', N'DS_AllowListingGrid', N'DS_AllowListingGrid', 104, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (41, 5, N'DS_GridColumns', N'DS_GridColumns', N'DS_GridColumns', 231, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 2048, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (42, 5, N'DS_AllowDelete', N'DS_AllowDelete', N'DS_AllowDelete', 104, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (43, 5, N'DS_AllowEdit', N'DS_AllowEdit', N'DS_AllowEdit', 104, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (44, 5, N'DS_ExcludeAddEditColumns', N'DS_ExcludeAddEditColumns', N'DS_ExcludeAddEditColumns', 231, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 2048, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (45, 5, N'DS_ExcludeSearchColumns', N'DS_ExcludeSearchColumns', N'DS_ExcludeSearchColumns', 231, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 2048, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (46, 5, N'DS_ShowAddNewButton', N'DS_ShowAddNewButton', N'DS_ShowAddNewButton', 239, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 20, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (47, 5, N'DS_GridTitle', N'DS_GridTitle', N'DS_GridTitle', 231, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 200, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (48, 5, N'DS_OrderBy', N'DS_OrderBy', N'DS_OrderBy', 231, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 200, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (49, 5, N'DS_DoNotRenderJavaScript', N'DS_DoNotRenderJavaScript', N'DS_DoNotRenderJavaScript', 104, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (50, 5, N'DS_ExtenderName', N'DS_ExtenderName', N'DS_ExtenderName', 231, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 500, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (51, 5, N'DS_DontLoadRecursiveData', N'DS_DontLoadRecursiveData', N'DS_DontLoadRecursiveData', 104, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (52, 5, N'DS_AllowImport', N'DS_AllowImport', N'DS_AllowImport', 104, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (53, 5, N'DS_ParentColumnNameForRecursiveGrid', N'DS_ParentColumnNameForRecursiveGrid', N'DS_ParentColumnNameForRecursiveGrid', 231, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 1000, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (54, 5, N'DS_RecordsPerPage', N'DS_RecordsPerPage', N'DS_RecordsPerPage', 56, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (55, 5, N'DS_ImportURL', N'DS_ImportURL', N'DS_ImportURL', 231, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 1000, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (56, 5, N'DS_ManualCrud', N'DS_ManualCrud', N'DS_ManualCrud', 104, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (57, 5, N'DS_Filters', N'DS_Filters', N'DS_Filters', 231, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 2048, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (58, 5, N'DS_DisableSorting', N'DS_DisableSorting', N'DS_DisableSorting', 104, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (59, 5, N'DS_ShowHistory', N'DS_ShowHistory', N'DS_ShowHistory', 104, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (60, 5, N'DS_IsMenuNavigation', N'DS_IsMenuNavigation', N'DS_IsMenuNavigation', 104, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (61, 5, N'DS_SecondaryTableConfigs', N'DS_SecondaryTableConfigs', N'DS_SecondaryTableConfigs', 231, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, -1, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (62, 5, N'DS_CustomJavaScript', N'DS_CustomJavaScript', N'DS_CustomJavaScript', 231, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, -1, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (63, 5, N'CreatedOn', N'CreatedOn', N'CreatedOn', 61, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 8, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (64, 5, N'CreatedBy', N'CreatedBy', N'CreatedBy', 56, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (65, 5, N'ModifiedOn', N'ModifiedOn', N'ModifiedOn', 61, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 8, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (66, 5, N'ModifiedBy', N'ModifiedBy', N'ModifiedBy', 56, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (67, 6, N'EntityID', N'EntityID', N'EntityID', 52, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 2, 0, 1, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (68, 6, N'NameEn', N'NameEn', N'NameEn', 167, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 64, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (69, 6, N'DataVersion', N'DataVersion', N'DataVersion', 56, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (70, 6, N'IsActive', N'IsActive', N'IsActive', 104, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (71, 6, N'CreatedOn', N'CreatedOn', N'CreatedOn', 61, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 8, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (72, 6, N'CreatedBy', N'CreatedBy', N'CreatedBy', 56, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (73, 6, N'ModifiedOn', N'ModifiedOn', N'ModifiedOn', 61, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 8, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (74, 6, N'ModifiedBy', N'ModifiedBy', N'ModifiedBy', 56, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (75, 7, N'EntityDetailsID', N'EntityDetailsID', N'EntityDetailsID', 56, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 1, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (76, 7, N'EntityID', N'EntityID', N'EntityID', 52, 1, 0, NULL, NULL, 1, N'Entities', 0, NULL, NULL, NULL, 0, 0, 0, 2, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (77, 7, N'ColumnName', N'ColumnName', N'ColumnName', 231, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 512, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (78, 7, N'DisplayNameEn', N'DisplayNameEn', N'DisplayNameEn', 231, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 512, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (79, 7, N'DisplayNameAr', N'DisplayNameAr', N'DisplayNameAr', 231, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 512, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (80, 7, N'DbTypeID', N'DbTypeID', N'DbTypeID', 52, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 2, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (81, 7, N'IsRequired', N'IsRequired', N'IsRequired', 104, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (82, 7, N'IsGroup', N'IsGroup', N'IsGroup', 104, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (83, 7, N'ParentSubGroupID', N'ParentSubGroupID', N'ParentSubGroupID', 56, 0, 0, NULL, NULL, 1, N'EntityDetails', 0, NULL, NULL, NULL, 0, 0, 0, 4, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (84, 7, N'ParentEntityDetailsID', N'ParentEntityDetailsID', N'ParentEntityDetailsID', 56, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (85, 7, N'IsForeignkey', N'IsForeignkey', N'IsForeignkey', 104, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (86, 7, N'RefrencedTableName', N'RefrencedTableName', N'RefrencedTableName', 167, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 256, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (87, 7, N'EnableAutoComplate', N'EnableAutoComplate', N'EnableAutoComplate', 104, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (88, 7, N'AutoCompleteSourceQuery', N'AutoCompleteSourceQuery', N'AutoCompleteSourceQuery', 231, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, -1, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (89, 7, N'IsDigit', N'IsDigit', N'IsDigit', 104, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (90, 7, N'ValidationExpression', N'ValidationExpression', N'ValidationExpression', 231, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 512, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (91, 7, N'AddEditVisible', N'AddEditVisible', N'AddEditVisible', 104, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (92, 7, N'GridVisible', N'GridVisible', N'GridVisible', 104, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (93, 7, N'SearchFilterVisible', N'SearchFilterVisible', N'SearchFilterVisible', 104, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (94, 7, N'MaxLength', N'MaxLength', N'MaxLength', 52, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 2, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (95, 7, N'IsAutoID', N'IsAutoID', N'IsAutoID', 104, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (96, 7, N'IsPrimaryKey', N'IsPrimaryKey', N'IsPrimaryKey', 104, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (97, 7, N'DisplaySeqNo', N'DisplaySeqNo', N'DisplaySeqNo', 56, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (98, 7, N'IsFileUpload', N'IsFileUpload', N'IsFileUpload', 104, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (99, 7, N'AllowedFiles', N'AllowedFiles', N'AllowedFiles', 231, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 512, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (100, 7, N'ShowGroupTitle', N'ShowGroupTitle', N'ShowGroupTitle', 104, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (101, 7, N'PlaceHolderText', N'PlaceHolderText', N'PlaceHolderText', 231, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 400, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (102, 7, N'CreatedOn', N'CreatedOn', N'CreatedOn', 61, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 8, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (103, 7, N'CreatedBy', N'CreatedBy', N'CreatedBy', 56, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (104, 7, N'ModifiedOn', N'ModifiedOn', N'ModifiedOn', 61, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 8, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (105, 7, N'ModifiedBy', N'ModifiedBy', N'ModifiedBy', 56, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (106, 8, N'FieldID', N'FieldID', N'FieldID', 56, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 1, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (107, 8, N'ParentFieldID', N'ParentFieldID', N'ParentFieldID', 56, 0, 0, NULL, NULL, 1, N'Fields', 0, NULL, NULL, NULL, 0, 0, 0, 4, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (108, 8, N'FieldName', N'FieldName', N'FieldName', 231, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 300, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (109, 8, N'FieldTypeID', N'FieldTypeID', N'FieldTypeID', 52, 1, 0, NULL, NULL, 1, N'FieldTypes', 0, NULL, NULL, NULL, 0, 0, 0, 2, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (110, 8, N'DisplayName', N'DisplayName', N'DisplayName', 231, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 300, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (111, 8, N'IsRequired', N'IsRequired', N'IsRequired', 104, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (112, 8, N'IsActive', N'IsActive', N'IsActive', 104, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (113, 8, N'DisplaySeqNo', N'DisplaySeqNo', N'DisplaySeqNo', 56, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (114, 8, N'Source', N'Source', N'Source', 231, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 100, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (115, 8, N'CreatedOn', N'CreatedOn', N'CreatedOn', 61, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 8, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (116, 8, N'CreatedBy', N'CreatedBy', N'CreatedBy', 56, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (117, 8, N'ModifiedOn', N'ModifiedOn', N'ModifiedOn', 61, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 8, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (118, 8, N'ModifiedBy', N'ModifiedBy', N'ModifiedBy', 56, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (119, 9, N'FieldTypeID', N'FieldTypeID', N'FieldTypeID', 52, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 2, 0, 1, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (120, 9, N'FieldTypeName', N'FieldTypeName', N'FieldTypeName', 231, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 100, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (121, 9, N'IsActive', N'IsActive', N'IsActive', 104, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (122, 9, N'CreatedOn', N'CreatedOn', N'CreatedOn', 61, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 8, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (123, 9, N'CreatedBy', N'CreatedBy', N'CreatedBy', 56, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (124, 9, N'ModifiedOn', N'ModifiedOn', N'ModifiedOn', 61, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 8, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (125, 9, N'ModifiedBy', N'ModifiedBy', N'ModifiedBy', 56, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (126, 10, N'FieldValueID', N'FieldValueID', N'FieldValueID', 56, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 1, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (127, 10, N'ApplicationID', N'ApplicationID', N'ApplicationID', 56, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (128, 10, N'FieldID', N'FieldID', N'FieldID', 56, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (129, 10, N'Data', N'Data', N'Data', 231, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, -1, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (130, 10, N'CreatedOn', N'CreatedOn', N'CreatedOn', 61, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 8, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (131, 10, N'CreatedBy', N'CreatedBy', N'CreatedBy', 56, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (132, 10, N'ModifiedOn', N'ModifiedOn', N'ModifiedOn', 61, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 8, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (133, 10, N'ModifiedBy', N'ModifiedBy', N'ModifiedBy', 56, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (134, 11, N'RightID', N'RightID', N'RightID', 52, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 2, 0, 1, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (135, 11, N'RightName', N'RightName', N'RightName', 231, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 100, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (136, 11, N'IsActive', N'IsActive', N'IsActive', 104, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (137, 11, N'CreatedOn', N'CreatedOn', N'CreatedOn', 61, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 8, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (138, 11, N'CreatedBy', N'CreatedBy', N'CreatedBy', 56, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (139, 11, N'ModifiedOn', N'ModifiedOn', N'ModifiedOn', 61, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 8, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (140, 11, N'ModifiedBy', N'ModifiedBy', N'ModifiedBy', 56, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (141, 12, N'RoleRightID', N'RoleRightID', N'RoleRightID', 56, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 1, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (142, 12, N'RoleID', N'RoleID', N'RoleID', 52, 1, 0, NULL, NULL, 1, N'Roles', 0, NULL, NULL, NULL, 0, 0, 0, 2, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (143, 12, N'RightID', N'RightID', N'RightID', 52, 1, 0, NULL, NULL, 1, N'Rights', 0, NULL, NULL, NULL, 0, 0, 0, 2, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (144, 12, N'EntityID', N'EntityID', N'EntityID', 52, 1, 0, NULL, NULL, 1, N'Entities', 0, NULL, NULL, NULL, 0, 0, 0, 2, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (145, 12, N'CreatedOn', N'CreatedOn', N'CreatedOn', 61, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 8, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (146, 12, N'CreatedBy', N'CreatedBy', N'CreatedBy', 56, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (147, 12, N'ModifiedOn', N'ModifiedOn', N'ModifiedOn', 61, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 8, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (148, 12, N'ModifiedBy', N'ModifiedBy', N'ModifiedBy', 56, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (149, 13, N'RoleID', N'RoleID', N'RoleID', 52, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 2, 0, 1, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (150, 13, N'RoleName', N'RoleName', N'RoleName', 231, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 100, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (151, 13, N'IsActive', N'IsActive', N'IsActive', 104, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (152, 13, N'CreatedOn', N'CreatedOn', N'CreatedOn', 61, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 8, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (153, 13, N'CreatedBy', N'CreatedBy', N'CreatedBy', 56, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (154, 13, N'ModifiedOn', N'ModifiedOn', N'ModifiedOn', 61, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 8, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (155, 13, N'ModifiedBy', N'ModifiedBy', N'ModifiedBy', 56, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (156, 14, N'StatusID', N'StatusID', N'StatusID', 52, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 2, 0, 1, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (157, 14, N'StatusName', N'StatusName', N'StatusName', 231, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 100, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (158, 14, N'IsActive', N'IsActive', N'IsActive', 104, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (159, 14, N'CreatedOn', N'CreatedOn', N'CreatedOn', 61, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 8, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (160, 14, N'CreatedBy', N'CreatedBy', N'CreatedBy', 56, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (161, 14, N'ModifiedOn', N'ModifiedOn', N'ModifiedOn', 61, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 8, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (162, 14, N'ModifiedBy', N'ModifiedBy', N'ModifiedBy', 56, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (170, 16, N'UserRoleID', N'UserRoleID', N'UserRoleID', 56, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 1, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (171, 16, N'UserID', N'UserID', N'UserID', 56, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (172, 16, N'RoleID', N'RoleID', N'RoleID', 52, 1, 0, NULL, NULL, 1, N'Roles', 0, NULL, NULL, NULL, 0, 0, 0, 2, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (173, 16, N'CreatedOn', N'CreatedOn', N'CreatedOn', 61, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 8, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (174, 16, N'CreatedBy', N'CreatedBy', N'CreatedBy', 56, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (175, 16, N'ModifiedOn', N'ModifiedOn', N'ModifiedOn', 61, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 8, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (176, 16, N'ModifiedBy', N'ModifiedBy', N'ModifiedBy', 56, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (177, 17, N'UserID', N'UserID', N'UserID', 56, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 1, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (178, 17, N'FullName', N'FullName', N'FullName', 231, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 512, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (179, 17, N'DisplayName', N'DisplayName', N'DisplayName', 231, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 64, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (180, 17, N'Email', N'Email', N'Email', 231, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 512, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (181, 17, N'Password', N'Password', N'Password', 231, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 512, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (182, 17, N'PictureID', N'PictureID', N'PictureID', 56, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (183, 17, N'PictureURL', N'PictureURL', N'PictureURL', 231, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 2048, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (184, 17, N'MobileNo', N'MobileNo', N'MobileNo', 231, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 64, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (185, 17, N'StatusID', N'StatusID', N'StatusID', 52, 0, 0, NULL, NULL, 1, N'Statuses', 0, NULL, NULL, NULL, 0, 0, 0, 2, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (186, 17, N'CreatedOn', N'CreatedOn', N'CreatedOn', 61, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 8, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (187, 17, N'ModifiedOn', N'ModifiedOn', N'ModifiedOn', 61, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 8, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (188, 17, N'CreatedBy', N'CreatedBy', N'CreatedBy', 56, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (189, 17, N'ModifiedBy', N'ModifiedBy', N'ModifiedBy', 56, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (190, 4, N'ApprovalID', N'ApprovalID', N'ApprovalID', 56, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 1, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (191, 4, N'EntityID', N'Entity', N'EntityID', 52, 1, 0, NULL, NULL, 1, N'Entities', 0, NULL, 0, NULL, 0, 0, 0, 2, 0, 0, 0, 0, NULL, 0, NULL, CAST(N'2019-07-14T20:03:54.000' AS DateTime), 1, CAST(N'2019-07-14T20:03:54.000' AS DateTime), 1)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (192, 4, N'RowID', N'ID', N'RowID', 56, 1, 0, NULL, NULL, 0, NULL, 0, NULL, 0, NULL, 0, 0, 0, 4, 0, 0, 0, 0, NULL, 0, NULL, CAST(N'2019-07-14T20:04:20.000' AS DateTime), 1, CAST(N'2019-07-14T20:04:20.000' AS DateTime), 1)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (193, 4, N'StatusID', N'Status', N'StatusID', 52, 1, 0, NULL, NULL, 1, N'Statuses', 0, NULL, 0, NULL, 0, 0, 0, 2, 0, 0, 0, 0, NULL, 0, NULL, CAST(N'2019-07-14T20:03:32.000' AS DateTime), 1, CAST(N'2019-07-14T20:03:32.000' AS DateTime), 1)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (194, 4, N'UserID', N'Requested By', N'UserID', 56, 1, 0, NULL, NULL, 1, N'Users', 0, NULL, 0, NULL, 0, 0, 0, 4, 0, 0, 0, 0, NULL, 0, NULL, CAST(N'2019-07-14T20:03:16.000' AS DateTime), 1, CAST(N'2019-07-14T20:03:16.000' AS DateTime), 1)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (195, 4, N'Reason', N'Reason', N'Reason', 231, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 2000, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (196, 4, N'CreatedOn', N'CreatedOn', N'CreatedOn', 61, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 8, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (197, 4, N'CreatedBy', N'CreatedBy', N'CreatedBy', 56, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (198, 4, N'ModifiedOn', N'ModifiedOn', N'ModifiedOn', 61, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 8, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (199, 4, N'ModifiedBy', N'ModifiedBy', N'ModifiedBy', 56, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (212, 18, N'ApprovalID', N'ApprovalID', N'ApprovalID', 56, 1, 0, NULL, NULL, 0, NULL, 0, NULL, 0, NULL, 0, 0, 0, 4, 0, 1, 0, 0, NULL, 0, NULL, CAST(N'2019-07-15T01:19:24.000' AS DateTime), 1, CAST(N'2019-07-15T01:22:05.000' AS DateTime), 1)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (213, 18, N'ReportedTo', N'ReportedTo', N'ReportedTo', 56, 0, 0, NULL, NULL, 1, N'Users', 0, NULL, 0, NULL, 0, 0, 0, 4, 0, 0, 0, 0, NULL, 0, NULL, CAST(N'2019-07-15T01:19:37.000' AS DateTime), 1, CAST(N'2019-07-15T01:23:54.000' AS DateTime), 1)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (214, 18, N'CandidateID', N'CandidateID', N'CandidateID', 56, 0, 0, NULL, NULL, 1, N'Users', 0, NULL, 0, NULL, 0, 0, 0, 4, 0, 0, 0, 0, NULL, 0, NULL, CAST(N'2019-07-15T01:19:55.000' AS DateTime), 1, CAST(N'2019-07-15T01:24:07.000' AS DateTime), 1)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (215, 18, N'UserID', N'UserID', N'UserID', 56, 1, 0, NULL, NULL, 1, N'Users', 0, NULL, 0, NULL, 0, 0, 0, 4, 0, 0, 0, 0, NULL, 0, NULL, CAST(N'2019-07-15T01:24:30.000' AS DateTime), 1, CAST(N'2019-07-15T01:24:30.000' AS DateTime), 1)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (216, 18, N'EntityID', N'EntityID', N'EntityID', 52, 1, 0, NULL, NULL, 1, N'Entities', 0, NULL, 0, NULL, 0, 0, 0, 2, 0, 0, 0, 0, NULL, 0, NULL, CAST(N'2019-07-15T01:26:20.000' AS DateTime), 1, CAST(N'2019-07-15T01:26:20.000' AS DateTime), 1)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (217, 18, N'ApplicationCode', N'Application Code', N'ApplicationCode', 56, 1, 0, NULL, NULL, 0, NULL, 0, NULL, 0, NULL, 0, 0, 0, 4, 0, 0, 0, 0, NULL, 0, NULL, CAST(N'2019-07-15T01:24:44.000' AS DateTime), 1, CAST(N'2019-07-15T01:54:35.000' AS DateTime), 1)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (218, 18, N'StatusID', N'StatusID', N'StatusID', 52, 1, 0, NULL, NULL, 1, N'Statuses', 0, NULL, 0, NULL, 0, 0, 0, 2, 0, 0, 0, 0, NULL, 0, NULL, CAST(N'2019-07-15T01:31:06.000' AS DateTime), 1, CAST(N'2019-07-15T01:31:06.000' AS DateTime), 1)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (219, 18, N'Reason', N'Reason', N'Reason', 231, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 2000, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (220, 18, N'CreatedOn', N'CreatedOn', N'CreatedOn', 61, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 8, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (221, 18, N'CreatedBy', N'CreatedBy', N'CreatedBy', 56, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (222, 18, N'ModifiedOn', N'ModifiedOn', N'ModifiedOn', 61, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 8, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (223, 18, N'ModifiedBy', N'ModifiedBy', N'ModifiedBy', 56, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (224, 5, N'DS_Condition', N'DS_Condition', N'DS_Condition', 231, 0, 0, NULL, NULL, 0, NULL, 0, NULL, 0, NULL, 0, 0, 0, 100, 0, 0, 0, 0, NULL, 0, NULL, CAST(N'2019-07-19T00:36:27.000' AS DateTime), 1, CAST(N'2019-07-19T00:36:27.000' AS DateTime), 1)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (225, 19, N'RationAmountID', N'RationAmountID', N'RationAmountID', 52, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 2, 1, 1, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (226, 19, N'NoOfPerson', N'NoOfPerson', N'NoOfPerson', 56, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (227, 19, N'Amount', N'Amount', N'Amount', 56, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (228, 19, N'IsActive', N'IsActive', N'IsActive', 104, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (229, 19, N'CreatedOn', N'CreatedOn', N'CreatedOn', 61, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 8, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (230, 19, N'CreatedBy', N'CreatedBy', N'CreatedBy', 56, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (231, 19, N'ModifiedOn', N'ModifiedOn', N'ModifiedOn', 61, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 8, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (232, 19, N'ModifiedBy', N'ModifiedBy', N'ModifiedBy', 56, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (233, 5, N'DS_CustomQuery', N'DS_CustomQuery', N'DS_CustomQuery', 231, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, -1, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[EntityDetails] OFF
GO
SET IDENTITY_INSERT [dbo].[Fields] ON 
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (27, NULL, N'ApplicantDetails', 4, N'Applicant Details', 1, 1, 1, NULL, CAST(N'2019-07-19T01:00:52.000' AS DateTime), 1, CAST(N'2019-07-19T01:01:43.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (28, 27, N'ApplicantName', 1, N'Applicant Name', 1, 1, 2, NULL, CAST(N'2019-07-19T01:03:15.000' AS DateTime), 1, CAST(N'2019-07-19T01:03:43.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (29, 27, N'S/O, D/O,  W/O', 1, N'S/O, D/O,  W/O', 1, 1, 3, NULL, CAST(N'2019-07-19T01:04:27.000' AS DateTime), 1, CAST(N'2019-07-19T01:05:15.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (30, 27, N'CNIC NO:', 5, N'CNIC NO:', 1, 1, 4, NULL, CAST(N'2019-07-19T01:05:27.000' AS DateTime), 1, CAST(N'2019-07-19T01:05:52.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (31, 27, N'Address', 1, N'Address', 1, 1, 5, NULL, CAST(N'2019-07-19T01:05:54.000' AS DateTime), 1, CAST(N'2019-07-19T01:06:16.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (32, 27, N'ContactNumber:', 5, N'Contact Number', 1, 1, 6, NULL, CAST(N'2019-07-19T01:06:19.000' AS DateTime), 1, CAST(N'2019-07-19T01:06:55.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (33, NULL, N'Income / Expenditure', 4, N'Income / Expenditure', 1, 1, 7, NULL, CAST(N'2019-07-19T01:07:08.000' AS DateTime), 1, CAST(N'2019-07-19T01:07:40.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (34, NULL, N'Income:', 4, N'Income:', 1, 1, 8, NULL, CAST(N'2019-07-19T01:07:59.000' AS DateTime), 1, CAST(N'2019-07-19T01:22:54.000' AS DateTime), 1)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (35, 34, N'TotalIncome:', 5, N'Total Income', 1, 1, 9, NULL, CAST(N'2019-07-19T01:12:14.000' AS DateTime), 1, CAST(N'2019-07-19T01:12:46.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (36, NULL, N'Expenses:', 4, N'Expenses:', 1, 1, 10, NULL, CAST(N'2019-07-19T01:12:52.000' AS DateTime), 1, CAST(N'2019-07-19T01:13:11.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (37, 36, N'TotalMonthlyRashan', 5, N'Total Monthly Rashan', 1, 1, 11, NULL, CAST(N'2019-07-19T01:13:27.000' AS DateTime), 1, CAST(N'2019-07-19T01:14:21.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (38, 36, N'EducationalExpenses', 5, N'Educational Expenses', 1, 1, 12, NULL, CAST(N'2019-07-19T01:14:24.000' AS DateTime), 1, CAST(N'2019-07-19T01:14:50.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (39, 36, N'MedicalExpenses', 5, N'Medical Expenses', 1, 1, 13, NULL, CAST(N'2019-07-19T01:14:52.000' AS DateTime), 1, CAST(N'2019-07-19T01:15:20.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (40, 36, N'Conveyance Expense', 5, N'ConveyanceExpense', 1, 1, 15, NULL, CAST(N'2019-07-19T01:15:21.000' AS DateTime), 1, CAST(N'2019-07-19T01:16:19.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (41, 36, N'OthersExpenses:', 5, N'Others Expenses', 1, 1, 15, NULL, CAST(N'2019-07-19T01:16:32.000' AS DateTime), 1, CAST(N'2019-07-19T01:17:01.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (42, 36, N'TotalExpenses:', 5, N'Total Expenses', 1, 1, 16, NULL, CAST(N'2019-07-19T01:18:13.000' AS DateTime), 1, CAST(N'2019-07-19T01:19:42.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (43, 36, N'NetBalance:', 5, N'Net Balance', 1, 1, 17, N'TotalIncome-TotalExpenses', CAST(N'2019-07-19T01:19:53.000' AS DateTime), 1, CAST(N'2019-07-19T23:01:14.000' AS DateTime), 1)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (44, NULL, N'Assets:', 4, N'Assets:', 1, 1, 17, NULL, CAST(N'2019-07-19T01:21:19.000' AS DateTime), 1, CAST(N'2019-07-19T01:23:02.000' AS DateTime), 1)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (45, 44, N'Cash(In hand or Bank)', 5, N'Cash (In hand or Bank)', 1, 1, 18, NULL, CAST(N'2019-07-19T01:23:12.000' AS DateTime), 1, CAST(N'2019-07-19T01:23:55.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (46, 44, N'Gold', 1, N'Gold', 1, 1, 20, NULL, CAST(N'2019-07-19T01:24:04.000' AS DateTime), 1, CAST(N'2019-07-19T01:24:49.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (47, 44, N'Silver', 1, N'Silver', 1, 1, 21, NULL, CAST(N'2019-07-19T01:24:51.000' AS DateTime), 1, CAST(N'2019-07-19T01:25:33.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (48, 44, N'TradingAssets', 1, N'Trading ssets ( Plots, Shares, asset)', 1, 1, 21, NULL, CAST(N'2019-07-19T01:26:25.000' AS DateTime), 1, CAST(N'2019-07-19T01:27:00.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (49, 44, N'Committee/BC', 5, N'Committee/BC valuation amount', 1, 1, 22, NULL, CAST(N'2019-07-19T01:27:22.000' AS DateTime), 1, CAST(N'2019-07-19T01:27:41.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (50, 44, N'Livestock', 5, N'Livestock for trading or plot', 1, 1, 23, NULL, CAST(N'2019-07-19T01:27:50.000' AS DateTime), 1, CAST(N'2019-07-19T01:28:24.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (51, 44, N'Other Assets', 1, N'Other assets that are more than basic needs (LED etc)', 1, 1, 24, NULL, CAST(N'2019-07-19T01:28:26.000' AS DateTime), 1, CAST(N'2019-07-19T01:28:49.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (52, 44, N'ExcessiveMobile', 5, N'Excessive  Mobile Phone (Not In use)', 1, 1, 25, NULL, CAST(N'2019-07-19T01:29:13.000' AS DateTime), 1, CAST(N'2019-07-19T01:29:37.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (53, 44, N'Excessive Transport', 5, N'Excessive means of transport (not in use)', 1, 1, 26, NULL, CAST(N'2019-07-19T01:29:46.000' AS DateTime), 1, CAST(N'2019-07-19T01:30:15.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (54, 44, N'Have given any loan or deposits', 1, N'Have given any loan or deposits', 1, 1, 27, NULL, CAST(N'2019-07-19T01:30:26.000' AS DateTime), 1, CAST(N'2019-07-19T01:30:46.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (55, 44, N'Land/ plot', 1, N'Land/ plot/ or shop that is not being utilized or rented', 1, 1, 27, NULL, CAST(N'2019-07-19T01:30:56.000' AS DateTime), 1, CAST(N'2019-07-19T01:31:17.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (56, 44, N'Any investment', 1, N'Any investment in money market (Stocks, bonds etc)', 1, 1, 28, NULL, CAST(N'2019-07-19T01:31:27.000' AS DateTime), 1, CAST(N'2019-07-19T01:31:43.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (57, 44, N'NetAssets:', 5, N'Net Assets:', 1, 1, 28, NULL, CAST(N'2019-07-19T01:34:54.000' AS DateTime), 1, CAST(N'2019-07-19T01:35:13.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (58, NULL, N'NetLiabilities', 4, N'Net Liabilities:', 1, 1, 30, NULL, CAST(N'2019-07-19T01:35:22.000' AS DateTime), 1, CAST(N'2019-07-19T01:37:12.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (59, 58, N'Assets', 5, N'Assets:', 1, 1, 31, NULL, CAST(N'2019-07-19T01:37:14.000' AS DateTime), 1, CAST(N'2019-07-19T01:37:52.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (60, 58, N'Rent Payable', 5, N'Rent Payable', 1, 1, 31, NULL, CAST(N'2019-07-19T01:39:01.000' AS DateTime), 1, CAST(N'2019-07-19T01:39:20.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (61, 58, N'Security deposit or advance payable', 5, N'Security deposit or advance payable', 1, 1, 32, NULL, CAST(N'2019-07-19T01:39:44.000' AS DateTime), 1, CAST(N'2019-07-19T01:40:05.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (62, 58, N'Sum/Number of remain BC installment', 5, N'Sum/Number of remain BC installment', 1, 1, 33, NULL, CAST(N'2019-07-19T01:40:13.000' AS DateTime), 1, CAST(N'2019-07-19T01:40:27.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (63, 58, N'Utility Bills', 5, N'Utility Bill', 1, 1, 34, NULL, CAST(N'2019-07-19T01:40:34.000' AS DateTime), 1, CAST(N'2019-07-19T01:40:58.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (64, 58, N'Loan payable to organization(s)', 5, N'Loan payable to organization(s)', 1, 1, 35, NULL, CAST(N'2019-07-19T01:41:18.000' AS DateTime), 1, CAST(N'2019-07-19T01:41:32.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (65, 58, N'Loan payable to peers', 5, N'Loan payable to peers', 1, 1, 36, NULL, CAST(N'2019-07-19T01:41:46.000' AS DateTime), 1, CAST(N'2019-07-19T01:42:02.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (66, 58, N'Total', 5, N'Total', 1, 1, 37, NULL, CAST(N'2019-07-19T01:42:34.000' AS DateTime), 1, CAST(N'2019-07-19T01:42:53.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (67, NULL, N'Net Assets A', 4, N'Net Assets A:', 1, 1, 38, NULL, CAST(N'2019-07-19T01:42:55.000' AS DateTime), 1, CAST(N'2019-07-19T01:48:29.000' AS DateTime), 1)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (70, 67, N'Total Assets:', 5, N'Total Assets:', 1, 1, 41, NULL, CAST(N'2019-07-19T01:48:36.000' AS DateTime), 1, CAST(N'2019-07-19T01:49:14.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (71, 67, N'TotalLiabilities', 5, N'TotalLiabilities', 1, 1, 42, NULL, CAST(N'2019-07-19T01:49:25.000' AS DateTime), 1, CAST(N'2019-07-19T01:49:49.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (72, 67, N'Net Asset', 5, N'Net Asset', 1, 1, 43, N'TotalAssets-TotalLiabilities', CAST(N'2019-07-19T01:49:56.000' AS DateTime), 1, CAST(N'2019-07-19T23:06:30.000' AS DateTime), 1)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (73, NULL, N'Other info:', 4, N'Other info:', 1, 1, 43, NULL, CAST(N'2019-07-19T01:50:48.000' AS DateTime), 1, CAST(N'2019-07-19T01:51:14.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (74, 73, N'Syed/Hashmi', 7, N'Syed/Hashmi', 1, 1, 44, NULL, CAST(N'2019-07-19T01:51:15.000' AS DateTime), 1, CAST(N'2019-07-19T22:48:34.000' AS DateTime), 1)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (75, 73, N'Shia/ Sunni', 7, N'Shia/ Sunni', 1, 1, 45, NULL, CAST(N'2019-07-19T01:55:29.000' AS DateTime), 1, CAST(N'2019-07-19T22:48:16.000' AS DateTime), 1)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (77, 73, N'Affiliation with Ahmadi, Qaideani or any similar school of thought ?', 5, N'Affiliation with Ahmadi, Qaideani or any similar school of thought ?', 1, 1, 46, NULL, CAST(N'2019-07-19T01:59:01.000' AS DateTime), 1, CAST(N'2019-07-19T01:59:44.000' AS DateTime), 1)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (78, NULL, N'Zakat Valuation:', 4, N'Zakat Valuation:', 1, 1, 47, NULL, CAST(N'2019-07-19T02:01:05.000' AS DateTime), 1, CAST(N'2019-07-19T02:01:23.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (79, 78, N'Current Zakat Valuation', 1, N'Current Zakat Valuation', 1, 1, 47, NULL, CAST(N'2019-07-19T02:01:25.000' AS DateTime), 1, CAST(N'2019-07-19T02:01:58.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (80, 78, N'Is beneficiary net asset value equal or more than current zakat value?', 1, N'Is beneficiary net asset value equal or more than current zakat value?', 1, 1, 48, NULL, CAST(N'2019-07-19T02:02:00.000' AS DateTime), 1, CAST(N'2019-07-19T02:02:25.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (81, NULL, N'Applicant Family Details', 4, N'Applicant Family Details', 1, 1, 49, NULL, CAST(N'2019-07-19T02:05:03.000' AS DateTime), 1, CAST(N'2019-07-19T02:05:23.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (82, 81, N'Numberofdependentsinhousehold:', 5, N'Number of dependents in household:', 1, 1, 50, NULL, CAST(N'2019-07-19T02:05:34.000' AS DateTime), 1, CAST(N'2019-07-19T02:06:07.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (83, 81, N'Numberofchildren', 5, N'Number of children', 1, 1, 51, NULL, CAST(N'2019-07-19T02:06:09.000' AS DateTime), 1, CAST(N'2019-07-19T02:06:35.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (84, 81, N'Numberof males', 5, N'Number of males in household with ages', 1, 1, 52, NULL, CAST(N'2019-07-19T02:06:36.000' AS DateTime), 1, CAST(N'2019-07-19T02:06:57.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (85, 81, N'Number of female', 5, N'Number of female in house hold with age', 1, 1, 53, NULL, CAST(N'2019-07-19T02:06:59.000' AS DateTime), 1, CAST(N'2019-07-19T02:07:29.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (86, 81, N'Number of children receiving education', 5, N'Number of children receiving education', 1, 1, 54, NULL, CAST(N'2019-07-19T02:07:35.000' AS DateTime), 1, CAST(N'2019-07-19T02:07:50.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (87, 81, N'Number of dependent brother', 5, N'Number of dependent brother', 1, 1, 55, NULL, CAST(N'2019-07-19T02:07:55.000' AS DateTime), 1, CAST(N'2019-07-19T02:08:09.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (88, 81, N'Number of sister dependent', 5, N'Number of sister dependent', 1, 1, 56, NULL, CAST(N'2019-07-19T02:08:14.000' AS DateTime), 1, CAST(N'2019-07-19T02:08:29.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (89, 81, N'Number of person in house are earning', 5, N'Number of person in house are earning', 1, 1, 57, NULL, CAST(N'2019-07-19T02:08:34.000' AS DateTime), 1, CAST(N'2019-07-19T02:08:51.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (90, 81, N'Source of income', 1, N'Source of income', 1, 1, 58, NULL, CAST(N'2019-07-19T02:08:57.000' AS DateTime), 1, CAST(N'2019-07-19T02:09:11.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (91, 81, N'Prior Financial of Support', 1, N'Prior Financial of Support', 1, 1, 59, NULL, CAST(N'2019-07-19T02:09:17.000' AS DateTime), 1, CAST(N'2019-07-19T02:09:32.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (92, 81, N'I own a TV.', 1, N'I own a TV', 1, 1, 61, NULL, CAST(N'2019-07-19T02:10:14.000' AS DateTime), 1, CAST(N'2019-07-19T02:11:19.000' AS DateTime), 1)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (93, 81, N'I own a smart phone', 1, N'I own a smart phone', 1, 1, 62, NULL, CAST(N'2019-07-19T02:10:37.000' AS DateTime), 1, CAST(N'2019-07-19T02:11:32.000' AS DateTime), 1)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (94, NULL, N'Stream', 4, N'Stream:', 1, 1, 64, NULL, CAST(N'2019-07-19T02:12:12.000' AS DateTime), 1, CAST(N'2019-07-19T02:39:58.000' AS DateTime), 1)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (95, 94, N'Ration', 3, N'Ration', 1, 1, 64, NULL, CAST(N'2019-07-19T02:13:49.000' AS DateTime), 1, CAST(N'2019-07-19T02:14:14.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (96, 94, N'Health', 3, N'Health', 1, 1, 65, NULL, CAST(N'2019-07-19T02:14:17.000' AS DateTime), 1, CAST(N'2019-07-19T02:14:37.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (97, 94, N'Education', 3, N'Education', 1, 1, 67, NULL, CAST(N'2019-07-19T02:14:41.000' AS DateTime), 1, CAST(N'2019-07-19T02:17:14.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (98, 94, N'Dowry', 3, N'Dowry', 1, 1, 69, NULL, CAST(N'2019-07-19T02:17:21.000' AS DateTime), 1, CAST(N'2019-07-19T02:17:36.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (99, 94, N'Loan', 3, N'Loan', 1, 1, 70, NULL, CAST(N'2019-07-19T02:17:41.000' AS DateTime), 1, CAST(N'2019-07-19T02:18:00.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (100, 94, N'Rent', 3, N'Rent', 1, 1, 71, NULL, CAST(N'2019-07-19T02:18:15.000' AS DateTime), 1, CAST(N'2019-07-19T02:18:31.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (101, 94, N'Others', 1, N'Others', 1, 1, 72, NULL, CAST(N'2019-07-19T02:18:37.000' AS DateTime), 1, CAST(N'2019-07-19T02:18:50.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (102, 94, N'Applicant Sign', 1, N'Applicant Sign', 1, 1, 73, NULL, CAST(N'2019-07-19T02:41:40.000' AS DateTime), 1, CAST(N'2019-07-19T02:42:39.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (103, 94, N'Field Officer Sign', 1, N'Field Officer Sign', 1, 1, 72, NULL, CAST(N'2019-07-19T02:42:49.000' AS DateTime), 1, CAST(N'2019-07-19T02:43:22.000' AS DateTime), 1)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (104, NULL, N'Recommendation:', 4, N'Recommendation:', 1, 1, 75, NULL, CAST(N'2019-07-19T02:43:46.000' AS DateTime), 1, CAST(N'2019-07-19T02:44:07.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (105, 104, N'Field Officer Recommendation', 8, N'Field Officer Recommendation', 1, 1, 76, NULL, CAST(N'2019-07-19T02:44:11.000' AS DateTime), 1, CAST(N'2019-07-19T22:50:32.000' AS DateTime), 1)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (106, 104, N'Recommendation Amount', 5, N'Recommendation Amount', 1, 1, 77, NULL, CAST(N'2019-07-19T02:44:43.000' AS DateTime), 1, CAST(N'2019-07-19T02:46:10.000' AS DateTime), NULL)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (107, 104, N'Committee Recommendation', 8, N'Committee Recommendation', 1, 1, 78, NULL, CAST(N'2019-07-19T02:46:33.000' AS DateTime), 1, CAST(N'2019-07-19T22:51:16.000' AS DateTime), 1)
GO
INSERT [dbo].[Fields] ([FieldID], [ParentFieldID], [FieldName], [FieldTypeID], [DisplayName], [IsRequired], [IsActive], [DisplaySeqNo], [Source], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (108, 104, N'Ulema Recommendation', 8, N'Ulema Recommendation:', 1, 1, 80, NULL, CAST(N'2019-07-19T02:47:16.000' AS DateTime), 1, CAST(N'2019-07-19T22:49:26.000' AS DateTime), 1)
GO
SET IDENTITY_INSERT [dbo].[Fields] OFF
GO
INSERT [dbo].[FieldTypes] ([FieldTypeID], [FieldTypeName], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (1, N'Text', 1, CAST(N'2019-07-09T18:54:42.000' AS DateTime), 1, CAST(N'2019-07-10T00:37:04.000' AS DateTime), 1)
GO
INSERT [dbo].[FieldTypes] ([FieldTypeID], [FieldTypeName], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (2, N'DropDownList', 1, CAST(N'2019-07-09T18:54:51.000' AS DateTime), 1, CAST(N'2019-07-09T18:55:08.000' AS DateTime), NULL)
GO
INSERT [dbo].[FieldTypes] ([FieldTypeID], [FieldTypeName], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (3, N'CheckBox', 1, CAST(N'2019-07-09T18:56:32.000' AS DateTime), 1, CAST(N'2019-07-09T18:56:39.000' AS DateTime), NULL)
GO
INSERT [dbo].[FieldTypes] ([FieldTypeID], [FieldTypeName], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (4, N'Heading', 1, CAST(N'2019-07-09T18:59:18.000' AS DateTime), 1, CAST(N'2019-07-09T18:59:25.000' AS DateTime), NULL)
GO
INSERT [dbo].[FieldTypes] ([FieldTypeID], [FieldTypeName], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (5, N'Number', 1, CAST(N'2019-07-10T00:37:12.000' AS DateTime), 1, CAST(N'2019-07-10T00:37:23.000' AS DateTime), NULL)
GO
INSERT [dbo].[FieldTypes] ([FieldTypeID], [FieldTypeName], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (6, N'DateTime', 1, CAST(N'2019-07-10T00:39:40.000' AS DateTime), 1, CAST(N'2019-07-10T00:39:47.000' AS DateTime), NULL)
GO
INSERT [dbo].[FieldTypes] ([FieldTypeID], [FieldTypeName], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (7, N'RadioButton', 1, CAST(N'2019-07-12T02:12:14.000' AS DateTime), 4, CAST(N'2019-07-12T02:12:21.000' AS DateTime), NULL)
GO
INSERT [dbo].[FieldTypes] ([FieldTypeID], [FieldTypeName], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (8, N'RichTextBox', 1, CAST(N'2019-07-19T22:43:07.000' AS DateTime), 1, CAST(N'2019-07-19T22:43:16.000' AS DateTime), NULL)
GO
INSERT [dbo].[FieldTypes] ([FieldTypeID], [FieldTypeName], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (9, N'Formula', 1, CAST(N'2019-07-19T22:52:16.000' AS DateTime), 1, CAST(N'2019-07-19T22:52:26.000' AS DateTime), NULL)
GO
SET IDENTITY_INSERT [dbo].[FieldValues] ON 
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (1, 3, 2, N'zainab d/o ahmed zada', CAST(N'2019-07-16T23:32:35.133' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (2, 3, 3, N'qasba colony, banaras, karachi', CAST(N'2019-07-16T23:32:35.133' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (3, 3, 4, N'1000', CAST(N'2019-07-16T23:32:35.133' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (4, 3, 5, N'7000', CAST(N'2019-07-16T23:32:35.133' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (5, 3, 6, N'1000', CAST(N'2019-07-16T23:32:35.133' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (6, 3, 17, N'2000', CAST(N'2019-07-16T23:32:35.133' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (7, 3, 8, N'1000', CAST(N'2019-07-16T23:32:35.133' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (8, 3, 9, N'0', CAST(N'2019-07-16T23:32:35.133' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (9, 3, 10, N'0', CAST(N'2019-07-16T23:32:35.133' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (10, 3, 11, N'0', CAST(N'2019-07-16T23:32:35.133' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (11, 3, 13, N'1000', CAST(N'2019-07-16T23:32:35.133' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (12, 3, 15, N'0', CAST(N'2019-07-16T23:32:35.133' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (13, 3, 16, N'0', CAST(N'2019-07-16T23:32:35.133' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (14, 3, 23, N'0', CAST(N'2019-07-16T23:32:35.133' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (15, 3, 20, N'sardar', CAST(N'2019-07-16T23:32:35.133' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (16, 3, 21, N'zainab', CAST(N'2019-07-16T23:32:35.133' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (17, 4, 2, N'zainab d/o ahmed zada', CAST(N'2019-07-16T23:32:35.633' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (18, 4, 3, N'qasba colony, banaras, karachi', CAST(N'2019-07-16T23:32:35.633' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (19, 4, 4, N'1000', CAST(N'2019-07-16T23:32:35.633' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (20, 4, 5, N'7000', CAST(N'2019-07-16T23:32:35.633' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (21, 4, 6, N'1000', CAST(N'2019-07-16T23:32:35.633' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (22, 4, 17, N'2000', CAST(N'2019-07-16T23:32:35.633' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (23, 4, 8, N'1000', CAST(N'2019-07-16T23:32:35.633' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (24, 4, 9, N'0', CAST(N'2019-07-16T23:32:35.633' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (25, 4, 10, N'0', CAST(N'2019-07-16T23:32:35.633' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (26, 4, 11, N'0', CAST(N'2019-07-16T23:32:35.633' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (27, 4, 13, N'1000', CAST(N'2019-07-16T23:32:35.633' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (28, 4, 15, N'0', CAST(N'2019-07-16T23:32:35.633' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (29, 4, 16, N'0', CAST(N'2019-07-16T23:32:35.633' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (30, 4, 23, N'0', CAST(N'2019-07-16T23:32:35.633' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (31, 4, 20, N'sardar', CAST(N'2019-07-16T23:32:35.633' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (32, 4, 21, N'zainab', CAST(N'2019-07-16T23:32:35.633' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (33, 5, 2, N'zainab d/o ahmed zada', CAST(N'2019-07-16T23:32:36.150' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (34, 5, 3, N'qasba colony, banaras, karachi', CAST(N'2019-07-16T23:32:36.150' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (35, 5, 4, N'1000', CAST(N'2019-07-16T23:32:36.150' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (36, 5, 5, N'7000', CAST(N'2019-07-16T23:32:36.150' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (37, 5, 6, N'1000', CAST(N'2019-07-16T23:32:36.150' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (38, 5, 17, N'2000', CAST(N'2019-07-16T23:32:36.150' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (39, 5, 8, N'1000', CAST(N'2019-07-16T23:32:36.150' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (40, 5, 9, N'0', CAST(N'2019-07-16T23:32:36.150' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (41, 5, 10, N'0', CAST(N'2019-07-16T23:32:36.150' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (42, 5, 11, N'0', CAST(N'2019-07-16T23:32:36.150' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (43, 5, 13, N'1000', CAST(N'2019-07-16T23:32:36.150' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (44, 5, 15, N'0', CAST(N'2019-07-16T23:32:36.150' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (45, 5, 16, N'0', CAST(N'2019-07-16T23:32:36.150' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (46, 5, 23, N'0', CAST(N'2019-07-16T23:32:36.150' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (47, 5, 20, N'sardar', CAST(N'2019-07-16T23:32:36.150' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (48, 5, 21, N'zainab', CAST(N'2019-07-16T23:32:36.150' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (49, 6, 2, N'zainab d/o ahmed zada', CAST(N'2019-07-16T23:32:36.650' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (50, 6, 3, N'qasba colony, banaras, karachi', CAST(N'2019-07-16T23:32:36.650' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (51, 6, 4, N'1000', CAST(N'2019-07-16T23:32:36.650' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (52, 6, 5, N'7000', CAST(N'2019-07-16T23:32:36.650' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (53, 6, 6, N'1000', CAST(N'2019-07-16T23:32:36.650' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (54, 6, 17, N'2000', CAST(N'2019-07-16T23:32:36.650' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (55, 6, 8, N'1000', CAST(N'2019-07-16T23:32:36.650' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (56, 6, 9, N'0', CAST(N'2019-07-16T23:32:36.650' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (57, 6, 10, N'0', CAST(N'2019-07-16T23:32:36.650' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (58, 6, 11, N'0', CAST(N'2019-07-16T23:32:36.650' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (59, 6, 13, N'1000', CAST(N'2019-07-16T23:32:36.650' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (60, 6, 15, N'0', CAST(N'2019-07-16T23:32:36.650' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (61, 6, 16, N'0', CAST(N'2019-07-16T23:32:36.650' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (62, 6, 23, N'0', CAST(N'2019-07-16T23:32:36.650' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (63, 6, 20, N'sardar', CAST(N'2019-07-16T23:32:36.650' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (64, 6, 21, N'zainab', CAST(N'2019-07-16T23:32:36.650' AS DateTime), 4, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (65, 7, 2, N'Rashid Khan', CAST(N'2019-07-18T21:09:53.510' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (66, 7, 3, N'13/A Liyari, Karachi, Pakistan', CAST(N'2019-07-18T21:09:53.510' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (67, 7, 4, N'1000', CAST(N'2019-07-18T21:09:53.510' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (68, 7, 5, N'3000', CAST(N'2019-07-18T21:09:53.510' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (69, 7, 6, N'1500', CAST(N'2019-07-18T21:09:53.510' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (70, 7, 17, N'2500', CAST(N'2019-07-18T21:09:53.510' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (71, 7, 8, N'5000', CAST(N'2019-07-18T21:09:53.510' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (72, 7, 9, N'12000', CAST(N'2019-07-18T21:09:53.510' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (73, 7, 10, N'12000', CAST(N'2019-07-18T21:09:53.510' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (74, 7, 11, N'0', CAST(N'2019-07-18T21:09:53.510' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (75, 7, 13, N'03330333333', CAST(N'2019-07-18T21:09:53.510' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (76, 7, 15, N'10000', CAST(N'2019-07-18T21:09:53.510' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (77, 7, 16, N'10000', CAST(N'2019-07-18T21:09:53.510' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (78, 7, 23, N'10000', CAST(N'2019-07-18T21:09:53.510' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (79, 7, 20, N'Y', CAST(N'2019-07-18T21:09:53.510' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (80, 7, 21, N'Y', CAST(N'2019-07-18T21:09:53.510' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (81, 8, 2, N'Rashid Khan', CAST(N'2019-07-18T21:09:54.277' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (82, 8, 3, N'13/A Liyari, Karachi, Pakistan', CAST(N'2019-07-18T21:09:54.277' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (83, 8, 4, N'1000', CAST(N'2019-07-18T21:09:54.277' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (84, 8, 5, N'3000', CAST(N'2019-07-18T21:09:54.277' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (85, 8, 6, N'1500', CAST(N'2019-07-18T21:09:54.277' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (86, 8, 17, N'2500', CAST(N'2019-07-18T21:09:54.277' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (87, 8, 8, N'5000', CAST(N'2019-07-18T21:09:54.277' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (88, 8, 9, N'12000', CAST(N'2019-07-18T21:09:54.277' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (89, 8, 10, N'12000', CAST(N'2019-07-18T21:09:54.277' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (90, 8, 11, N'0', CAST(N'2019-07-18T21:09:54.277' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (91, 8, 13, N'03330333333', CAST(N'2019-07-18T21:09:54.277' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (92, 8, 15, N'10000', CAST(N'2019-07-18T21:09:54.277' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (93, 8, 16, N'10000', CAST(N'2019-07-18T21:09:54.277' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (94, 8, 23, N'10000', CAST(N'2019-07-18T21:09:54.277' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (95, 8, 20, N'Y', CAST(N'2019-07-18T21:09:54.277' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (96, 8, 21, N'Y', CAST(N'2019-07-18T21:09:54.277' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (97, 9, 2, N'Rohit Kumar', CAST(N'2019-07-18T22:43:21.357' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (98, 9, 3, N'Defense View', CAST(N'2019-07-18T22:43:21.357' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (99, 9, 4, N'10000', CAST(N'2019-07-18T22:43:21.357' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (100, 9, 5, N'10000', CAST(N'2019-07-18T22:43:21.357' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (101, 9, 6, N'10000', CAST(N'2019-07-18T22:43:21.357' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (102, 9, 17, N'10000', CAST(N'2019-07-18T22:43:21.357' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (103, 9, 8, N'5000', CAST(N'2019-07-18T22:43:21.357' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (104, 9, 9, N'0', CAST(N'2019-07-18T22:43:21.357' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (105, 9, 10, N'5', CAST(N'2019-07-18T22:43:21.357' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (106, 9, 11, N'1 car earns 10000 ', CAST(N'2019-07-18T22:43:21.357' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (107, 9, 13, N'1', CAST(N'2019-07-18T22:43:21.357' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (108, 9, 15, N'17500', CAST(N'2019-07-18T22:43:21.357' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (109, 9, 16, N'5000', CAST(N'2019-07-18T22:43:21.357' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (110, 9, 23, N'4500', CAST(N'2019-07-18T22:43:21.357' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (111, 9, 20, N'Field Officer', CAST(N'2019-07-18T22:43:21.357' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (112, 9, 21, N'Applicant', CAST(N'2019-07-18T22:43:21.357' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (113, 10, 28, N'Raja Ji', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (114, 10, 29, N'Bade Raja Ji', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (115, 10, 30, N'420011221122121', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (116, 10, 31, N'131', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (117, 10, 32, N'0210', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (118, 10, 35, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (119, 10, 37, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (120, 10, 38, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (121, 10, 39, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (122, 10, 40, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (123, 10, 41, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (124, 10, 42, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (125, 10, 43, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (126, 10, 45, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (127, 10, 46, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (128, 10, 47, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (129, 10, 48, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (130, 10, 49, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (131, 10, 50, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (132, 10, 51, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (133, 10, 52, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (134, 10, 53, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (135, 10, 54, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (136, 10, 55, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (137, 10, 56, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (138, 10, 57, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (139, 10, 59, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (140, 10, 60, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (141, 10, 61, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (142, 10, 62, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (143, 10, 63, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (144, 10, 64, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (145, 10, 65, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (146, 10, 66, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (147, 10, 70, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (148, 10, 71, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (149, 10, 72, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (150, 10, 74, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (151, 10, 75, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (152, 10, 77, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (153, 10, 79, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (154, 10, 80, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (155, 10, 82, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (156, 10, 83, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (157, 10, 84, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (158, 10, 85, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (159, 10, 86, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (160, 10, 87, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (161, 10, 88, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (162, 10, 89, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (163, 10, 90, N'101', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (164, 10, 91, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (165, 10, 92, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (166, 10, 93, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (167, 10, 101, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (168, 10, 103, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (169, 10, 102, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (170, 10, 105, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (171, 10, 106, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (172, 10, 107, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (173, 10, 108, N'10', CAST(N'2019-07-19T23:17:15.407' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (174, 11, 28, N'Raja Ji', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (175, 11, 29, N'Bade Raja Ji', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (176, 11, 30, N'420011221122121', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (177, 11, 31, N'131', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (178, 11, 32, N'0210', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (179, 11, 35, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (180, 11, 37, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (181, 11, 38, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (182, 11, 39, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (183, 11, 40, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (184, 11, 41, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (185, 11, 42, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (186, 11, 43, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (187, 11, 45, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (188, 11, 46, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (189, 11, 47, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (190, 11, 48, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (191, 11, 49, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (192, 11, 50, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (193, 11, 51, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (194, 11, 52, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (195, 11, 53, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (196, 11, 54, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (197, 11, 55, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (198, 11, 56, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (199, 11, 57, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (200, 11, 59, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (201, 11, 60, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (202, 11, 61, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (203, 11, 62, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (204, 11, 63, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (205, 11, 64, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (206, 11, 65, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (207, 11, 66, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (208, 11, 70, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (209, 11, 71, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (210, 11, 72, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (211, 11, 74, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (212, 11, 75, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (213, 11, 77, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (214, 11, 79, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (215, 11, 80, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (216, 11, 82, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (217, 11, 83, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (218, 11, 84, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (219, 11, 85, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (220, 11, 86, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (221, 11, 87, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (222, 11, 88, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (223, 11, 89, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (224, 11, 90, N'101', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (225, 11, 91, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (226, 11, 92, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (227, 11, 93, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (228, 11, 101, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (229, 11, 103, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (230, 11, 102, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (231, 11, 105, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (232, 11, 106, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (233, 11, 107, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[FieldValues] ([FieldValueID], [ApplicationID], [FieldID], [Data], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (234, 11, 108, N'10', CAST(N'2019-07-19T23:17:15.903' AS DateTime), 1, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[FieldValues] OFF
GO
SET IDENTITY_INSERT [dbo].[RationAmounts] ON 
GO
INSERT [dbo].[RationAmounts] ([RationAmountID], [NoOfPerson], [Amount], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (1, 1, 700, 1, CAST(N'2019-07-19T22:59:50.000' AS DateTime), 1, CAST(N'2019-07-19T22:59:53.000' AS DateTime), NULL)
GO
SET IDENTITY_INSERT [dbo].[RationAmounts] OFF
GO
INSERT [dbo].[Rights] ([RightID], [RightName], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (1, N'Add', 1, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Rights] ([RightID], [RightName], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (2, N'Update', 1, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Rights] ([RightID], [RightName], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (3, N'Delete', 1, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Rights] ([RightID], [RightName], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (4, N'View-Self', 1, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Rights] ([RightID], [RightName], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (5, N'View-All', 1, NULL, 1, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[RoleRights] ON 
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (1, 1, 1, 1, CAST(N'2019-07-15T18:11:06.103' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.103' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (2, 1, 1, 2, CAST(N'2019-07-15T18:11:06.110' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.110' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (3, 1, 1, 4, CAST(N'2019-07-15T18:11:06.113' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.113' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (4, 1, 1, 3, CAST(N'2019-07-15T18:11:06.113' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.113' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (5, 1, 1, 18, CAST(N'2019-07-15T18:11:06.113' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.113' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (6, 1, 1, 5, CAST(N'2019-07-15T18:11:06.113' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.113' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (7, 1, 1, 6, CAST(N'2019-07-15T18:11:06.113' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.113' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (8, 1, 1, 7, CAST(N'2019-07-15T18:11:06.113' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.113' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (9, 1, 1, 8, CAST(N'2019-07-15T18:11:06.113' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.113' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (10, 1, 1, 9, CAST(N'2019-07-15T18:11:06.113' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.113' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (11, 1, 1, 10, CAST(N'2019-07-15T18:11:06.113' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.113' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (12, 1, 1, 11, CAST(N'2019-07-15T18:11:06.113' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.113' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (13, 1, 1, 13, CAST(N'2019-07-15T18:11:06.113' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.113' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (14, 1, 1, 12, CAST(N'2019-07-15T18:11:06.113' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.113' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (15, 1, 1, 14, CAST(N'2019-07-15T18:11:06.117' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.117' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (16, 1, 1, 17, CAST(N'2019-07-15T18:11:06.117' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.117' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (17, 1, 1, 16, CAST(N'2019-07-15T18:11:06.117' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.117' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (18, 1, 3, 1, CAST(N'2019-07-15T18:11:06.117' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.117' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (19, 1, 3, 2, CAST(N'2019-07-15T18:11:06.117' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.117' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (20, 1, 3, 4, CAST(N'2019-07-15T18:11:06.117' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.117' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (21, 1, 3, 3, CAST(N'2019-07-15T18:11:06.117' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.117' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (22, 1, 3, 18, CAST(N'2019-07-15T18:11:06.117' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.117' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (23, 1, 3, 5, CAST(N'2019-07-15T18:11:06.117' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.117' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (24, 1, 3, 6, CAST(N'2019-07-15T18:11:06.117' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.117' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (25, 1, 3, 7, CAST(N'2019-07-15T18:11:06.117' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.117' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (26, 1, 3, 8, CAST(N'2019-07-15T18:11:06.117' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.117' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (27, 1, 3, 9, CAST(N'2019-07-15T18:11:06.117' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.117' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (28, 1, 3, 10, CAST(N'2019-07-15T18:11:06.117' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.117' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (29, 1, 3, 11, CAST(N'2019-07-15T18:11:06.117' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.117' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (30, 1, 3, 13, CAST(N'2019-07-15T18:11:06.117' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.117' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (31, 1, 3, 12, CAST(N'2019-07-15T18:11:06.120' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.120' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (32, 1, 3, 14, CAST(N'2019-07-15T18:11:06.120' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.120' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (33, 1, 3, 17, CAST(N'2019-07-15T18:11:06.120' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.120' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (34, 1, 3, 16, CAST(N'2019-07-15T18:11:06.120' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.120' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (35, 1, 2, 1, CAST(N'2019-07-15T18:11:06.120' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.120' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (36, 1, 2, 2, CAST(N'2019-07-15T18:11:06.120' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.120' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (37, 1, 2, 4, CAST(N'2019-07-15T18:11:06.120' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.120' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (38, 1, 2, 3, CAST(N'2019-07-15T18:11:06.120' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.120' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (39, 1, 2, 18, CAST(N'2019-07-15T18:11:06.120' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.120' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (40, 1, 2, 5, CAST(N'2019-07-15T18:11:06.120' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.120' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (41, 1, 2, 6, CAST(N'2019-07-15T18:11:06.120' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.120' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (42, 1, 2, 7, CAST(N'2019-07-15T18:11:06.120' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.120' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (43, 1, 2, 8, CAST(N'2019-07-15T18:11:06.120' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.120' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (44, 1, 2, 9, CAST(N'2019-07-15T18:11:06.120' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.120' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (45, 1, 2, 10, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (46, 1, 2, 11, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (47, 1, 2, 13, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (48, 1, 2, 12, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (49, 1, 2, 14, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (50, 1, 2, 17, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (51, 1, 2, 16, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (52, 1, 5, 1, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (53, 1, 5, 2, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (54, 1, 5, 4, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (55, 1, 5, 3, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (56, 1, 5, 18, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (57, 1, 5, 5, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (58, 1, 5, 6, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (59, 1, 5, 7, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (60, 1, 5, 8, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (61, 1, 5, 9, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (62, 1, 5, 10, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (63, 1, 5, 11, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (64, 1, 5, 13, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (65, 1, 5, 12, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (66, 1, 5, 14, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (67, 1, 5, 17, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (68, 1, 5, 16, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (69, 1, 4, 1, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (70, 1, 4, 2, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (71, 1, 4, 4, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (72, 1, 4, 3, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (73, 1, 4, 18, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.123' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (74, 1, 4, 5, CAST(N'2019-07-15T18:11:06.127' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.127' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (75, 1, 4, 6, CAST(N'2019-07-15T18:11:06.127' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.127' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (76, 1, 4, 7, CAST(N'2019-07-15T18:11:06.127' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.127' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (77, 1, 4, 8, CAST(N'2019-07-15T18:11:06.127' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.127' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (78, 1, 4, 9, CAST(N'2019-07-15T18:11:06.127' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.127' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (79, 1, 4, 10, CAST(N'2019-07-15T18:11:06.127' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.127' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (80, 1, 4, 11, CAST(N'2019-07-15T18:11:06.127' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.127' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (81, 1, 4, 13, CAST(N'2019-07-15T18:11:06.127' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.127' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (82, 1, 4, 12, CAST(N'2019-07-15T18:11:06.127' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.127' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (83, 1, 4, 14, CAST(N'2019-07-15T18:11:06.127' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.127' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (84, 1, 4, 17, CAST(N'2019-07-15T18:11:06.127' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.127' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (85, 1, 4, 16, CAST(N'2019-07-15T18:11:06.127' AS DateTime), 1, CAST(N'2019-07-15T18:11:06.127' AS DateTime), 1)
GO
SET IDENTITY_INSERT [dbo].[RoleRights] OFF
GO
INSERT [dbo].[Roles] ([RoleID], [RoleName], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (1, N'Admin', 1, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Roles] ([RoleID], [RoleName], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (2, N'Field Team', 1, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Roles] ([RoleID], [RoleName], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (3, N'Committee', 1, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Roles] ([RoleID], [RoleName], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (4, N'RS', 1, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Statuses] ([StatusID], [StatusName], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (1, N'Active', 1, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Statuses] ([StatusID], [StatusName], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (2, N'Deactivated', 1, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Statuses] ([StatusID], [StatusName], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (3, N'Terminated', 1, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Statuses] ([StatusID], [StatusName], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (4, N'Request for Approval', 1, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Statuses] ([StatusID], [StatusName], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (5, N'Waiting for Approval', 1, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Statuses] ([StatusID], [StatusName], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (6, N'In Review', 1, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Statuses] ([StatusID], [StatusName], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (7, N'Rejected by', 1, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Statuses] ([StatusID], [StatusName], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (8, N'Approved by', 1, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Statuses] ([StatusID], [StatusName], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (9, N'Completed', 1, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Statuses] ([StatusID], [StatusName], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (10, N'Closed', 1, NULL, 1, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[UserRoles] ON 
GO
INSERT [dbo].[UserRoles] ([UserRoleID], [UserID], [RoleID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (1, 1, 1, NULL, 1, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[UserRoles] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 
GO
INSERT [dbo].[Users] ([UserID], [FullName], [DisplayName], [Email], [Password], [PictureID], [PictureURL], [MobileNo], [StatusID], [CreatedOn], [ModifiedOn], [CreatedBy], [ModifiedBy]) VALUES (1, N'Admin', N'Admin', N'admin@ihsaastrust.com', N'BP0qaZXHfNc=', 0, NULL, NULL, 1, NULL, NULL, 1, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FullName], [DisplayName], [Email], [Password], [PictureID], [PictureURL], [MobileNo], [StatusID], [CreatedOn], [ModifiedOn], [CreatedBy], [ModifiedBy]) VALUES (2, N'Committee', N'Committee', N'committee@ihsaastrust.com', N'BP0qaZXHfNc=', 0, NULL, NULL, 1, NULL, NULL, 1, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FullName], [DisplayName], [Email], [Password], [PictureID], [PictureURL], [MobileNo], [StatusID], [CreatedOn], [ModifiedOn], [CreatedBy], [ModifiedBy]) VALUES (3, N'RS', N'Committee', N'rs@ihsaastrust.com', N'BP0qaZXHfNc=', 0, NULL, NULL, 1, NULL, NULL, 1, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FullName], [DisplayName], [Email], [Password], [PictureID], [PictureURL], [MobileNo], [StatusID], [CreatedOn], [ModifiedOn], [CreatedBy], [ModifiedBy]) VALUES (4, N'Field Worker', N'Field Worker', N'fieldworker@ihsaastrust.com', N'BP0qaZXHfNc=', 0, NULL, NULL, 1, NULL, NULL, 1, NULL)
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
/****** Object:  Index [PK114]    Script Date: 20/07/2019 12:05:14 AM ******/
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [PK114] PRIMARY KEY NONCLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AppConfigs] ADD  CONSTRAINT [DF_AppConfigs_IsEditableByUser]  DEFAULT ((0)) FOR [IsEditableByUser]
GO
ALTER TABLE [dbo].[Applications] ADD  CONSTRAINT [DF_Applications_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[ApprovalHierarchies] ADD  CONSTRAINT [DF_ApprovalHierarchies_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[DynamicSetupScreens] ADD  CONSTRAINT [DF_DynamicSetupScreens_DS_AllowApprovals]  DEFAULT ((1)) FOR [DS_AllowApprovals]
GO
ALTER TABLE [dbo].[Entities] ADD  CONSTRAINT [DF__Entities__DataVe__0F975522]  DEFAULT ((0)) FOR [DataVersion]
GO
ALTER TABLE [dbo].[EntityDetails] ADD  CONSTRAINT [DF_EntityDetails_IsFileUpload]  DEFAULT ((0)) FOR [IsFileUpload]
GO
ALTER TABLE [dbo].[EntityDetails] ADD  CONSTRAINT [DF_EntityDetails_ShowGroupTitle]  DEFAULT ((0)) FOR [ShowGroupTitle]
GO
ALTER TABLE [dbo].[FieldTypes] ADD  CONSTRAINT [DF_FieldTypes_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Statuses] ADD  CONSTRAINT [DF_Table_1_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[ApprovalHierarchies]  WITH CHECK ADD  CONSTRAINT [FK_ApprovalHierarchies_CandidateID] FOREIGN KEY([CandidateID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[ApprovalHierarchies] CHECK CONSTRAINT [FK_ApprovalHierarchies_CandidateID]
GO
ALTER TABLE [dbo].[ApprovalHierarchies]  WITH CHECK ADD  CONSTRAINT [FK_ApprovalHierarchies_ReportedTo] FOREIGN KEY([ReportedTo])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[ApprovalHierarchies] CHECK CONSTRAINT [FK_ApprovalHierarchies_ReportedTo]
GO
ALTER TABLE [dbo].[ApprovalHierarchies]  WITH CHECK ADD  CONSTRAINT [FK_ApprovalHierarchies_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[ApprovalHierarchies] CHECK CONSTRAINT [FK_ApprovalHierarchies_Users]
GO
ALTER TABLE [dbo].[Approvals]  WITH CHECK ADD  CONSTRAINT [FK_Approvals_Entities] FOREIGN KEY([EntityID])
REFERENCES [dbo].[Entities] ([EntityID])
GO
ALTER TABLE [dbo].[Approvals] CHECK CONSTRAINT [FK_Approvals_Entities]
GO
ALTER TABLE [dbo].[Approvals]  WITH CHECK ADD  CONSTRAINT [FK_Approvals_Statuses] FOREIGN KEY([StatusID])
REFERENCES [dbo].[Statuses] ([StatusID])
GO
ALTER TABLE [dbo].[Approvals] CHECK CONSTRAINT [FK_Approvals_Statuses]
GO
ALTER TABLE [dbo].[Approvals]  WITH CHECK ADD  CONSTRAINT [FK_Approvals_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Approvals] CHECK CONSTRAINT [FK_Approvals_Users]
GO
ALTER TABLE [dbo].[EntityDetails]  WITH CHECK ADD  CONSTRAINT [FK_EntityDetails_EntityDetails] FOREIGN KEY([EntityID])
REFERENCES [dbo].[Entities] ([EntityID])
GO
ALTER TABLE [dbo].[EntityDetails] CHECK CONSTRAINT [FK_EntityDetails_EntityDetails]
GO
ALTER TABLE [dbo].[EntityDetails]  WITH CHECK ADD  CONSTRAINT [FK_EntityDetails_EntityDetails1] FOREIGN KEY([ParentSubGroupID])
REFERENCES [dbo].[EntityDetails] ([EntityDetailsID])
GO
ALTER TABLE [dbo].[EntityDetails] CHECK CONSTRAINT [FK_EntityDetails_EntityDetails1]
GO
ALTER TABLE [dbo].[Fields]  WITH CHECK ADD  CONSTRAINT [FK_Fields_Fields1] FOREIGN KEY([ParentFieldID])
REFERENCES [dbo].[Fields] ([FieldID])
GO
ALTER TABLE [dbo].[Fields] CHECK CONSTRAINT [FK_Fields_Fields1]
GO
ALTER TABLE [dbo].[Fields]  WITH CHECK ADD  CONSTRAINT [FK_Fields_FieldTypes] FOREIGN KEY([FieldTypeID])
REFERENCES [dbo].[FieldTypes] ([FieldTypeID])
GO
ALTER TABLE [dbo].[Fields] CHECK CONSTRAINT [FK_Fields_FieldTypes]
GO
ALTER TABLE [dbo].[RoleRights]  WITH CHECK ADD  CONSTRAINT [FK_RoleRights_Entities] FOREIGN KEY([EntityID])
REFERENCES [dbo].[Entities] ([EntityID])
GO
ALTER TABLE [dbo].[RoleRights] CHECK CONSTRAINT [FK_RoleRights_Entities]
GO
ALTER TABLE [dbo].[RoleRights]  WITH CHECK ADD  CONSTRAINT [FK_RoleRights_Rights] FOREIGN KEY([RightID])
REFERENCES [dbo].[Rights] ([RightID])
GO
ALTER TABLE [dbo].[RoleRights] CHECK CONSTRAINT [FK_RoleRights_Rights]
GO
ALTER TABLE [dbo].[RoleRights]  WITH CHECK ADD  CONSTRAINT [FK_RoleRights_Roles] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([RoleID])
GO
ALTER TABLE [dbo].[RoleRights] CHECK CONSTRAINT [FK_RoleRights_Roles]
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_UserRoles_Roles] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([RoleID])
GO
ALTER TABLE [dbo].[UserRoles] CHECK CONSTRAINT [FK_UserRoles_Roles]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Statuses] FOREIGN KEY([StatusID])
REFERENCES [dbo].[Statuses] ([StatusID])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Statuses]
GO
USE [master]
GO
ALTER DATABASE [IhsaasTrust] SET  READ_WRITE 
GO
