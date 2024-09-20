page 50008 "Excel Viewer"
{
    ApplicationArea = All;
    Caption = 'Excel Viewer';
    PageType = List;
    Editable = false;
    SourceTable = "Integer";
    SourceTableView = where(Number = filter(1 ..));
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Number; Rec.Number)
                {
                    Caption = '';
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Col1; GetExcelCell(Rec.Number, DirectionColumn))
                {
                    CaptionClass = ExcelToolCu.GetColumnName(DirectionColumn);
                    ApplicationArea = all;
                }
                field(COl2; GetExcelCell(Rec.Number, DirectionColumn + 1))
                {
                    CaptionClass = ExcelToolCu.GetColumnName(DirectionColumn + 1);
                    ApplicationArea = all;
                }
                field(COl3; GetExcelCell(Rec.Number, DirectionColumn + 2))
                {
                    CaptionClass = ExcelToolCu.GetColumnName(DirectionColumn + 2);
                    ApplicationArea = all;
                }
                field(COl4; GetExcelCell(Rec.Number, DirectionColumn + 3))
                {
                    CaptionClass = ExcelToolCu.GetColumnName(DirectionColumn + 3);
                    ApplicationArea = all;
                }
                field(COl5; GetExcelCell(Rec.Number, DirectionColumn + 4))
                {
                    CaptionClass = ExcelToolCu.GetColumnName(DirectionColumn + 4);
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Left Scroll")
            {
                Image = PreviousSet;
                // Promoted = true;
                // PromotedCategory = Process;
                // PromotedOnly = true;
                ApplicationArea = all;
                trigger OnAction()
                begin
                    if DirectionColumn > 5 then
                        DirectionColumn -= 5
                    else if DirectionColumn > 4 then
                        DirectionColumn -= 4
                    else if DirectionColumn > 3 then
                        DirectionColumn -= 3
                    else if DirectionColumn > 2 then
                        DirectionColumn -= 2
                    else if DirectionColumn > 1 then
                        DirectionColumn -= 1;
                end;
            }

            action(Left)
            {
                Image = PreviousRecord;
                // Promoted = true;
                // PromotedCategory = Process;
                // PromotedOnly = true;
                ApplicationArea = all;
                trigger OnAction()
                begin
                    if DirectionColumn > 1 then
                        DirectionColumn -= 1;
                end;
            }

            action(Right)
            {
                Image = NextRecord;
                // Promoted = true;
                // PromotedCategory = Process;
                // PromotedOnly = true;
                ApplicationArea = all;
                trigger OnAction()
                begin
                    DirectionColumn += 1;
                end;
            }

            action("Right Scroll")
            {
                Image = NextSet;
                // Promoted = true;
                // PromotedCategory = Process;
                // PromotedOnly = true;
                ApplicationArea = all;
                trigger OnAction()
                begin
                    DirectionColumn += 5;
                end;
            }
            action("Import Excel")
            {
                Image = ImportExcel;
                ApplicationArea = all;
                // Promoted = true;
                // PromotedCategory = Process;
                // PromotedOnly = true;
                trigger OnAction()
                begin
                    if UploadIntoStream('Enter Excel', '', '', FileName, Ins) then begin
                        TempExcelBufferRec.DeleteAll();
                        TempExcelBufferRec.OpenBookStream(Ins, 'Sheet1');
                        TempExcelBufferRec.ReadSheet();

                        if TempExcelBufferRec.FindLast() then
                            LastRow := TempExcelBufferRec."Row No.";
                    end;
                end;
            }
        }
        area(Promoted)
        {
            actionref(LeftScroll; "Left Scroll")
            {

            }
            actionref(LeftAction; Left)
            {

            }
            actionref(Rights; Right)
            {

            }
            actionref(RightScroll; "Right Scroll")
            {

            }
            actionref(ImportExcel; "Import Excel")
            {

            }
        }
    }

    var
        ExcelToolCu: Codeunit "Excel Tools";
        TempExcelBufferRec: Record "Excel Buffer" temporary;
        TempExcelBufferRec2: Record "Excel Buffer" temporary;
        Ins: InStream;
        FileName: Text;
        DirectionColumn: Integer;
        Row: Integer;
        LastRow: Integer;

    procedure GetExcelCell(Row: Integer; Col: Integer): Text
    begin
        if TempExcelBufferRec.Get(row, Col) then
            exit(TempExcelBufferRec."Cell Value as Text");
    end;

    trigger OnOpenPage()
    begin
        DirectionColumn := 1;
    end;
}
