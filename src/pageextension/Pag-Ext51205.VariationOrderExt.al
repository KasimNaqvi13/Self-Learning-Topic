pageextension 51205 "Variation Order Ext" extends "CIT Variation Order"
{
    actions
    {

        addlast(processing)
        {
            action("Export New BOQ Template")
            {
                ApplicationArea = all;
                Image = Export;
                ToolTip = 'Executes the Export Bulk VO Template';
                trigger OnAction()
                begin
                    Xmlport.Run(Xmlport::"Bulk Upload New BOQ Template", false, false);
                end;
            }
            action("Import New BOQ")
            {
                ApplicationArea = all;
                Image = Import;
                ToolTip = 'Executes the Import Bulk New BOQ action';
                trigger OnAction()
                var
                    BulKUploadNewBOQXMLPort: XmlPort "Bulk Upload New BOQ";
                begin
                    Rec.TestField("CIT Job No.");
                    BulKUploadNewBOQXMLPort.SetVoHeaderRecord(Rec);
                    BulKUploadNewBOQXMLPort.Run();
                    CurrPage.Update();
                end;
            }
            action("Map RA")
            {
                ApplicationArea = All;
                Image = Import;
                ToolTip = 'Map RA';
                trigger OnAction()
                var
                    MapRAXMLPort: XmlPort "Map RA";
                begin
                    Rec.TestField("CIT Job No.");
                    MapRAXMLPort.SetVoHeaderRecord(Rec);
                    MapRAXMLPort.Run();
                    CurrPage.Update();
                end;
            }

            action("Export MAP RA Template")
            {
                ApplicationArea = All;
                Image = Export;
                ToolTip = 'Executes the Export MAP RA Template';
                trigger OnAction()
                begin
                    Xmlport.Run(Xmlport::"MAP RA Template", false, false);
                end;
            }
        }

        addlast(Promoted)
        {
            group("Bulk Import")
            {
                ShowAs = SplitButton;
                actionRef("Export New BOQ TemplateRef"; "Export New BOQ Template") { }
                actionRef("Import New BOQRef"; "Import New BOQ") { }
                actionRef("Map RARef"; "Map RA") { }
                actionRef("Export MAP RA TemplateRef"; "Export MAP RA Template") { }
            }

        }
    }
}
