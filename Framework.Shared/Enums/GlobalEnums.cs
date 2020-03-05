using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Framework.Shared.Enums
{
    public enum RightsEnum : short
    {
        Add = 1,
        Update = 2,
        Delete = 3,
        ViewSelf = 4,
        ViewAll = 5
    }

    public enum StatusesEnum : short
    {
        Active = 1,
        Deactived = 2,
        Terminated = 3,
        Submit = 4,
        WaitingForApproval = 5,
        InReview = 6,
        Rejected = 7,
        Approved = 8,
        Completed = 9,
        Closed = 10
    }

    public enum RolesEnum : short
    {
        Admin = 1,
        FieldWorker = 2,
        Committee = 3,
        RS = 4,
        HeadFieldWorker = 5,
        CEO = 6,
        Finance = 7,
        SuperAdmin =109
    }

    public enum FieldTypesEnum : short
    {
        Text = 1,
        DropDownList = 2,
        CheckBox = 3,
        Heading = 4,
        Number = 5,
        DateTime = 6,
        RadioButton = 7,
        TextArea = 8,
        Formula = 9,
        File = 10
    }
}
