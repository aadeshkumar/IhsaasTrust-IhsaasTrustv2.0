GO
/****** Object:  Database [IhsaasTrust]    Script Date: 06/07/2019 4:59:09 PM ******/
CREATE DATABASE [IhsaasTrust]
GO
ALTER DATABASE [IhsaasTrust] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [IhsaasTrust].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [IhsaasTrust] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [IhsaasTrust] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [IhsaasTrust] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [IhsaasTrust] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [IhsaasTrust] SET ARITHABORT OFF 
GO
ALTER DATABASE [IhsaasTrust] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [IhsaasTrust] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [IhsaasTrust] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [IhsaasTrust] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [IhsaasTrust] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [IhsaasTrust] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [IhsaasTrust] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [IhsaasTrust] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [IhsaasTrust] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [IhsaasTrust] SET  DISABLE_BROKER 
GO
ALTER DATABASE [IhsaasTrust] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [IhsaasTrust] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [IhsaasTrust] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [IhsaasTrust] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [IhsaasTrust] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [IhsaasTrust] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [IhsaasTrust] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [IhsaasTrust] SET RECOVERY FULL 
GO
ALTER DATABASE [IhsaasTrust] SET  MULTI_USER 
GO
ALTER DATABASE [IhsaasTrust] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [IhsaasTrust] SET DB_CHAINING OFF 
GO
ALTER DATABASE [IhsaasTrust] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [IhsaasTrust] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [IhsaasTrust] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'IhsaasTrust', N'ON'
GO
ALTER DATABASE [IhsaasTrust] SET QUERY_STORE = OFF
GO
USE [IhsaasTrust]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [IhsaasTrust]
GO
/****** Object:  Table [dbo].[AppConfigs]    Script Date: 06/07/2019 4:59:10 PM ******/
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
/****** Object:  Table [dbo].[DynamicSetupScreens]    Script Date: 06/07/2019 4:59:10 PM ******/
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
/****** Object:  Table [dbo].[Entities]    Script Date: 06/07/2019 4:59:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Entities](
	[EntityID] [smallint] IDENTITY(1,1) NOT NULL,
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
/****** Object:  Table [dbo].[EntityDetails]    Script Date: 06/07/2019 4:59:10 PM ******/
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
/****** Object:  Table [dbo].[Rights]    Script Date: 06/07/2019 4:59:10 PM ******/
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
/****** Object:  Table [dbo].[RoleRights]    Script Date: 06/07/2019 4:59:10 PM ******/
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
/****** Object:  Table [dbo].[Roles]    Script Date: 06/07/2019 4:59:10 PM ******/
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
/****** Object:  Table [dbo].[UserRoles]    Script Date: 06/07/2019 4:59:10 PM ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 06/07/2019 4:59:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserTypeID] [smallint] NULL,
	[FullName] [nvarchar](256) NOT NULL,
	[DisplayName] [nvarchar](32) NOT NULL,
	[Email] [nvarchar](256) NOT NULL,
	[Password] [nvarchar](256) NOT NULL,
	[PictureID] [int] NULL,
	[PictureURL] [nvarchar](1024) NULL,
	[MobileNo] [nvarchar](32) NULL,
	[RecordStatus] [smallint] NOT NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedOn] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedBy] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserTypes]    Script Date: 06/07/2019 4:59:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserTypes](
	[UserTypeID] [smallint] IDENTITY(1,1) NOT NULL,
	[TypeName] [nvarchar](50) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [int] NULL,
 CONSTRAINT [PK_UserTypes] PRIMARY KEY CLUSTERED 
(
	[UserTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[DynamicSetupScreens] ON 
GO
INSERT [dbo].[DynamicSetupScreens] ([DynamicSetupScreenID], [ScreenName], [DS_TableName], [DS_Title], [DS_AllowAddEdit], [DS_AllowPreview], [DS_AllowSearchFilter], [DS_AllowListingGrid], [DS_GridColumns], [DS_AllowDelete], [DS_AllowEdit], [DS_ExcludeAddEditColumns], [DS_ExcludeSearchColumns], [DS_ShowAddNewButton], [DS_GridTitle], [DS_OrderBy], [DS_DoNotRenderJavaScript], [DS_ExtenderName], [DS_DontLoadRecursiveData], [DS_AllowImport], [DS_ParentColumnNameForRecursiveGrid], [DS_RecordsPerPage], [DS_ImportURL], [DS_ManualCrud], [DS_Filters], [DS_DisableSorting], [DS_ShowHistory], [DS_IsMenuNavigation], [DS_SecondaryTableConfigs], [DS_CustomJavaScript], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (1, N'Dynamic Screen Setup', N'DynamicSetupScreens', N'DynamicSetupScreens', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[DynamicSetupScreens] ([DynamicSetupScreenID], [ScreenName], [DS_TableName], [DS_Title], [DS_AllowAddEdit], [DS_AllowPreview], [DS_AllowSearchFilter], [DS_AllowListingGrid], [DS_GridColumns], [DS_AllowDelete], [DS_AllowEdit], [DS_ExcludeAddEditColumns], [DS_ExcludeSearchColumns], [DS_ShowAddNewButton], [DS_GridTitle], [DS_OrderBy], [DS_DoNotRenderJavaScript], [DS_ExtenderName], [DS_DontLoadRecursiveData], [DS_AllowImport], [DS_ParentColumnNameForRecursiveGrid], [DS_RecordsPerPage], [DS_ImportURL], [DS_ManualCrud], [DS_Filters], [DS_DisableSorting], [DS_ShowHistory], [DS_IsMenuNavigation], [DS_SecondaryTableConfigs], [DS_CustomJavaScript], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (2, N'User Types', N'UserTypes', N'Manage User Types', 1, 0, 1, 1, NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, NULL, 0, NULL, 0, 0, 0, NULL, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[DynamicSetupScreens] ([DynamicSetupScreenID], [ScreenName], [DS_TableName], [DS_Title], [DS_AllowAddEdit], [DS_AllowPreview], [DS_AllowSearchFilter], [DS_AllowListingGrid], [DS_GridColumns], [DS_AllowDelete], [DS_AllowEdit], [DS_ExcludeAddEditColumns], [DS_ExcludeSearchColumns], [DS_ShowAddNewButton], [DS_GridTitle], [DS_OrderBy], [DS_DoNotRenderJavaScript], [DS_ExtenderName], [DS_DontLoadRecursiveData], [DS_AllowImport], [DS_ParentColumnNameForRecursiveGrid], [DS_RecordsPerPage], [DS_ImportURL], [DS_ManualCrud], [DS_Filters], [DS_DisableSorting], [DS_ShowHistory], [DS_IsMenuNavigation], [DS_SecondaryTableConfigs], [DS_CustomJavaScript], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (3, N'Roles', N'Roles', N'Manage Roles', 1, 0, 1, 1, NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, NULL, 0, NULL, 0, 0, 0, NULL, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[DynamicSetupScreens] ([DynamicSetupScreenID], [ScreenName], [DS_TableName], [DS_Title], [DS_AllowAddEdit], [DS_AllowPreview], [DS_AllowSearchFilter], [DS_AllowListingGrid], [DS_GridColumns], [DS_AllowDelete], [DS_AllowEdit], [DS_ExcludeAddEditColumns], [DS_ExcludeSearchColumns], [DS_ShowAddNewButton], [DS_GridTitle], [DS_OrderBy], [DS_DoNotRenderJavaScript], [DS_ExtenderName], [DS_DontLoadRecursiveData], [DS_AllowImport], [DS_ParentColumnNameForRecursiveGrid], [DS_RecordsPerPage], [DS_ImportURL], [DS_ManualCrud], [DS_Filters], [DS_DisableSorting], [DS_ShowHistory], [DS_IsMenuNavigation], [DS_SecondaryTableConfigs], [DS_CustomJavaScript], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (4, N'Rights', N'Rights', N'Manage Rights', 1, 0, 1, 1, NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, NULL, 0, NULL, 0, 0, 0, NULL, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[DynamicSetupScreens] ([DynamicSetupScreenID], [ScreenName], [DS_TableName], [DS_Title], [DS_AllowAddEdit], [DS_AllowPreview], [DS_AllowSearchFilter], [DS_AllowListingGrid], [DS_GridColumns], [DS_AllowDelete], [DS_AllowEdit], [DS_ExcludeAddEditColumns], [DS_ExcludeSearchColumns], [DS_ShowAddNewButton], [DS_GridTitle], [DS_OrderBy], [DS_DoNotRenderJavaScript], [DS_ExtenderName], [DS_DontLoadRecursiveData], [DS_AllowImport], [DS_ParentColumnNameForRecursiveGrid], [DS_RecordsPerPage], [DS_ImportURL], [DS_ManualCrud], [DS_Filters], [DS_DisableSorting], [DS_ShowHistory], [DS_IsMenuNavigation], [DS_SecondaryTableConfigs], [DS_CustomJavaScript], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (5, N'User Roles', N'UserRoles', N'Manage Users Roles', 1, 0, 1, 1, NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, NULL, 0, NULL, 0, 0, 0, NULL, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[DynamicSetupScreens] ([DynamicSetupScreenID], [ScreenName], [DS_TableName], [DS_Title], [DS_AllowAddEdit], [DS_AllowPreview], [DS_AllowSearchFilter], [DS_AllowListingGrid], [DS_GridColumns], [DS_AllowDelete], [DS_AllowEdit], [DS_ExcludeAddEditColumns], [DS_ExcludeSearchColumns], [DS_ShowAddNewButton], [DS_GridTitle], [DS_OrderBy], [DS_DoNotRenderJavaScript], [DS_ExtenderName], [DS_DontLoadRecursiveData], [DS_AllowImport], [DS_ParentColumnNameForRecursiveGrid], [DS_RecordsPerPage], [DS_ImportURL], [DS_ManualCrud], [DS_Filters], [DS_DisableSorting], [DS_ShowHistory], [DS_IsMenuNavigation], [DS_SecondaryTableConfigs], [DS_CustomJavaScript], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (6, N'Users', N'Users', N'Manage Users', 1, 0, 1, 1, NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, NULL, 0, NULL, 0, 0, 0, NULL, NULL, NULL, 1, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[DynamicSetupScreens] OFF
GO
SET IDENTITY_INSERT [dbo].[Entities] ON 
GO
INSERT [dbo].[Entities] ([EntityID], [NameEn], [DataVersion], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (1, N'UserTypes', 1, 1, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Entities] ([EntityID], [NameEn], [DataVersion], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (2, N'Roles', 1, 1, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Entities] ([EntityID], [NameEn], [DataVersion], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (3, N'Rights', 1, 1, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Entities] ([EntityID], [NameEn], [DataVersion], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (4, N'UserRoles', 1, 1, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Entities] ([EntityID], [NameEn], [DataVersion], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (5, N'Users', 1, 1, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[Entities] ([EntityID], [NameEn], [DataVersion], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (6, N'RoleRights', 1, 1, NULL, 1, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Entities] OFF
GO
SET IDENTITY_INSERT [dbo].[EntityDetails] ON 
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (1, 1, N'UserTypeID', N'UserTypeID', N'UserTypeID', 52, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 2, 1, 1, 0, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (2, 1, N'TypeName', N'TypeName', N'TypeName', 231, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 100, 0, 0, 0, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (3, 1, N'IsActive', N'IsActive', N'IsActive', 104, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (4, 1, N'CreatedOn', N'CreatedOn', N'CreatedOn', 61, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 8, 1, 0, 0, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (5, 1, N'CreatedBy', N'CreatedBy', N'CreatedBy', 56, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 0, 0, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (6, 1, N'ModifiedOn', N'ModifiedOn', N'ModifiedOn', 61, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 8, 1, 0, 0, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (7, 1, N'ModifiedBy', N'ModifiedBy', N'ModifiedBy', 56, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 0, 0, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (8, 2, N'RoleID', N'RoleID', N'RoleID', 52, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 2, 0, 1, 0, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (9, 2, N'RoleName', N'RoleName', N'RoleName', 231, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 100, 0, 0, 0, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (10, 2, N'IsActive', N'IsActive', N'IsActive', 104, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (11, 3, N'RightID', N'RightID', N'RightID', 52, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 2, 0, 1, 0, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (12, 3, N'RightName', N'RightName', N'RightName', 231, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 100, 0, 0, 0, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (13, 3, N'IsActive', N'IsActive', N'IsActive', 104, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (14, 4, N'UserRoleID', N'UserRoleID', N'UserRoleID', 56, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 1, 0, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (15, 4, N'UserID', N'UserID', N'UserID', 56, 1, 0, NULL, NULL, 1, N'Users', 0, NULL, NULL, NULL, 0, 0, 0, 4, 0, 0, 0, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (16, 4, N'RoleID', N'RoleID', N'RoleID', 52, 1, 0, NULL, NULL, 1, N'Roles', 0, NULL, NULL, NULL, 0, 0, 0, 2, 0, 0, 0, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (17, 4, N'CreatedOn', N'CreatedOn', N'CreatedOn', 61, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 8, 1, 0, 0, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (18, 4, N'CreatedBy', N'CreatedBy', N'CreatedBy', 56, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 0, 0, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (19, 4, N'ModifiedOn', N'ModifiedOn', N'ModifiedOn', 61, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 8, 1, 0, 0, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (20, 4, N'ModifiedBy', N'ModifiedBy', N'ModifiedBy', 56, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 0, 0, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (21, 5, N'UserID', N'UserID', N'UserID', 56, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 1, 0, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (22, 5, N'UserTypeID', N'UserTypeID', N'UserTypeID', 52, 0, 0, NULL, NULL, 1, N'UserTypes', 0, NULL, NULL, NULL, 0, 0, 0, 2, 0, 0, 0, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (23, 5, N'FullName', N'FullName', N'FullName', 231, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 512, 0, 0, 0, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (24, 5, N'DisplayName', N'DisplayName', N'DisplayName', 231, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 64, 0, 0, 0, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (25, 5, N'Email', N'Email', N'Email', 231, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 512, 0, 0, 0, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (26, 5, N'Password', N'Password', N'Password', 231, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 512, 0, 0, 0, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (27, 5, N'PictureID', N'PictureID', N'PictureID', 56, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 0, 0, 0, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (28, 5, N'PictureURL', N'PictureURL', N'PictureURL', 231, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 2048, 0, 0, 0, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (29, 5, N'MobileNo', N'MobileNo', N'MobileNo', 231, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 64, 0, 0, 0, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (30, 5, N'RecordStatus', N'RecordStatus', N'RecordStatus', 52, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 2, 0, 0, 0, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (31, 5, N'CreatedOn', N'CreatedOn', N'CreatedOn', 61, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 8, 1, 0, 0, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (32, 5, N'ModifiedOn', N'ModifiedOn', N'ModifiedOn', 61, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 8, 1, 0, 0, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (33, 6, N'RoleRightID', N'RoleRightID', N'RoleRightID', 56, 1, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 4, 1, 1, 0, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (34, 6, N'RoleID', N'RoleID', N'RoleID', 52, 1, 0, NULL, NULL, 1, N'Roles', 0, NULL, NULL, NULL, 0, 0, 0, 2, 0, 0, 0, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (35, 6, N'RightID', N'RightID', N'RightID', 52, 1, 0, NULL, NULL, 1, N'Rights', 0, NULL, NULL, NULL, 0, 0, 0, 2, 0, 0, 0, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (36, 6, N'EntityID', N'EntityID', N'EntityID', 52, 1, 0, NULL, NULL, 1, N'Entities', 0, NULL, NULL, NULL, 0, 0, 0, 2, 0, 0, 0, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (37, 6, N'CreatedOn', N'CreatedOn', N'CreatedOn', 239, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 20, 1, 0, 0, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (38, 6, N'CreatedBy', N'CreatedBy', N'CreatedBy', 239, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 20, 1, 0, 0, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (39, 6, N'ModifiedOn', N'ModifiedOn', N'ModifiedOn', 239, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 20, 1, 0, 0, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[EntityDetails] ([EntityDetailsID], [EntityID], [ColumnName], [DisplayNameEn], [DisplayNameAr], [DbTypeID], [IsRequired], [IsGroup], [ParentSubGroupID], [ParentEntityDetailsID], [IsForeignkey], [RefrencedTableName], [EnableAutoComplate], [AutoCompleteSourceQuery], [IsDigit], [ValidationExpression], [AddEditVisible], [GridVisible], [SearchFilterVisible], [MaxLength], [IsAutoID], [IsPrimaryKey], [DisplaySeqNo], [IsFileUpload], [AllowedFiles], [ShowGroupTitle], [PlaceHolderText], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (40, 6, N'ModifiedBy', N'ModifiedBy', N'ModifiedBy', 239, 0, 0, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 20, 1, 0, 0, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[EntityDetails] OFF
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
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (365, 3, 1, 3, CAST(N'2019-07-06T05:45:00.843' AS DateTime), 1, CAST(N'2019-07-06T05:45:00.843' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (366, 3, 1, 2, CAST(N'2019-07-06T05:45:00.847' AS DateTime), 1, CAST(N'2019-07-06T05:45:00.847' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (367, 3, 1, 6, CAST(N'2019-07-06T05:45:00.847' AS DateTime), 1, CAST(N'2019-07-06T05:45:00.847' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (368, 3, 1, 5, CAST(N'2019-07-06T05:45:00.847' AS DateTime), 1, CAST(N'2019-07-06T05:45:00.847' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (369, 3, 1, 4, CAST(N'2019-07-06T05:45:00.847' AS DateTime), 1, CAST(N'2019-07-06T05:45:00.847' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (370, 3, 1, 1, CAST(N'2019-07-06T05:45:00.847' AS DateTime), 1, CAST(N'2019-07-06T05:45:00.847' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (371, 3, 3, 3, CAST(N'2019-07-06T05:45:00.847' AS DateTime), 1, CAST(N'2019-07-06T05:45:00.847' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (372, 3, 3, 2, CAST(N'2019-07-06T05:45:00.847' AS DateTime), 1, CAST(N'2019-07-06T05:45:00.847' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (373, 3, 3, 6, CAST(N'2019-07-06T05:45:00.847' AS DateTime), 1, CAST(N'2019-07-06T05:45:00.847' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (374, 3, 3, 5, CAST(N'2019-07-06T05:45:00.847' AS DateTime), 1, CAST(N'2019-07-06T05:45:00.847' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (375, 3, 3, 4, CAST(N'2019-07-06T05:45:00.847' AS DateTime), 1, CAST(N'2019-07-06T05:45:00.847' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (376, 3, 3, 1, CAST(N'2019-07-06T05:45:00.847' AS DateTime), 1, CAST(N'2019-07-06T05:45:00.847' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (377, 3, 2, 3, CAST(N'2019-07-06T05:45:00.847' AS DateTime), 1, CAST(N'2019-07-06T05:45:00.847' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (378, 3, 2, 2, CAST(N'2019-07-06T05:45:00.847' AS DateTime), 1, CAST(N'2019-07-06T05:45:00.847' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (379, 3, 2, 6, CAST(N'2019-07-06T05:45:00.847' AS DateTime), 1, CAST(N'2019-07-06T05:45:00.847' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (380, 3, 2, 5, CAST(N'2019-07-06T05:45:00.850' AS DateTime), 1, CAST(N'2019-07-06T05:45:00.850' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (381, 3, 2, 4, CAST(N'2019-07-06T05:45:00.850' AS DateTime), 1, CAST(N'2019-07-06T05:45:00.850' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (382, 3, 2, 1, CAST(N'2019-07-06T05:45:00.850' AS DateTime), 1, CAST(N'2019-07-06T05:45:00.850' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (383, 3, 5, 3, CAST(N'2019-07-06T05:45:00.850' AS DateTime), 1, CAST(N'2019-07-06T05:45:00.850' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (384, 3, 5, 2, CAST(N'2019-07-06T05:45:00.850' AS DateTime), 1, CAST(N'2019-07-06T05:45:00.850' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (385, 3, 5, 6, CAST(N'2019-07-06T05:45:00.850' AS DateTime), 1, CAST(N'2019-07-06T05:45:00.850' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (386, 3, 5, 5, CAST(N'2019-07-06T05:45:00.850' AS DateTime), 1, CAST(N'2019-07-06T05:45:00.850' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (387, 3, 5, 4, CAST(N'2019-07-06T05:45:00.850' AS DateTime), 1, CAST(N'2019-07-06T05:45:00.850' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (388, 3, 5, 1, CAST(N'2019-07-06T05:45:00.850' AS DateTime), 1, CAST(N'2019-07-06T05:45:00.850' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (389, 3, 4, 3, CAST(N'2019-07-06T05:45:00.850' AS DateTime), 1, CAST(N'2019-07-06T05:45:00.850' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (390, 2, 1, 3, CAST(N'2019-07-06T05:45:57.783' AS DateTime), 1, CAST(N'2019-07-06T05:45:57.783' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (391, 2, 1, 2, CAST(N'2019-07-06T05:45:57.783' AS DateTime), 1, CAST(N'2019-07-06T05:45:57.783' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (392, 2, 1, 6, CAST(N'2019-07-06T05:45:57.783' AS DateTime), 1, CAST(N'2019-07-06T05:45:57.783' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (393, 2, 1, 5, CAST(N'2019-07-06T05:45:57.783' AS DateTime), 1, CAST(N'2019-07-06T05:45:57.783' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (394, 2, 1, 4, CAST(N'2019-07-06T05:45:57.787' AS DateTime), 1, CAST(N'2019-07-06T05:45:57.787' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (395, 2, 1, 1, CAST(N'2019-07-06T05:45:57.787' AS DateTime), 1, CAST(N'2019-07-06T05:45:57.787' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (396, 2, 3, 3, CAST(N'2019-07-06T05:45:57.787' AS DateTime), 1, CAST(N'2019-07-06T05:45:57.787' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (397, 2, 3, 2, CAST(N'2019-07-06T05:45:57.787' AS DateTime), 1, CAST(N'2019-07-06T05:45:57.787' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (398, 2, 3, 6, CAST(N'2019-07-06T05:45:57.787' AS DateTime), 1, CAST(N'2019-07-06T05:45:57.787' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (399, 2, 3, 5, CAST(N'2019-07-06T05:45:57.787' AS DateTime), 1, CAST(N'2019-07-06T05:45:57.787' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (400, 2, 3, 4, CAST(N'2019-07-06T05:45:57.787' AS DateTime), 1, CAST(N'2019-07-06T05:45:57.787' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (401, 2, 3, 1, CAST(N'2019-07-06T05:45:57.787' AS DateTime), 1, CAST(N'2019-07-06T05:45:57.787' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (402, 2, 2, 3, CAST(N'2019-07-06T05:45:57.787' AS DateTime), 1, CAST(N'2019-07-06T05:45:57.787' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (403, 2, 2, 2, CAST(N'2019-07-06T05:45:57.787' AS DateTime), 1, CAST(N'2019-07-06T05:45:57.787' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (404, 2, 2, 6, CAST(N'2019-07-06T05:45:57.787' AS DateTime), 1, CAST(N'2019-07-06T05:45:57.787' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (405, 2, 2, 5, CAST(N'2019-07-06T05:45:57.787' AS DateTime), 1, CAST(N'2019-07-06T05:45:57.787' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (406, 2, 2, 4, CAST(N'2019-07-06T05:45:57.790' AS DateTime), 1, CAST(N'2019-07-06T05:45:57.790' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (407, 2, 2, 1, CAST(N'2019-07-06T05:45:57.790' AS DateTime), 1, CAST(N'2019-07-06T05:45:57.790' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (408, 2, 5, 3, CAST(N'2019-07-06T05:45:57.790' AS DateTime), 1, CAST(N'2019-07-06T05:45:57.790' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (409, 2, 5, 2, CAST(N'2019-07-06T05:45:57.790' AS DateTime), 1, CAST(N'2019-07-06T05:45:57.790' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (410, 2, 5, 6, CAST(N'2019-07-06T05:45:57.790' AS DateTime), 1, CAST(N'2019-07-06T05:45:57.790' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (411, 2, 5, 5, CAST(N'2019-07-06T05:45:57.790' AS DateTime), 1, CAST(N'2019-07-06T05:45:57.790' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (412, 2, 5, 4, CAST(N'2019-07-06T05:45:57.790' AS DateTime), 1, CAST(N'2019-07-06T05:45:57.790' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (413, 2, 5, 1, CAST(N'2019-07-06T05:45:57.790' AS DateTime), 1, CAST(N'2019-07-06T05:45:57.790' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (414, 2, 4, 3, CAST(N'2019-07-06T05:45:57.790' AS DateTime), 1, CAST(N'2019-07-06T05:45:57.790' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (415, 2, 4, 2, CAST(N'2019-07-06T05:45:57.790' AS DateTime), 1, CAST(N'2019-07-06T05:45:57.790' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (446, 4, 1, 3, CAST(N'2019-07-06T05:56:30.063' AS DateTime), 1, CAST(N'2019-07-06T05:56:30.063' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (447, 4, 1, 2, CAST(N'2019-07-06T05:56:30.070' AS DateTime), 1, CAST(N'2019-07-06T05:56:30.070' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (448, 4, 1, 6, CAST(N'2019-07-06T05:56:30.070' AS DateTime), 1, CAST(N'2019-07-06T05:56:30.070' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (449, 4, 1, 5, CAST(N'2019-07-06T05:56:30.070' AS DateTime), 1, CAST(N'2019-07-06T05:56:30.070' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (450, 4, 1, 4, CAST(N'2019-07-06T05:56:30.070' AS DateTime), 1, CAST(N'2019-07-06T05:56:30.070' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (451, 4, 1, 1, CAST(N'2019-07-06T05:56:30.070' AS DateTime), 1, CAST(N'2019-07-06T05:56:30.070' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (452, 4, 3, 3, CAST(N'2019-07-06T05:56:30.070' AS DateTime), 1, CAST(N'2019-07-06T05:56:30.070' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (453, 4, 3, 2, CAST(N'2019-07-06T05:56:30.073' AS DateTime), 1, CAST(N'2019-07-06T05:56:30.073' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (454, 4, 3, 6, CAST(N'2019-07-06T05:56:30.073' AS DateTime), 1, CAST(N'2019-07-06T05:56:30.073' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (455, 4, 3, 5, CAST(N'2019-07-06T05:56:30.073' AS DateTime), 1, CAST(N'2019-07-06T05:56:30.073' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (456, 4, 3, 4, CAST(N'2019-07-06T05:56:30.073' AS DateTime), 1, CAST(N'2019-07-06T05:56:30.073' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (457, 4, 3, 1, CAST(N'2019-07-06T05:56:30.073' AS DateTime), 1, CAST(N'2019-07-06T05:56:30.073' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (458, 4, 2, 3, CAST(N'2019-07-06T05:56:30.073' AS DateTime), 1, CAST(N'2019-07-06T05:56:30.073' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (459, 4, 2, 2, CAST(N'2019-07-06T05:56:30.073' AS DateTime), 1, CAST(N'2019-07-06T05:56:30.073' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (460, 4, 2, 6, CAST(N'2019-07-06T05:56:30.073' AS DateTime), 1, CAST(N'2019-07-06T05:56:30.073' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (461, 4, 2, 5, CAST(N'2019-07-06T05:56:30.073' AS DateTime), 1, CAST(N'2019-07-06T05:56:30.073' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (462, 4, 2, 4, CAST(N'2019-07-06T05:56:30.073' AS DateTime), 1, CAST(N'2019-07-06T05:56:30.073' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (463, 4, 2, 1, CAST(N'2019-07-06T05:56:30.073' AS DateTime), 1, CAST(N'2019-07-06T05:56:30.073' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (464, 4, 5, 3, CAST(N'2019-07-06T05:56:30.073' AS DateTime), 1, CAST(N'2019-07-06T05:56:30.073' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (465, 4, 5, 2, CAST(N'2019-07-06T05:56:30.073' AS DateTime), 1, CAST(N'2019-07-06T05:56:30.073' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (466, 4, 5, 6, CAST(N'2019-07-06T05:56:30.073' AS DateTime), 1, CAST(N'2019-07-06T05:56:30.073' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (467, 4, 5, 5, CAST(N'2019-07-06T05:56:30.073' AS DateTime), 1, CAST(N'2019-07-06T05:56:30.073' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (468, 4, 5, 4, CAST(N'2019-07-06T05:56:30.073' AS DateTime), 1, CAST(N'2019-07-06T05:56:30.073' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (469, 4, 5, 1, CAST(N'2019-07-06T05:56:30.073' AS DateTime), 1, CAST(N'2019-07-06T05:56:30.073' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (470, 4, 4, 3, CAST(N'2019-07-06T05:56:30.073' AS DateTime), 1, CAST(N'2019-07-06T05:56:30.073' AS DateTime), 1)
GO
INSERT [dbo].[RoleRights] ([RoleRightID], [RoleID], [RightID], [EntityID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (471, 4, 4, 2, CAST(N'2019-07-06T05:56:30.073' AS DateTime), 1, CAST(N'2019-07-06T05:56:30.073' AS DateTime), 1)
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
SET IDENTITY_INSERT [dbo].[UserRoles] ON 
GO
INSERT [dbo].[UserRoles] ([UserRoleID], [UserID], [RoleID], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (1, 1, 1, NULL, 1, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[UserRoles] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 
GO
INSERT [dbo].[Users] ([UserID], [UserTypeID], [FullName], [DisplayName], [Email], [Password], [PictureID], [PictureURL], [MobileNo], [RecordStatus], [CreatedOn], [ModifiedOn], [CreatedBy], [ModifiedBy]) VALUES (1, NULL, N'Ihsaas Trust', N'Ihsaas Trust', N'admin@ihsaastrust.com', N'BP0qaZXHfNc=', 0, NULL, NULL, 2, NULL, NULL, 1, NULL)
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET IDENTITY_INSERT [dbo].[UserTypes] ON 
GO
INSERT [dbo].[UserTypes] ([UserTypeID], [TypeName], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (1, N'FieldWorker', 1, CAST(N'2019-07-02T00:00:00.000' AS DateTime), 1, CAST(N'2019-07-02T17:20:22.000' AS DateTime), 1)
GO
INSERT [dbo].[UserTypes] ([UserTypeID], [TypeName], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (2, N'Committee', 1, CAST(N'2019-07-03T00:00:00.000' AS DateTime), 2, CAST(N'2019-07-03T01:25:10.000' AS DateTime), 1)
GO
SET IDENTITY_INSERT [dbo].[UserTypes] OFF
GO
/****** Object:  Index [PK114]    Script Date: 06/07/2019 4:59:10 PM ******/
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [PK114] PRIMARY KEY NONCLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AppConfigs] ADD  CONSTRAINT [DF_AppConfigs_IsEditableByUser]  DEFAULT ((0)) FOR [IsEditableByUser]
GO
ALTER TABLE [dbo].[Entities] ADD  CONSTRAINT [DF__Entities__DataVe__0F975522]  DEFAULT ((0)) FOR [DataVersion]
GO
ALTER TABLE [dbo].[EntityDetails] ADD  CONSTRAINT [DF_EntityDetails_IsFileUpload]  DEFAULT ((0)) FOR [IsFileUpload]
GO
ALTER TABLE [dbo].[EntityDetails] ADD  CONSTRAINT [DF_EntityDetails_ShowGroupTitle]  DEFAULT ((0)) FOR [ShowGroupTitle]
GO
ALTER TABLE [dbo].[UserTypes] ADD  CONSTRAINT [DF_UserTypes_IsActive]  DEFAULT ((1)) FOR [IsActive]
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
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_UserRoles_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[UserRoles] CHECK CONSTRAINT [FK_UserRoles_Users]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Users] FOREIGN KEY([UserTypeID])
REFERENCES [dbo].[UserTypes] ([UserTypeID])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Users]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1 = Applied For Registration, 2 = Active, 3 = Deactivated' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Users', @level2type=N'COLUMN',@level2name=N'RecordStatus'
GO
USE [master]
GO
ALTER DATABASE [IhsaasTrust] SET  READ_WRITE 
GO
