xmlport 50003 "Map RA"
{
    Caption = 'Map RA';
    Format = VariableText;
    Direction = Import;
    TextEncoding = UTF8;
    UseRequestPage = false;
    FileName = 'MapRA.Csv';
    TableSeparator = '<NewLine>';
    DefaultFieldsValidation = true;
    Permissions = tabledata "CIT VO Lines Collection" = rimd, tabledata "CIT VO Lines" = rimd,
    tabledata "CIT VO Header" = rimd, tabledata "CIT VO Composition Line" = rimd, tabledata "CIT VO Value Adjustment" = rimd;
    schema
    {
        textelement(Root)
        {
            tableelement("Vo Collection"; "CIT VO Lines Collection")
            {
                XmlName = 'VoCollection';
                RequestFilterFields = "CIT Job Task No.";
                fieldelement(CITVarOrderNo; "Vo Collection"."CIT Var. Order No.")
                {
                    trigger OnAfterAssignField()
                    begin
                        if ("Vo Collection"."CIT Var. Order No." <> '') then
                            Error('You can pass value to this %1 field', 'CIT Var. Order No.');

                        "Vo Collection".Validate("CIT Var. Order No.", VoHeaderRec."CIT Var. Order No.");
                    end;
                }
                fieldelement(CITJobNo; "Vo Collection"."CIT Job No.")
                {
                    trigger OnAfterAssignField()
                    begin
                        if ("Vo Collection"."CIT Job No." <> '') then
                            Error('You can pass value to this %1 field', 'CIT Job No.');

                        "Vo Collection".Validate("CIT Job No.", VoHeaderRec."CIT Job No.");
                    end;
                }
                fieldelement(CITVariationType; "Vo Collection"."CIT Variation Type")
                {
                    trigger OnAfterAssignField()
                    begin
                        "Vo Collection".Validate("CIT Variation Type", "Vo Collection"."CIT Variation Type"::"Change in BOQ");
                    end;
                }

                fieldelement(CITChangeType; "Vo Collection"."CIT Change Type")
                {
                    trigger OnAfterAssignField()
                    begin
                        "Vo Collection".Validate("CIT Change Type", "Vo Collection"."CIT Change Type"::"Change in RA");
                    end;
                }
                fieldelement(CITJobTaskType; "Vo Collection"."CIT Job Task Type")
                {
                    trigger OnAfterAssignField()
                    begin
                        "Vo Collection".Validate("CIT Job Task Type", "Vo Collection"."CIT Job Task Type"::Posting);
                    end;
                }

                fieldelement(CITLineNo; "Vo Collection"."CIT Line No.")
                {
                }
                fieldelement(CITJobTaskNo; "Vo Collection"."CIT Job Task No.")
                {
                }
                fieldelement(CITRANo; "Vo Collection"."CIT RA No.")
                {
                }
                fieldelement(CITRAUOM; "Vo Collection"."CIT RA UOM")
                {

                }
                fieldelement(CITVOBillingType; "Vo Collection"."CIT VO Billing Type")
                {
                }

                #region Triggers
                trigger OnAfterInitRecord()
                begin
                    if IsFirstline then begin
                        IsFirstline := false;
                        currXMLport.Skip();
                    end;
                end;


                trigger OnAfterInsertRecord()
                var
                    VarOrderMgmt: Codeunit "CIT Variation Order Mgmnt";
                    VOLineRec: Record "CIT VO Lines";
                    CopyOfVOLines: Record "CIT VO Lines";
                    Text33062465Lbl: Label 'VO Billing Type should be either Billable or Non Billable';
                begin
                    if ("Vo Collection"."CIT Job Task No." <> '') and ("Vo Collection"."CIT RA No." <> '') then begin
                        if "Vo Collection"."CIT VO Billing Type" = "Vo Collection"."CIT VO Billing Type"::" " then
                            Error(Text33062465Lbl)
                        else begin
                            this.InsertVOLines("Vo Collection", VOLineRec);
                            VarOrderMgmt.VariationProcessEstimate(VOLineRec);
                        end;
                    end
                    else
                        Error('CIT Job Task No. and CIT RA No. are mandatory fields');
                end;
                #endregion Triggers
            }
        }
    }

    trigger OnPreXmlPort()
    begin
        IsFirstline := true;
    end;

    procedure InsertVOLines(Rec: Record "CIT VO Lines Collection"; var VOLineRec: Record "CIT VO Lines")
    var
        VOLinesRec: Record "CIT VO Lines";
        VOLinesTempRec: Record "CIT VO Lines";
    begin
        VOLinesRec.Init();
        VOLinesRec.TRANSFERFIELDS(Rec);
        //CIT283 NB V3.65 - BEGIN
        Rec.CalcFields("CIT BOQ Description");
        If Rec."CIT BOQ Description".HasValue then
            VOLinesRec."CIT BOQ Description" := Rec."CIT BOQ Description";
        //CIT283 NB V3.65 - END
        VOLinesTempRec.Reset();
        VOLinesTempRec.SetRange("CIT Var. Order No.", Rec."CIT Var. Order No.");
        VOLinesTempRec.SetRange("CIT Job No.", Rec."CIT Job No.");
        if Rec."CIT Job Task No." <> '' then
            VOLinesTempRec.SetRange("CIT Job Task No.", Rec."CIT Job Task No.");
        if VOLinesTempRec.FindLast() then
            VOLinesRec."CIT Line No." := VOLinesTempRec."CIT Line No." + 10000
        else
            VOLinesRec."CIT Line No." := 10000;

        if Rec."CIT Variation Type" in ["CIT Variation Type"::"Change in Item", "CIT Variation Type"::"Change in Resource", "CIT Variation Type"::"Change in Res.Group"] then
            if Rec."CIT Change Type" = "CIT Change Type"::Addition then
                VOLinesRec."CIT Quantity" := Rec."CIT Quantity to Revise";
        VOLinesRec.Insert();
        VOLineRec := VOLinesRec;
    end;

    procedure SetVoHeaderRecord(VoHeadRec: Record "CIT VO Header")
    begin
        VoHeaderRec := VoHeadRec;
    end;

    var
        VoHeaderRec: Record "CIT VO Header";
        IsFirstline: Boolean;
        Error001: Label 'You can pass value to this %1 field';

}
