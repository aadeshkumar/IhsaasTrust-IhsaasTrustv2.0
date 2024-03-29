
// This file was automatically generated by the PetaPoco T4 Template
// Do not make changes directly to this file - edit the template instead
// 
// The following connection settings were used to generate this file
// 
//     Connection String Name: `FrameworkConnection`
//     Provider:               `System.Data.SqlClient`
//     Connection String:      `Server=localhost;Database=IhsaasDB;uid=sa;pwd=123456;`
//     Schema:                 ``
//     Include Views:          `False`



using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using PetaPoco;

namespace Framework.Shared.DataServices
{
	public partial class FrameworkRepository : Database
	{
		public FrameworkRepository() 
			: base("FrameworkConnection")
		{
			CommonConstruct();
		}

		public FrameworkRepository(string connectionStringName) 
			: base(connectionStringName)
		{
			CommonConstruct();
		}
		
		partial void CommonConstruct();
		
		public interface IFactory
		{
			FrameworkRepository GetInstance();
		}
		
		public static IFactory Factory { get; set; }
        public static FrameworkRepository GetInstance()
        {
			if (_instance!=null)
				return _instance;
				
			if (Factory!=null)
				return Factory.GetInstance();
			else
				return new FrameworkRepository();
        }

		[ThreadStatic] static FrameworkRepository _instance;
		
		public override void OnBeginTransaction()
		{
			if (_instance==null)
				_instance=this;
		}
		
		public override void OnEndTransaction()
		{
			if (_instance==this)
				_instance=null;
		}
        
		public class Record<T> where T:new()
		{
			public static FrameworkRepository repo { get { return FrameworkRepository.GetInstance(); } }
			public bool IsNew() { return repo.IsNew(this); }
			public object Insert() { return repo.Insert(this); }
			public void Save() { repo.Save(this); }
			public int Update() { return repo.Update(this); }
			public int Update(IEnumerable<string> columns) { return repo.Update(this, columns); }
			public static int Update(string sql, params object[] args) { return repo.Update<T>(sql, args); }
			public static int Update(Sql sql) { return repo.Update<T>(sql); }
			public int Delete() { return repo.Delete(this); }
			public static int Delete(string sql, params object[] args) { return repo.Delete<T>(sql, args); }
			public static int Delete(Sql sql) { return repo.Delete<T>(sql); }
			public static int Delete(object primaryKey) { return repo.Delete<T>(primaryKey); }
			public static bool Exists(object primaryKey) { return repo.Exists<T>(primaryKey); }
			public static bool Exists(string sql, params object[] args) { return repo.Exists<T>(sql, args); }
			public static T SingleOrDefault(object primaryKey) { return repo.SingleOrDefault<T>(primaryKey); }
			public static T SingleOrDefault(string sql, params object[] args) { return repo.SingleOrDefault<T>(sql, args); }
			public static T SingleOrDefault(Sql sql) { return repo.SingleOrDefault<T>(sql); }
			public static T FirstOrDefault(string sql, params object[] args) { return repo.FirstOrDefault<T>(sql, args); }
			public static T FirstOrDefault(Sql sql) { return repo.FirstOrDefault<T>(sql); }
			public static T Single(object primaryKey) { return repo.Single<T>(primaryKey); }
			public static T Single(string sql, params object[] args) { return repo.Single<T>(sql, args); }
			public static T Single(Sql sql) { return repo.Single<T>(sql); }
			public static T First(string sql, params object[] args) { return repo.First<T>(sql, args); }
			public static T First(Sql sql) { return repo.First<T>(sql); }
			public static List<T> Fetch(string sql, params object[] args) { return repo.Fetch<T>(sql, args); }
			public static List<T> Fetch(Sql sql) { return repo.Fetch<T>(sql); }
			public static List<T> Fetch(long page, long itemsPerPage, string sql, params object[] args) { return repo.Fetch<T>(page, itemsPerPage, sql, args); }
			public static List<T> Fetch(long page, long itemsPerPage, Sql sql) { return repo.Fetch<T>(page, itemsPerPage, sql); }
			public static List<T> SkipTake(long skip, long take, string sql, params object[] args) { return repo.SkipTake<T>(skip, take, sql, args); }
			public static List<T> SkipTake(long skip, long take, Sql sql) { return repo.SkipTake<T>(skip, take, sql); }
			public static Page<T> Page(long page, long itemsPerPage, string sql, params object[] args) { return repo.Page<T>(page, itemsPerPage, sql, args); }
			public static Page<T> Page(long page, long itemsPerPage, Sql sql) { return repo.Page<T>(page, itemsPerPage, sql); }
			public static IEnumerable<T> Query(string sql, params object[] args) { return repo.Query<T>(sql, args); }
			public static IEnumerable<T> Query(Sql sql) { return repo.Query<T>(sql); }
		}
	}
	

    
	[TableName("OrganizationSubscription")]
	[PrimaryKey("OrganizationSubscriptionID")]
	[ExplicitColumns]
    public partial class OrganizationSubscription : FrameworkRepository.Record<OrganizationSubscription>  
    {
		[Column] public int OrganizationSubscriptionID { get; set; }		[Column] public int OrganizationID { get; set; }		[Column] public int SubscriptionPackageID { get; set; }		[Column] public DateTime? StartDate { get; set; }		[Column] public DateTime? EndDate { get; set; }		[Column] public int? UserCount { get; set; }		[Column] public bool? IsActive { get; set; }		[Column] public DateTime? CreatedOn { get; set; }		[Column] public int? CreatedBy { get; set; }		[Column] public DateTime? ModifiedOn { get; set; }		[Column] public int? ModifiedBy { get; set; }}
    
	[TableName("FieldValues")]
	[PrimaryKey("FieldValueID")]
	[ExplicitColumns]
    public partial class FieldValue : FrameworkRepository.Record<FieldValue>  
    {
		[Column] public int FieldValueID { get; set; }		[Column] public int ApplicationID { get; set; }		[Column] public int FieldID { get; set; }		[Column] public string Data { get; set; }		[Column] public DateTime? CreatedOn { get; set; }		[Column] public int? CreatedBy { get; set; }		[Column] public DateTime? ModifiedOn { get; set; }		[Column] public int? ModifiedBy { get; set; }}
    
	[TableName("Organizations")]
	[PrimaryKey("OrganizationID")]
	[ExplicitColumns]
    public partial class Organization : FrameworkRepository.Record<Organization>  
    {
		[Column] public int OrganizationID { get; set; }		[Column] public string OrganizationName { get; set; }		[Column] public int SubscriptionPackageID { get; set; }		[Column] public string Email { get; set; }		[Column] public long? PhoneNo { get; set; }		[Column] public long? MobileNo { get; set; }		[Column] public string Address { get; set; }		[Column] public int? NoOfBranches { get; set; }		[Column] public bool IsActive { get; set; }        [Column] public string Logo { get; set; }        [Column] public DateTime? CreatedOn { get; set; }		[Column] public int? CreatedBy { get; set; }		[Column] public DateTime? ModifiedOn { get; set; }		[Column] public int? ModifiedBy { get; set; }}
    
	[TableName("ApprovalHierarchies")]
	[PrimaryKey("ApprovalHierarchyID")]
	[ExplicitColumns]
    public partial class ApprovalHierarchy : FrameworkRepository.Record<ApprovalHierarchy>  
    {
		[Column] public int ApprovalHierarchyID { get; set; }		[Column] public int UserID { get; set; }		[Column] public short? ReportedTo { get; set; }		[Column] public int? EscalateTo { get; set; }		[Column] public bool? IsAllowToEscalate { get; set; }		[Column] public bool IsActive { get; set; }		[Column] public DateTime? CreatedOn { get; set; }		[Column] public int? CreatedBy { get; set; }		[Column] public DateTime? ModifiedOn { get; set; }		[Column] public int? ModifiedBy { get; set; }		[Column] public int? OrganizationID { get; set; }}
    
	[TableName("Applications")]
	[PrimaryKey("ApplicationID")]
	[ExplicitColumns]
    public partial class Application : FrameworkRepository.Record<Application>  
    {
		[Column] public int ApplicationID { get; set; }		[Column] public int OrganizationID { get; set; }		[Column] public string ApplicationCode { get; set; }		[Column] public DateTime Date { get; set; }		[Column] public bool IsActive { get; set; }		[Column] public DateTime? CreatedOn { get; set; }		[Column] public int? CreatedBy { get; set; }		[Column] public DateTime? ModifiedOn { get; set; }		[Column] public int? ModifiedBy { get; set; }		[Column] public int? AdminID { get; set; }}
    
	[TableName("UserRoles")]
	[PrimaryKey("UserRoleID")]
	[ExplicitColumns]
    public partial class UserRole : FrameworkRepository.Record<UserRole>  
    {
		[Column] public int UserRoleID { get; set; }		[Column] public int UserID { get; set; }		[Column] public int? OrganizationID { get; set; }		[Column] public short RoleID { get; set; }		[Column] public DateTime? CreatedOn { get; set; }		[Column] public int? CreatedBy { get; set; }		[Column] public DateTime? ModifiedOn { get; set; }		[Column] public int? ModifiedBy { get; set; }}
    
	[TableName("Users")]
	[PrimaryKey("UserID")]
	[ExplicitColumns]
    public partial class User : FrameworkRepository.Record<User>  
    {
		[Column] public int UserID { get; set; }		[Column] public int OrganizationID { get; set; }		[Column] public string FullName { get; set; }		[Column] public string DisplayName { get; set; }	[Column] public string Email { get; set; }		[Column] public string Password { get; set; }		[Column] public int? PictureID { get; set; }		[Column] public string PictureURL { get; set; }		[Column] public string MobileNo { get; set; }		[Column] public short? StatusID { get; set; }		[Column] public DateTime? CreatedOn { get; set; }		[Column] public DateTime? ModifiedOn { get; set; }		[Column] public int? CreatedBy { get; set; }		[Column] public int? ModifiedBy { get; set; }		[Column] public string RecipientEmail { get; set; }	}
    
	[TableName("Rights")]
	[PrimaryKey("RightID")]
	[ExplicitColumns]
    public partial class Right : FrameworkRepository.Record<Right>  
    {
		[Column] public short RightID { get; set; }		[Column] public string RightName { get; set; }		[Column] public bool IsActive { get; set; }		[Column] public DateTime? CreatedOn { get; set; }		[Column] public int? CreatedBy { get; set; }		[Column] public DateTime? ModifiedOn { get; set; }		[Column] public int? ModifiedBy { get; set; }}
    
	[TableName("RationAmounts")]
	[PrimaryKey("RationAmountID")]
	[ExplicitColumns]
    public partial class RationAmount : FrameworkRepository.Record<RationAmount>  
    {
		[Column] public short RationAmountID { get; set; }		[Column] public int OrganizationID { get; set; }		[Column] public int NoOfPerson { get; set; }		[Column] public int Amount { get; set; }		[Column] public bool IsActive { get; set; }		[Column] public DateTime? CreatedOn { get; set; }		[Column] public int? CreatedBy { get; set; }		[Column] public DateTime? ModifiedOn { get; set; }		[Column] public int? ModifiedBy { get; set; }}
    
	[TableName("SubscriptionRequests")]
	[PrimaryKey("SubscriptionRequestID")]
	[ExplicitColumns]
    public partial class SubscriptionRequest : FrameworkRepository.Record<SubscriptionRequest>  
    {
		[Column] public int SubscriptionRequestID { get; set; }		[Column] public int SubscriptionPackageID { get; set; }		[Column] public string RequestOrganizationName { get; set; }		[Column] public string RequestEmail { get; set; }		[Column] public long RequestPhoneNo { get; set; }		[Column] public long RequestMobileNo { get; set; }		[Column] public string RequestAddress { get; set; }		[Column] public int RequestNoOfBranches { get; set; }		[Column] public string Logo { get; set; }		[Column] public bool IsVerified { get; set; }		[Column] public DateTime? CreatedOn { get; set; }		[Column] public int? CreatedBy { get; set; }		[Column] public DateTime? ModifiedOn { get; set; }		[Column] public int? ModifiedBy { get; set; }}
    
	[TableName("Menus")]
	[PrimaryKey("MenuID")]
	[ExplicitColumns]
    public partial class Menu : FrameworkRepository.Record<Menu>  
    {
		[Column] public int MenuID { get; set; }		[Column] public int? ParentMenuID { get; set; }		[Column] public string MenuName { get; set; }		[Column] public string LinkUrl { get; set; }		[Column] public short? EntityID { get; set; }		[Column] public bool IsActive { get; set; }		[Column] public int? DisplaySeqNo { get; set; }		[Column] public DateTime? CreatedOn { get; set; }		[Column] public int? CreatedBy { get; set; }		[Column] public DateTime? ModifiedOn { get; set; }		[Column] public int? ModifiedBy { get; set; }		[Column] public string IconText { get; set; }}
    
	[TableName("EntityDetails")]
	[PrimaryKey("EntityDetailsID")]
	[ExplicitColumns]
    public partial class EntityDetail : FrameworkRepository.Record<EntityDetail>  
    {
		[Column] public int EntityDetailsID { get; set; }		[Column] public short EntityID { get; set; }		[Column] public string ColumnName { get; set; }		[Column] public string DisplayNameEn { get; set; }		[Column] public string DisplayNameAr { get; set; }		[Column] public short DbTypeID { get; set; }		[Column] public bool IsRequired { get; set; }		[Column] public bool? IsGroup { get; set; }		[Column] public int? ParentSubGroupID { get; set; }		[Column] public int? ParentEntityDetailsID { get; set; }		[Column] public bool IsForeignkey { get; set; }		[Column] public string RefrencedTableName { get; set; }		[Column] public bool EnableAutoComplate { get; set; }		[Column] public string AutoCompleteSourceQuery { get; set; }		[Column] public bool? IsDigit { get; set; }		[Column] public string ValidationExpression { get; set; }		[Column] public bool AddEditVisible { get; set; }		[Column] public bool GridVisible { get; set; }		[Column] public bool SearchFilterVisible { get; set; }		[Column] public short MaxLength { get; set; }		[Column] public bool IsAutoID { get; set; }		[Column] public bool IsPrimaryKey { get; set; }		[Column] public int? DisplaySeqNo { get; set; }		[Column] public bool? IsFileUpload { get; set; }		[Column] public string AllowedFiles { get; set; }		[Column] public bool ShowGroupTitle { get; set; }		[Column] public string PlaceHolderText { get; set; }		[Column] public DateTime? CreatedOn { get; set; }		[Column] public int? CreatedBy { get; set; }		[Column] public DateTime? ModifiedOn { get; set; }		[Column] public int? ModifiedBy { get; set; }}
    
	[TableName("Notifications")]
	[PrimaryKey("NotificationID")]
	[ExplicitColumns]
    public partial class Notification : FrameworkRepository.Record<Notification>  
    {
		[Column] public int NotificationID { get; set; }		[Column] public int ToUserID { get; set; }		[Column] public int CreatedBy { get; set; }		[Column] public string Body { get; set; }		[Column] public string Subject { get; set; }		[Column] public int IsRead { get; set; }        [Column] public int OrganizationID { get; set; }}
    
	[TableName("Approvals")]
	[PrimaryKey("ApprovalID")]
	[ExplicitColumns]
    public partial class Approval : FrameworkRepository.Record<Approval>  
    {
		[Column] public int ApprovalID { get; set; }        [Column] public int OrganizationID { get; set; }        [Column] public short EntityID { get; set; }		[Column] public int RowID { get; set; }		[Column] public short StatusID { get; set; }		[Column] public int UserID { get; set; }		[Column] public string Reason { get; set; }		[Column] public DateTime? CreatedOn { get; set; }		[Column] public int? CreatedBy { get; set; }		[Column] public DateTime? ModifiedOn { get; set; }		[Column] public int? ModifiedBy { get; set; }		[Column] public bool? IsEscalated { get; set; }		[Column] public bool? IsDeleted { get; set; }}
    
	[TableName("Roles")]
	[PrimaryKey("RoleID")]
	[ExplicitColumns]
    public partial class Role : FrameworkRepository.Record<Role>  
    {
		[Column] public short RoleID { get; set; }		[Column] public int? OrganizationID { get; set; }		[Column] public string RoleName { get; set; }		[Column] public bool IsActive { get; set; }		[Column] public DateTime? CreatedOn { get; set; }		[Column] public int? CreatedBy { get; set; }		[Column] public DateTime? ModifiedOn { get; set; }		[Column] public int? ModifiedBy { get; set; }}
    
	[TableName("UserOrganization")]
	[PrimaryKey("UserOrganizationID")]
	[ExplicitColumns]
    public partial class UserOrganization : FrameworkRepository.Record<UserOrganization>  
    {
		[Column] public int UserOrganizationID { get; set; }		[Column] public int UserID { get; set; }		[Column] public int OrganizationID { get; set; }		[Column] public bool IsActive { get; set; }		[Column] public DateTime? CreatedOn { get; set; }		[Column] public DateTime? ModifiedOn { get; set; }		[Column] public int? CreatedBy { get; set; }		[Column] public int? ModifiedBy { get; set; }}
    
	[TableName("SubscriptionPackages")]
	[PrimaryKey("SubscriptionPackageID")]
	[ExplicitColumns]
    public partial class SubscriptionPackage : FrameworkRepository.Record<SubscriptionPackage>  
    {
		[Column] public int SubscriptionPackageID { get; set; }		[Column] public string SubscriptionPackageName { get; set; }		[Column] public decimal Amount { get; set; }		[Column] public bool IsActive { get; set; }		[Column] public DateTime? CreatedOn { get; set; }		[Column] public int? CreatedBy { get; set; }		[Column] public DateTime? ModifiedOn { get; set; }		[Column] public int? ModifiedBy { get; set; }}
    
	[TableName("FieldTypes")]
	[PrimaryKey("FieldTypeID", autoIncrement=false)]
	[ExplicitColumns]
    public partial class FieldType : FrameworkRepository.Record<FieldType>  
    {
		[Column] public short FieldTypeID { get; set; }		[Column] public string FieldTypeName { get; set; }		[Column] public bool IsActive { get; set; }		[Column] public DateTime? CreatedOn { get; set; }		[Column] public int? CreatedBy { get; set; }		[Column] public DateTime? ModifiedOn { get; set; }		[Column] public int? ModifiedBy { get; set; }}
    
	[TableName("Fields")]
	[PrimaryKey("FieldID")]
	[ExplicitColumns]
    public partial class Field : FrameworkRepository.Record<Field>  
    {
		[Column] public int FieldID { get; set; }		[Column] public int OrganizationID { get; set; }		[Column] public int? ParentFieldID { get; set; }		[Column] public string FieldName { get; set; }		[Column] public short FieldTypeID { get; set; }		[Column] public string DisplayName { get; set; }		[Column] public bool IsRequired { get; set; }		[Column] public bool IsActive { get; set; }		[Column] public int DisplaySeqNo { get; set; }		[Column] public string Source { get; set; }		[Column] public DateTime? CreatedOn { get; set; }		[Column] public int? CreatedBy { get; set; }		[Column] public DateTime? ModifiedOn { get; set; }		[Column] public int? ModifiedBy { get; set; }		[Column] public bool? AllowToAdmin { get; set; }		[Column] public string OnChangeEvent { get; set; }		[Column] public string Condition { get; set; }}
    
	[TableName("AppConfigs")]
	[PrimaryKey("AppConfigKey", autoIncrement=false)]
	[ExplicitColumns]
    public partial class AppConfig : FrameworkRepository.Record<AppConfig>  
    {
		[Column] public string AppConfigKey { get; set; }		[Column] public string AppConfigValue { get; set; }		[Column] public bool IsEditableByUser { get; set; }		[Column] public string Description { get; set; }}
    
	[TableName("DynamicSetupScreens")]
	[PrimaryKey("DynamicSetupScreenID")]
	[ExplicitColumns]
    public partial class DynamicSetupScreen : FrameworkRepository.Record<DynamicSetupScreen>  
    {
		[Column] public int DynamicSetupScreenID { get; set; }		[Column] public string ScreenName { get; set; }		[Column] public string DS_TableName { get; set; }		[Column] public string DS_Title { get; set; }		[Column] public bool? DS_AllowAddEdit { get; set; }		[Column] public bool? DS_AllowPreview { get; set; }		[Column] public bool? DS_AllowSearchFilter { get; set; }		[Column] public bool? DS_AllowListingGrid { get; set; }		[Column] public string DS_GridColumns { get; set; }		[Column] public bool? DS_AllowDelete { get; set; }		[Column] public bool? DS_AllowEdit { get; set; }		[Column] public bool DS_AllowApprovals { get; set; }		[Column] public string DS_ExcludeAddEditColumns { get; set; }		[Column] public string DS_ExcludeSearchColumns { get; set; }		[Column] public string DS_ShowAddNewButton { get; set; }		[Column] public string DS_GridTitle { get; set; }		[Column] public string DS_OrderBy { get; set; }		[Column] public bool? DS_DoNotRenderJavaScript { get; set; }		[Column] public string DS_ExtenderName { get; set; }		[Column] public bool? DS_DontLoadRecursiveData { get; set; }		[Column] public bool? DS_AllowImport { get; set; }		[Column] public string DS_ParentColumnNameForRecursiveGrid { get; set; }		[Column] public int? DS_RecordsPerPage { get; set; }		[Column] public string DS_ImportURL { get; set; }		[Column] public bool? DS_ManualCrud { get; set; }		[Column] public string DS_Filters { get; set; }		[Column] public bool? DS_DisableSorting { get; set; }		[Column] public bool? DS_ShowHistory { get; set; }		[Column] public bool? DS_IsMenuNavigation { get; set; }		[Column] public string DS_SecondaryTableConfigs { get; set; }		[Column] public string DS_CustomJavaScript { get; set; }		[Column] public string DS_Condition { get; set; }		[Column] public DateTime? CreatedOn { get; set; }		[Column] public int? CreatedBy { get; set; }		[Column] public DateTime? ModifiedOn { get; set; }		[Column] public int? ModifiedBy { get; set; }		[Column] public string DS_CustomQuery { get; set; }}
    
	[TableName("Entities")]
	[PrimaryKey("EntityID", autoIncrement=false)]
	[ExplicitColumns]
    public partial class Entity : FrameworkRepository.Record<Entity>  
    {
		[Column] public short EntityID { get; set; }		[Column] public string NameEn { get; set; }		[Column] public int DataVersion { get; set; }		[Column] public bool IsActive { get; set; }		[Column] public DateTime? CreatedOn { get; set; }		[Column] public int? CreatedBy { get; set; }		[Column] public DateTime? ModifiedOn { get; set; }		[Column] public int? ModifiedBy { get; set; }		[Column] public string LinkUrl { get; set; }}
    
	[TableName("RoleRights")]
	[PrimaryKey("RoleRightID")]
	[ExplicitColumns]
    public partial class RoleRight : FrameworkRepository.Record<RoleRight>  
    {
		[Column] public int RoleRightID { get; set; }		[Column] public short RoleID { get; set; }		[Column] public short RightID { get; set; }		[Column] public short EntityID { get; set; }		[Column] public DateTime? CreatedOn { get; set; }		[Column] public int? CreatedBy { get; set; }		[Column] public DateTime? ModifiedOn { get; set; }		[Column] public int? ModifiedBy { get; set; }}
    
	[TableName("Statuses")]
	[PrimaryKey("StatusID", autoIncrement=false)]
	[ExplicitColumns]
    public partial class Status : FrameworkRepository.Record<Status>  
    {
		[Column] public short StatusID { get; set; }		[Column] public string StatusName { get; set; }		[Column] public bool IsActive { get; set; }		[Column] public DateTime? CreatedOn { get; set; }		[Column] public int? CreatedBy { get; set; }		[Column] public DateTime? ModifiedOn { get; set; }		[Column] public int? ModifiedBy { get; set; }}
    
	[TableName("CNICVerifications")]
	[PrimaryKey("CNICVerificationID")]
	[ExplicitColumns]
    public partial class CNICVerification : FrameworkRepository.Record<CNICVerification>  
    {
		[Column] public int CNICVerificationID { get; set; }		[Column] public int ApplicationID { get; set; }		[Column] public DateTime RequestedOn { get; set; }		[Column] public string CNIC { get; set; }		[Column] public short StatusID { get; set; }		[Column] public string ResponseText { get; set; }		[Column] public DateTime? UpdatedOn { get; set; }		[Column] public DateTime? CreatedOn { get; set; }		[Column] public int? CreatedBy { get; set; }		[Column] public DateTime? ModifiedOn { get; set; }		[Column] public int? ModifiedBy { get; set; }}
}


