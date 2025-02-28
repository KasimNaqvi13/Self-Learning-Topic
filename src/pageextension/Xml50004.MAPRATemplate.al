xmlport 50004 "MAP RA Template"
{
    Caption = 'MAP RA Template';
    Format = VariableText;
    Direction = Export;
    TextEncoding = UTF8;
    UseRequestPage = false;
    FileName = 'MapRA.csv';
    TableSeparator = '<NewLine>';
    schema
    {
        textelement(Root)
        {
            tableelement(Integer; Integer)
            {
                XmlName = 'ItemHeader';
                SourceTableView = SORTING(Number) WHERE(Number = CONST(1));
                textelement(CITVarOrderNo)
                {

                    trigger OnBeforePassVariable()
                    begin
                        CITVarOrderNo := VoCollectionRec.FieldCaption("CIT Var. Order No.");
                    end;
                }
                textelement(CITJobNo)
                {

                    trigger OnBeforePassVariable()
                    begin
                        CITJobNo := VoCollectionRec.FieldCaption("CIT Job No.");
                    end;
                }
                textelement(CITVariationType)
                {

                    trigger OnBeforePassVariable()
                    begin
                        CITVariationType := VoCollectionRec.FieldCaption("CIT Variation Type");
                    end;
                }
                textelement(CITChangeType)
                {

                    trigger OnBeforePassVariable()
                    begin
                        CITChangeType := VoCollectionRec.FieldCaption("CIT Change Type");
                    end;
                }
                textelement(CITJobTaskType)
                {

                    trigger OnBeforePassVariable()
                    begin
                        CITJobTaskType := VoCollectionRec.FieldCaption("CIT Job Task Type");
                    end;
                }
                textelement(CITLineNo)
                {

                    trigger OnBeforePassVariable()
                    begin
                        CITLineNo := VoCollectionRec.FieldCaption("CIT Line No.");
                    end;
                }
                textelement(CITJobTaskNo)
                {

                    trigger OnBeforePassVariable()
                    begin
                        CITJobTaskNo := VoCollectionRec.FieldCaption("CIT Job Task No.");
                    end;
                }
                textelement(CITRANo)
                {

                    trigger OnBeforePassVariable()
                    begin
                        CITRANo := VoCollectionRec.FieldCaption("CIT RA No.");
                    end;
                }
                textelement(CITRAUOM)
                {
                    trigger OnBeforePassVariable()
                    begin
                        CITRAUOM := VoCollectionRec.FieldCaption("CIT RA UOM");
                    end;
                }
                textelement(CITVOBillingType)
                {

                    trigger OnBeforePassVariable()
                    begin
                        CITVOBillingType := VoCollectionRec.FieldCaption("CIT VO Billing Type");
                    end;
                }
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        VoCollectionRec: Record "CIT VO Lines Collection";
}
