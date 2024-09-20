/// <summary>
/// Table Production Bom Tree (ID 50007).
/// </summary>
table 50007 "Production Bom Tree"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 2;
        }
        field(5; "Quantity Per"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 2;
        }
        field(6; "Main Prod No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Parent Prod No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Bom Bool"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Indention"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}