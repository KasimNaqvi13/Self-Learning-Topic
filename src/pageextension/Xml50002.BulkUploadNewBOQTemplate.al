xmlport 50002 "Bulk Upload New BOQ Template"
{
    Format = VariableText;
    Direction = Export;
    TextEncoding = UTF8;
    UseRequestPage = false;
    FileName = 'BulkNewBOQ.csv';
    TableSeparator = '<NewLine>';
    Caption = 'Bulk Upload New BOQ Template';
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
                textelement(CITCustomerBOQNo)
                {

                    trigger OnBeforePassVariable()
                    begin
                        CITCustomerBOQNo := VoCollectionRec.FieldCaption("CIT Customer BOQ No.");
                    end;
                }
                textelement(CITJobTaskDescription)
                {

                    trigger OnBeforePassVariable()
                    begin
                        CITJobTaskDescription := VoCollectionRec.FieldCaption("CIT Job Task Description");
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

                textelement(CITCustomerBOQUOM)
                {

                    trigger OnBeforePassVariable()
                    begin
                        CITCustomerBOQUOM := VoCollectionRec.FieldCaption("CIT Customer BOQ UOM");
                    end;
                }
                // textelement(TaskUnitPrice)
                // {

                //     trigger OnBeforePassVariable()
                //     begin
                //         TaskUnitPrice := VoCollectionRec.FieldCaption("Task Unit Price");
                //     end;
                // }

                textelement(CITQuantity)
                {

                    trigger OnBeforePassVariable()
                    begin
                        CITQuantity := VoCollectionRec.FieldCaption("CIT Quantity");
                    end;
                }
                textelement(CITVOBillingType)
                {

                    trigger OnBeforePassVariable()
                    begin
                        CITVOBillingType := VoCollectionRec.FieldCaption("CIT VO Billing Type");
                    end;
                }
                textelement(CITPriceDefinitionCode)
                {

                    trigger OnBeforePassVariable()
                    begin
                        CITPriceDefinitionCode := VoCollectionRec.FieldCaption("CIT Price Definition Code");
                    end;
                }
                textelement(CITHandlingCharges)
                {

                    trigger OnBeforePassVariable()
                    begin
                        CITHandlingCharges := VoCollectionRec.FieldCaption("CIT Handling Charges");
                    end;
                }
                textelement(CITReferenceTaskNo)
                {

                    trigger OnBeforePassVariable()
                    begin
                        CITReferenceTaskNo := VoCollectionRec.FieldCaption("CIT Reference Task No.");
                    end;
                }
                textelement(CITGlobalDimension1Code)
                {

                    trigger OnBeforePassVariable()
                    begin
                        CITGlobalDimension1Code := VoCollectionRec.FieldCaption("CIT Global Dimension 1 Code");
                    end;
                }
                textelement(CITGlobalDimension2Code)
                {

                    trigger OnBeforePassVariable()
                    begin
                        CITGlobalDimension2Code := VoCollectionRec.FieldCaption("CIT Global Dimension 2 Code");
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
