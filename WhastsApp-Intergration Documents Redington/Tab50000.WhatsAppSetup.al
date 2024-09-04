table 50000 "WhatsApp-Setup"
{
    Caption = 'WhatsApp-Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            Caption = 'Primary Key';
        }
        field(2; "Account SID"; Text[50])
        {
            Caption = 'Account SID';
        }
        field(3; "Auth Token"; Text[50])
        {
            Caption = 'Auth Token';
        }
        field(4; "From Number"; Text[50])
        {
            Caption = 'From Number';
        }
        field(5; "To Number "; Text[50])
        {
            Caption = 'To Number ';
        }
        field(6; "Message Body"; Text[1024])
        {
            Caption = 'Message Body';
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
