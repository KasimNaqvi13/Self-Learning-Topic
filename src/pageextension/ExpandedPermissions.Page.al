page 50006 ExpandedPermissions
{
    APIGroup = 'cetasgroup';
    APIPublisher = 'cetasPublisher';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'expandedPermissions';
    DelayedInsert = true;
    EntityName = 'expandedPermission';
    EntitySetName = 'expandedPermissions';
    PageType = API;
    ODataKeyFields = SystemId;
    SourceTable = "Expanded Permission";

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
                field(roleId; Rec."Role ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique identifier for the role assigned to the user.';
                    Editable = false;
                }
                field(roleName; Rec."Role Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the role.';
                }
                field(objectId; Rec."Object ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique identifier for the object.';
                    Editable = false;
                }
                field(objectType; Rec."Object Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of the object.';
                    Editable = false;
                }
                field(objectName; Rec."Object Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the object.';
                }

                field(appID; Rec."App ID")
                {
                    Caption = 'App ID';
                }
                field(alObjectName; Rec."AL Object Name")
                {
                    Caption = 'AL Object Name';
                }
                field(executePermission; Rec."Execute Permission")
                {
                    Caption = 'Execute Permission';
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
                field(readPermission; Rec."Read Permission")
                {
                    Caption = 'Read Permission';
                }
                field(scope; Rec.Scope)
                {
                    Caption = 'Scope';
                }
                field("securityFilter"; Rec."Security Filter")
                {
                    Caption = 'Security Filter';
                }
            }
        }
    }
}
