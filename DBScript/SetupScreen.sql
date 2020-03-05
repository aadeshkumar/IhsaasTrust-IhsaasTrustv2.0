GO
/****** Object:  Database [IhsaasTrust]    Script Date: 02/07/2019 5:34:44 PM ******/
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
/****** Object:  Table [dbo].[AppConfigs]    Script Date: 02/07/2019 5:34:44 PM ******/
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
/****** Object:  Table [dbo].[DynamicSetupScreens]    Script Date: 02/07/2019 5:34:44 PM ******/
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
 CONSTRAINT [PK_DynamicScreens] PRIMARY KEY CLUSTERED 
(
	[DynamicSetupScreenID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Entities]    Script Date: 02/07/2019 5:34:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Entities](
	[EntityID] [smallint] NOT NULL,
	[NameEn] [varchar](64) NOT NULL,
	[DataVersion] [int] NOT NULL,
 CONSTRAINT [PK4] PRIMARY KEY CLUSTERED 
(
	[EntityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EntityDetails]    Script Date: 02/07/2019 5:34:44 PM ******/
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
 CONSTRAINT [PK_EntityDetails] PRIMARY KEY CLUSTERED 
(
	[EntityDetailsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rights]    Script Date: 02/07/2019 5:34:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rights](
	[RightID] [smallint] NOT NULL,
	[RightName] [nvarchar](50) NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Rights] PRIMARY KEY CLUSTERED 
(
	[RightID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoleRights]    Script Date: 02/07/2019 5:34:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleRights](
	[RoleRightID] [int] IDENTITY(1,1) NOT NULL,
	[RoleID] [smallint] NOT NULL,
	[RightID] [smallint] NOT NULL,
	[EntityID] [smallint] NOT NULL,
	[CreatedOn] [nchar](10) NULL,
	[CreatedBy] [nchar](10) NULL,
	[ModifiedOn] [nchar](10) NULL,
	[ModifiedBy] [nchar](10) NULL,
 CONSTRAINT [PK_RoleRights] PRIMARY KEY CLUSTERED 
(
	[RoleRightID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 02/07/2019 5:34:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleID] [smallint] NOT NULL,
	[RoleName] [nvarchar](50) NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRoles]    Script Date: 02/07/2019 5:34:44 PM ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 02/07/2019 5:34:44 PM ******/
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
	[ModifiedOn] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserTypes]    Script Date: 02/07/2019 5:34:44 PM ******/
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
INSERT [dbo].[DynamicSetupScreens] ([DynamicSetupScreenID], [ScreenName], [DS_TableName], [DS_Title], [DS_AllowAddEdit], [DS_AllowPreview], [DS_AllowSearchFilter], [DS_AllowListingGrid], [DS_GridColumns], [DS_AllowDelete], [DS_AllowEdit], [DS_ExcludeAddEditColumns], [DS_ExcludeSearchColumns], [DS_ShowAddNewButton], [DS_GridTitle], [DS_OrderBy], [DS_DoNotRenderJavaScript], [DS_ExtenderName], [DS_DontLoadRecursiveData], [DS_AllowImport], [DS_ParentColumnNameForRecursiveGrid], [DS_RecordsPerPage], [DS_ImportURL], [DS_ManualCrud], [DS_Filters], [DS_DisableSorting], [DS_ShowHistory], [DS_IsMenuNavigation], [DS_SecondaryTableConfigs], [DS_CustomJavaScript]) VALUES (1, N'Dynamic Screen Setup', N'DynamicSetupScreens', N'DynamicSetupScreens', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL)
GO
INSERT [dbo].[DynamicSetupScreens] ([DynamicSetupScreenID], [ScreenName], [DS_TableName], [DS_Title], [DS_AllowAddEdit], [DS_AllowPreview], [DS_AllowSearchFilter], [DS_AllowListingGrid], [DS_GridColumns], [DS_AllowDelete], [DS_AllowEdit], [DS_ExcludeAddEditColumns], [DS_ExcludeSearchColumns], [DS_ShowAddNewButton], [DS_GridTitle], [DS_OrderBy], [DS_DoNotRenderJavaScript], [DS_ExtenderName], [DS_DontLoadRecursiveData], [DS_AllowImport], [DS_ParentColumnNameForRecursiveGrid], [DS_RecordsPerPage], [DS_ImportURL], [DS_ManualCrud], [DS_Filters], [DS_DisableSorting], [DS_ShowHistory], [DS_IsMenuNavigation], [DS_SecondaryTableConfigs], [DS_CustomJavaScript]) VALUES (2, N'User Types', N'UserTypes', N'Manage User Types', 1, 0, 1, 1, NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, NULL, 0, NULL, 0, 0, 0, NULL, NULL)
GO
INSERT [dbo].[DynamicSetupScreens] ([DynamicSetupScreenID], [ScreenName], [DS_TableName], [DS_Title], [DS_AllowAddEdit], [DS_AllowPreview], [DS_AllowSearchFilter], [DS_AllowListingGrid], [DS_GridColumns], [DS_AllowDelete], [DS_AllowEdit], [DS_ExcludeAddEditColumns], [DS_ExcludeSearchColumns], [DS_ShowAddNewButton], [DS_GridTitle], [DS_OrderBy], [DS_DoNotRenderJavaScript], [DS_ExtenderName], [DS_DontLoadRecursiveData], [DS_AllowImport], [DS_ParentColumnNameForRecursiveGrid], [DS_RecordsPerPage], [DS_ImportURL], [DS_ManualCrud], [DS_Filters], [DS_DisableSorting], [DS_ShowHistory], [DS_IsMenuNavigation], [DS_SecondaryTableConfigs], [DS_CustomJavaScript]) VALUES (3, N'Roles', N'Roles', N'Manage Roles', 1, 0, 1, 1, NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, NULL, 0, NULL, 0, 0, 0, NULL, NULL)
GO
INSERT [dbo].[DynamicSetupScreens] ([DynamicSetupScreenID], [ScreenName], [DS_TableName], [DS_Title], [DS_AllowAddEdit], [DS_AllowPreview], [DS_AllowSearchFilter], [DS_AllowListingGrid], [DS_GridColumns], [DS_AllowDelete], [DS_AllowEdit], [DS_ExcludeAddEditColumns], [DS_ExcludeSearchColumns], [DS_ShowAddNewButton], [DS_GridTitle], [DS_OrderBy], [DS_DoNotRenderJavaScript], [DS_ExtenderName], [DS_DontLoadRecursiveData], [DS_AllowImport], [DS_ParentColumnNameForRecursiveGrid], [DS_RecordsPerPage], [DS_ImportURL], [DS_ManualCrud], [DS_Filters], [DS_DisableSorting], [DS_ShowHistory], [DS_IsMenuNavigation], [DS_SecondaryTableConfigs], [DS_CustomJavaScript]) VALUES (4, N'Rights', N'Rights', N'Manage Rights', 1, 0, 1, 1, NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, NULL, 0, NULL, 0, 0, 0, NULL, NULL)
GO
INSERT [dbo].[DynamicSetupScreens] ([DynamicSetupScreenID], [ScreenName], [DS_TableName], [DS_Title], [DS_AllowAddEdit], [DS_AllowPreview], [DS_AllowSearchFilter], [DS_AllowListingGrid], [DS_GridColumns], [DS_AllowDelete], [DS_AllowEdit], [DS_ExcludeAddEditColumns], [DS_ExcludeSearchColumns], [DS_ShowAddNewButton], [DS_GridTitle], [DS_OrderBy], [DS_DoNotRenderJavaScript], [DS_ExtenderName], [DS_DontLoadRecursiveData], [DS_AllowImport], [DS_ParentColumnNameForRecursiveGrid], [DS_RecordsPerPage], [DS_ImportURL], [DS_ManualCrud], [DS_Filters], [DS_DisableSorting], [DS_ShowHistory], [DS_IsMenuNavigation], [DS_SecondaryTableConfigs], [DS_CustomJavaScript]) VALUES (5, N'User Roles', N'UserRoles', N'Manage Users Roles', 1, 0, 1, 1, NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, NULL, 0, NULL, 0, 0, 0, NULL, NULL)
GO
INSERT [dbo].[DynamicSetupScreens] ([DynamicSetupScreenID], [ScreenName], [DS_TableName], [DS_Title], [DS_AllowAddEdit], [DS_AllowPreview], [DS_AllowSearchFilter], [DS_AllowListingGrid], [DS_GridColumns], [DS_AllowDelete], [DS_AllowEdit], [DS_ExcludeAddEditColumns], [DS_ExcludeSearchColumns], [DS_ShowAddNewButton], [DS_GridTitle], [DS_OrderBy], [DS_DoNotRenderJavaScript], [DS_ExtenderName], [DS_DontLoadRecursiveData], [DS_AllowImport], [DS_ParentColumnNameForRecursiveGrid], [DS_RecordsPerPage], [DS_ImportURL], [DS_ManualCrud], [DS_Filters], [DS_DisableSorting], [DS_ShowHistory], [DS_IsMenuNavigation], [DS_SecondaryTableConfigs], [DS_CustomJavaScript]) VALUES (6, N'Users', N'Users', N'Manage Users', 1, 0, 1, 1, NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 0, NULL, NULL, NULL, 0, NULL, 0, 0, 0, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[DynamicSetupScreens] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 
GO
INSERT [dbo].[Users] ([UserID], [UserTypeID], [FullName], [DisplayName], [Email], [Password], [PictureID], [PictureURL], [MobileNo], [RecordStatus], [CreatedOn], [ModifiedOn]) VALUES (1, NULL, N'Ihsaas Trust', N'Ihsaas Trust', N'admin@ihsaastrust.com', N'BP0qaZXHfNc=', 0, NULL, NULL, 2, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET IDENTITY_INSERT [dbo].[UserTypes] ON 
GO
INSERT [dbo].[UserTypes] ([UserTypeID], [TypeName], [IsActive], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (1, N'FieldWorker', 1, CAST(N'2019-07-02T00:00:00.000' AS DateTime), 1, CAST(N'2019-07-02T17:20:22.000' AS DateTime), 1)
GO
SET IDENTITY_INSERT [dbo].[UserTypes] OFF
GO
/****** Object:  Index [PK114]    Script Date: 02/07/2019 5:34:44 PM ******/
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
ALTER TABLE [dbo].[Entities]  WITH CHECK ADD  CONSTRAINT [FK_Entities_Entities] FOREIGN KEY([EntityID])
REFERENCES [dbo].[Entities] ([EntityID])
GO
ALTER TABLE [dbo].[Entities] CHECK CONSTRAINT [FK_Entities_Entities]
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
