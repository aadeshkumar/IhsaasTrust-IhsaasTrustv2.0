using Newtonsoft.Json;
using Framework.Application.Services;
using Framework.ControlPanel.CommonCode.Helpers;
using Framework.ControlPanel.Models;
using Framework.Shared.DataServices;
using Framework.Shared.DataServices.CustomEntities;
using Framework.Shared.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Framework.ControlPanel.CommonCode
{
    public abstract class DynamicExtender
    {
        public virtual bool IsValidToSave(object obj) { return false; }
        public virtual string ValidationMessage(object obj) { return string.Empty; }
        public virtual void BeforeSave(object obj, FormCollection formValues) { }
        public virtual void BeforeUpdate(object obj, FormCollection formValues, object id) { }
        public virtual void AfterSave(object obj, FormCollection formValues) { }
        public virtual void AfterUpdate(object obj, FormCollection formValues, object id) { }
        public virtual void BeforeDelete(object obj, FormCollection formValues, object id, string configs) { }
        public virtual void AfterDelete(object obj, FormCollection formValues) { }

    }
    public class EntitiesExtender : DynamicExtender
    {
        public override bool IsValidToSave(object obj) { return true; }
        public override string ValidationMessage(object obj) { return string.Empty; }
        public override void AfterSave(object obj, FormCollection formValues)
        {
            short entityID = (short)obj;
            string tableName = formValues["NameEn"];
            using (var context = DataContextHelper.GetCPDataContext())
            {
                string query = string.Format(@"
                                    Insert Into EntityDetails (EntityID, ColumnName, DisplayNameEn, DisplayNameAr, DbTypeID, IsRequired, IsGroup, IsForeignkey, RefrencedTableName, EnableAutoComplate,  AddEditVisible, GridVisible, SearchFilterVisible, MaxLength, IsAutoID, IsPrimaryKey, DisplaySeqNo, IsFileUpload, ShowGroupTitle)
                                    Select
                                    {0} As  EntityID,
                                    c.name As ColumnName, 
                                    c.name As DisplayNameEn, 
                                    c.name As DisplayNameAr, 
                                    c.system_type_id As DbTypeID,
                                    ~c.is_nullable As IsRequired,
                                    0 As IsGroup,
                                    IsNull((select top 1 1 from sys.foreign_key_columns f where f.parent_column_id = c.column_id AND f.parent_object_id = c.object_id), 0) As IsForeignkey,
                                    (select name from sys.objects Where object_id = (select f.referenced_object_id from sys.foreign_key_columns f where f.parent_column_id = c.column_id AND f.parent_object_id = c.object_id)) RefrencedTableName,
                                    0 As EnableAutoComplate,
                                    0 As AddEditVisible, 
                                    0 As GridVisible,
                                    0 As SearchFilterVisible, 
                                    c.max_length As MaxLength, 
                                    c.is_identity As IsAutoID,
                                    IsNull((select 1 from sys.indexes i inner join sys.index_columns ic on i.object_id = ic.object_id and  i.index_id = ic.index_id Where i.object_id =  c.object_id and i.is_primary_key = 1 and ic.column_id = c.column_id),0) As IsPrimaryKey,
                                    0 As DisplaySeqNo, 0 As IsFileUpload, 
                                    0 As ShowGroupTitle
                                    From Sys.columns c
                                    Where c.object_id = OBJECT_ID('{1}')
                                    And c.name Not In (Select ColumnName From EntityDetails Where EntityID = {0})", entityID, tableName);
                context.Execute(query);
                context.Execute("Update EntityDetails Set IsAutoID = 1 Where ColumnName IN ('CreatedOn', 'CreatedBy', 'ModifiedOn', 'ModifiedBy') AND EntityID = @0", entityID);
            }
        }
        public override void BeforeDelete(object obj, FormCollection formValues, object id, string configs)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                context.Execute("Delete From RoleRights Where EntityID = @0", id);
                context.Execute("Delete From EntityDetails Where EntityID = @0", id);
            }
        }
    }

    public class DynamicSetupScreenExtender : DynamicExtender
    {
        public override bool IsValidToSave(object obj) { return true; }
        public override string ValidationMessage(object obj) { return string.Empty; }
        public override void BeforeSave(object obj, FormCollection formValues) { }
        public override void BeforeUpdate(object obj, FormCollection formValues, object id)
        {


        }
        public override void AfterSave(object obj, FormCollection formValues)
        {
            bool allowApprovals = bool.Parse(formValues["AllowApprovals"]);
            if (allowApprovals)
            {
                Approval approval = new Approval();
                approval.UserID = Authentication.Instance.User.UserID;
                approval.EntityID = short.Parse(formValues["TableEntityID"]);
                approval.RowID = int.Parse(obj.ToString());
                approval.CreatedBy = Authentication.Instance.User.UserID;
                approval.CreatedOn = DateTime.Now;
                approval.StatusID = (short)StatusesEnum.Submit;

                using (var context = DataContextHelper.GetCPDataContext())
                {
                    context.Insert(approval);
                }
            }
        }
        public override void AfterUpdate(object obj, FormCollection formValues, object id)
        {
            
        }
        public override void BeforeDelete(object obj, FormCollection formValues, object id, string configs)
        {
            
        }
        public override void AfterDelete(object obj, FormCollection formValues) { }
    }

    public class UserExtender : DynamicExtender
    {
        public override void BeforeDelete(object obj, FormCollection formValues, object id, string configs)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                context.Execute("Delete From UserRoles where userid = @0", id);
            }
        }
    }

}