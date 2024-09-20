table 50008 "Excel Builder"
{
    Caption = 'Excel Builder';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Primary; Code[20])
        {
            Caption = 'Primary';
            DataClassification = SystemMetadata;
        }
        field(2; "Text Data"; Text[250])
        {
            Caption = 'Text';
            DataClassification = SystemMetadata;
        }
        field(3; "Date Data"; Date)
        {
            Caption = 'Date';
            DataClassification = SystemMetadata;
        }
        field(4; "Decimal Data"; Decimal)
        {
            Caption = 'Decimal';
            DataClassification = SystemMetadata;
        }
    }
    keys
    {
        key(PK; Primary)
        {
            Clustered = true;
        }
    }
}
