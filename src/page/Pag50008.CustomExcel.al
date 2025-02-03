page 50008 "Custom-Excel"
{
    ApplicationArea = All;
    Caption = 'Custom-Excel';
    PageType = List;
    Editable = true;
    SourceTable = "Integer";
    SourceTableView = where(Number = filter(1 ..));
    UsageCategory = Administration;
    Permissions = tabledata "Excel Buffer" = rimd, tabledata Integer = rimd;

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
                    // Editable = false;
                }
                field(Col1; Value1)
                {
                    CaptionClass = ExcelToolCu.GetColumnName(DirectionColumn);
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        Value1 := GetOtherCellvalue(Rec.Number, DirectionColumn, Value1);
                        Value1 := Format(TempExcelBufferRec.AddToFormula(Format(DirectionColumn) + Format(Value1)));

                    end;
                }
                field(COl2; Value2)
                {
                    CaptionClass = ExcelToolCu.GetColumnName(DirectionColumn + 1);
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        Value2 := GetOtherCellvalue(Rec.Number, DirectionColumn + 1, Value2);
                    end;
                }
                field(COl3; Value3)
                {
                    CaptionClass = ExcelToolCu.GetColumnName(DirectionColumn + 2);
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        Value3 := GetOtherCellvalue(Rec.Number, DirectionColumn + 2, Value3);
                    end;

                }
                field(COl4; Value4)
                {
                    CaptionClass = ExcelToolCu.GetColumnName(DirectionColumn + 3);
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        Value4 := GetOtherCellvalue(Rec.Number, DirectionColumn + 3, Value4);
                    end;
                }
                field(COl5; Value5)
                {
                    CaptionClass = ExcelToolCu.GetColumnName(DirectionColumn + 4);
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        Value5 := GetOtherCellvalue(Rec.Number, DirectionColumn + 4, Value5);
                    end;

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
                ApplicationArea = all;
                trigger OnAction()
                begin
                    DirectionColumn += 1;
                end;
            }

            action("Right Scroll")
            {
                Image = NextSet;
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
                trigger OnAction()
                begin
                    if UploadIntoStream('Enter Excel', '', '', FileName, Ins) then begin
                        TempExcelBufferRec.DeleteAll();
                        SelectSheet := TempExcelBufferRec.SelectSheetsNameStream(Ins);
                        TempExcelBufferRec.OpenBookStream(Ins, SelectSheet);
                        TempExcelBufferRec.ReadSheet();

                        if TempExcelBufferRec.FindLast() then
                            LastRow := TempExcelBufferRec."Row No.";
                    end;
                end;
            }

            action("Export Excel")
            {
                Image = ExportToExcel;
                ApplicationArea = all;
                trigger OnAction()
                var
                    ExportToExcel: Codeunit "Export Mapping";
                begin
                    // ExportToExcel.EditPageInExcel('Custom-Excel', 50008);

                    TempExcelBufferRec.CreateNewBook('Our Custom excel file');
                    TempExcelBufferRec.WriteSheet('Custom excel file', CompanyName, UserId);
                    TempExcelBufferRec.CloseBook();
                    TempExcelBufferRec.SetFriendlyFilename(StrSubstNo('Custom excel thrid', CurrentDateTime, UserId));
                    TempExcelBufferRec.OpenExcel();

                end;
            }
            action("Calculate Formula")
            {
                Image = UpdateDescription;
                ApplicationArea = all;
                trigger OnAction()
                begin
                    Value1 := Format(TempExcelBufferRec.AddToFormula(Format(DirectionColumn) + Format(Value1)));




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
            actionref("Export Excels"; "Export Excel")
            {

            }
            actionref("Calculate Formulas"; "Calculate Formula")
            {

            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        Value1 := GetExcelCell(Rec.Number, DirectionColumn);
        Value2 := GetExcelCell(Rec.Number, DirectionColumn + 1);
        Value3 := GetExcelCell(Rec.Number, DirectionColumn + 2);
        Value4 := GetExcelCell(Rec.Number, DirectionColumn + 3);
        Value5 := GetExcelCell(Rec.Number, DirectionColumn + 4);



    end;

    var
        ExcelToolCu: Codeunit "Excel Tools";
        TempExcelBufferRec: Record "Excel Buffer" temporary;
        TempExcelBufferRec2: Record "Excel Buffer" temporary;
        Ins: InStream;
        FileName: Text;
        DirectionColumn: Integer;
        Row: Integer;
        LastRow: Integer;

        SelectSheet: Code[20];

        Value1: Text;
        Value2: Text;
        Value3: Text;
        Value4: Text;
        Value5: Text;

    procedure GetExcelCell(Row: Integer; Col: Integer): Text
    begin
        if TempExcelBufferRec.Get(row, Col) then
            exit(TempExcelBufferRec."Cell Value as Text");
    end;


    procedure GetOtherCellvalue(Row: Integer; Col: Integer; Value: text): Text
    begin
        if TempExcelBufferRec.Get(row, Col) then begin
            TempExcelBufferRec."Cell Value as Text" := Value;
            TempExcelBufferRec.Modify(true);
            exit(GetExcelCell(TempExcelBufferRec."Row No.", TempExcelBufferRec."Column No."));
        end
        else begin
            TempExcelBufferRec.Init();
            TempExcelBufferRec.Validate("Row No.", Row);
            TempExcelBufferRec.Validate("Column No.", Col);
            TempExcelBufferRec.Insert(true);
            TempExcelBufferRec.Validate("Cell Value as Text", Value);
            TempExcelBufferRec.Modify(true);
            exit(GetExcelCell(TempExcelBufferRec."Row No.", TempExcelBufferRec."Column No."));
        end;
    end;



    // procedure GetSheetNamesFromExcel(): List of [Text]
    // var
    //     SheetNames: List of [Text];
    //     ExcelBufferRec: Record "Excel Buffer" temporary;
    //     Ins: InStream;
    //     FileName: Text;
    // begin
    //     // Upload the Excel file
    //     if UploadIntoStream('Upload Excel File', '', '', FileName, Ins) then begin
    //         // Open the Excel file and read its contents into the Excel buffer
    //         ExcelBufferRec.OpenBookStream(Ins, FileName);

    //         // Retrieve all the sheet names from the Excel file
    //         ExcelBufferRec.GetAllSheets(SheetNames);
    //     end;

    //     // Return the list of sheet names
    //     exit(SheetNames);
    // end;

    trigger OnOpenPage()
    begin
        DirectionColumn := 1;
    end;
}
