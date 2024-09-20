page 50009 "Excel Builder"
{
    ApplicationArea = All;
    Caption = 'Excel Builder';
    PageType = NavigatePage;
    SourceTable = "Excel Builder";
    UsageCategory = Documents;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'General';

                field(Primary; Rec.Primary)
                {
                    ToolTip = 'Specifies the value of the Primary field.';
                    ApplicationArea = all;
                }
                field("Text Data"; Rec."Text Data")
                {
                    ToolTip = 'Specifies the value of the Text field.';
                    ApplicationArea = all;
                }
                field("Date Data"; Rec."Date Data")
                {
                    ToolTip = 'Specifies the value of the Date field.';
                    ApplicationArea = all;
                }
                field("Decimal Data"; Rec."Decimal Data")
                {
                    ToolTip = 'Specifies the value of the Decimal field.';
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Import)
            {
                ApplicationArea = all;
                InFooterBar = true;
                trigger OnAction()
                var
                    ExcelBufferRec: Record "Excel Buffer" temporary;
                    Ins: InStream;
                    FileName: Text;
                    LastRow: Integer;
                    row: Integer;
                    ExcelBuilderRec: Record "Excel Builder";
                    ExcelTool: Codeunit "Excel Tools";
                    count: Integer;

                begin
                    if ExcelBuilderRec.FindSet() then
                        ExcelBuilderRec.DeleteAll();

                    if UploadIntoStream('Insert the excel File', '', '', FileName, Ins) then begin
                        ExcelBufferRec.OpenBookStream(Ins, 'Sheet1');
                        ExcelBufferRec.ReadSheet();
                        ExcelBufferRec.SetRange("Column No.", 1);
                        ExcelBufferRec.FindLast();
                        LastRow := ExcelBufferRec."Row No.";
                        ExcelBufferRec.Reset();

                        for row := 2 to LastRow do begin
                            ExcelBuilderRec.Init();
                            ExcelBuilderRec.Primary := ExcelTool.GetText(ExcelBufferRec, 'A', row);
                            ExcelBuilderRec."Text Data" := ExcelTool.GetText(ExcelBufferRec, 'B', row);
                            ExcelBuilderRec."Date Data" := ExcelTool.GetDate(ExcelBufferRec, 'C', row);
                            ExcelBuilderRec."Decimal Data" := ExcelTool.GetDecimal(ExcelBufferRec, 'D', row);
                            ExcelBuilderRec.Insert(true);
                            count += 1;
                            Message('%1', count);
                        end;

                    end;
                end;

            }
        }
    }
}
