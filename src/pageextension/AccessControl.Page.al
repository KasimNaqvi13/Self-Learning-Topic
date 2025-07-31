page 50005 "Access Control"
{
    APIGroup = 'cetasgroup';
    APIPublisher = 'cetasPublisher';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'accessControl';
    DelayedInsert = true;
    EntityName = 'accessControl';
    EntitySetName = 'accessControls';
    PageType = API;
    SourceTable = "Access Control";
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(systemId; Rec.SystemId)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique identifier for the access control system.';
                    Editable = false;
                }
                field(userSecurityId; Rec."User Security ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique identifier for the user SecurityId.';
                    Editable = false;
                }
                field(userName; Rec."User Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the user.';
                }
                field(roleId; Rec."Role ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique identifier for the role assigned to the user.';
                    Editable = false;
                }
                field(roleName; Rec."Role Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the role assigned to the user.';
                }
                field(companyName; Rec."Company Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the company.';
                    Editable = false;
                }
                field(scope; Rec.Scope)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the scope of the access control.';
                    Editable = false;
                }
                field(appId; Rec."App ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the application ID.';
                    Editable = false;
                }
                field(appName; Rec."App Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the application.';
                }
            }
        }
    }
}
