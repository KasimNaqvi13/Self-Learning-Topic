// TODO: Replace 50004 with an object ID assigned by AL Object ID Ninja or your organization's guidelines.
page 50100 UserAPI
{
    APIGroup = 'cetasGroup';
    APIPublisher = 'cetasPublisher';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'userAPI';
    DelayedInsert = true;
    EntityName = 'apiUser';
    EntitySetName = 'apiUsers';
    PageType = API;
    SourceTable = user;
    ODataKeyFields = SystemId;
    Permissions =
        tabledata user = RIMD;

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
                field(userId; Rec."User Security ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the user security ID.';
                    Editable = false;
                }
                field(userName; Rec."User Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the user name.';
                }
                field(fullName; Rec."Full Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the full name of the user.';
                }
                field(expiryDate; Rec."Expiry Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the expiry date of the user.';
                }
                field(licenseType; Rec."License Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the license type of the user.';
                }
                field(email; Rec."Contact Email")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the contact email address of the user.';
                }
                field(applicationID; Rec."Application ID")
                {
                    Caption = 'Application ID';
                }
                field(authenticationEmail; Rec."Authentication Email")
                {
                    Caption = 'Authentication Email';
                }
                field(changePassword; Rec."Change Password")
                {
                    Caption = 'Change Password';
                }
                field(exchangeIdentifier; Rec."Exchange Identifier")
                {
                    Caption = 'Exchange Identifier';
                }
                field(state; Rec.State)
                {
                    Caption = 'State';
                }
                field(windowsSecurityID; Rec."Windows Security ID")
                {
                    Caption = 'Windows Security ID';
                }
            }
        }
    }
}
