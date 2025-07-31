page 50010 TenantPermissions
{
    APIGroup = 'cetasgroup';
    APIPublisher = 'cetasPublisher';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'tenantPermissions';
    DelayedInsert = true;
    EntityName = 'tenantPermission';
    EntitySetName = 'tenantPermissions';
    PageType = API;
    ODataKeyFields = SystemId;
    SourceTable = "Tenant Permission";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(systemId; Rec.SystemId)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique identifier for the tenant permission.';
                    Editable = false;
                }
                field(roleID; Rec."Role ID")
                {
                    Caption = 'Role ID';
                    Editable = false;
                }
                field(roleName; Rec."Role Name")
                {
                    Caption = 'Role Name';
                }
                field(appID; Rec."App ID")
                {
                    Caption = 'App ID';
                    Editable = false;
                }
                field(objectID; Rec."Object ID")
                {
                    Caption = 'Object ID';
                    Editable = false;
                }
                field("objectType"; Rec."Object Type")
                {
                    Caption = 'Object Type';
                    Editable = false;
                }
                field(objectName; Rec."Object Name")
                {
                    Caption = 'Object Name';
                }
                field("type"; Rec."Type")
                {
                    Caption = 'Type';
                }
                field(insertPermission; Rec."Insert Permission")
                {
                    Caption = 'Insert Permission';
                }
                field(modifyPermission; Rec."Modify Permission")
                {
                    Caption = 'Modify Permission';
                }
                field(deletePermission; Rec."Delete Permission")
                {
                    Caption = 'Delete Permission';
                }
                field(executePermission; Rec."Execute Permission")
                {
                    Caption = 'Execute Permission';
                }
                field(readPermission; Rec."Read Permission")
                {
                    Caption = 'Read Permission';
                }
                field("securityFilter"; Rec."Security Filter")
                {
                    Caption = 'Security Filter';
                }
            }
        }
    }
}
