/// <summary>
/// Page Prod bom Tree (ID 50017).
/// </summary>
page 50007 "Prod bom Tree"
{
    PageType = Worksheet;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Production Bom Tree";
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            grid("Filtering Item")
            {
                GridLayout = Columns;
                field(ItemFilter; ItemFilter)
                {
                    ApplicationArea = all;
                    TableRelation = Item;
                    Editable = ItemFilterEditable;

                    trigger OnValidate()
                    var
                        temp: Code[20];
                    begin
                        if ItemFilter <> temp then begin
                            "Prod Bom Tree Rec".Reset();
                            if "Prod Bom Tree Rec".FindSet() then
                                "Prod Bom Tree Rec".DeleteAll(true);

                        end;
                        "Item Filter Fun"(ItemFilter);
                        temp := ItemFilter;
                    end;
                }
            }
            repeater("Item List")
            {
                Editable = false;
                IndentationControls = Indention;
                ShowAsTree = true;


                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = all;
                    Visible = "Show Field";
                }
                field("Quantity Per"; Rec."Quantity Per")
                {
                    ApplicationArea = all;
                }
                field("Main Prod No."; Rec."Main Prod No.")
                {
                    ApplicationArea = all;
                    Visible = "Show Field";
                }
                field("Parent Prod No."; Rec."Parent Prod No.")
                {
                    ApplicationArea = all;
                    Visible = "Show Field";
                }
                field(Indention; Rec.Indention)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Produce Bom")
            {
                Visible = "Show Field";
                ApplicationArea = All;
                trigger OnAction();
                var
                    "Prod Bom Rec": Record "Production Bom Tree";
                    "Prod Bom Rec 2": Record "Production Bom Tree";
                begin
                    if "Prod Bom Rec".FindSet() then
                        "Prod Bom Rec".ModifyAll("Bom Bool", false);
                    if "Prod Bom Rec".FindSet() then begin
                        repeat
                            InsertingProductionBom("Prod Bom Rec"."Item No.", "Prod Bom Rec".Quantity);
                            "Prod Bom Rec"."Main Prod No." := DummyProdOrderNo;
                            "Prod Bom Rec".Modify(true);

                            "Bom Line Rec".SetRange("Production BOM No.", "Prod Bom Rec"."Item No.");
                            if "Bom Line Rec".FindSet() then begin
                                repeat
                                    "Prod Bom Rec 2".SetRange("Bom Bool", false);
                                    "Prod Bom Rec 2".SetRange("Item No.", "Bom Line Rec"."No.");
                                    if "Prod Bom Rec 2".FindSet() then begin
                                        "Prod Bom Rec 2"."Parent Prod No." := DummyProdOrderNo;
                                        "Prod Bom Rec 2"."Bom Bool" := true;
                                        "Prod Bom Rec 2".Modify(true);
                                    end;
                                until "Prod Bom Rec".Next = 0;
                            end;
                        until "Prod Bom Rec".Next = 0;
                    end;
                end;
            }
        }
    }


    var
        ItemFilter: Code[20];

        "Sales Item No.": Code[20];
        "Sales Quantity": Decimal;
        ItemFilterEditable: Boolean;
        "Bom Line Rec": Record "Production BOM Line";
        "Prod Bom Tree Rec": Record "Production Bom Tree";
        "Show Field": Boolean;
        DummyProdOrderNo: Code[20];
        SendingIndent: Integer;

    trigger OnOpenPage()
    var
        Cust: Record Customer;
    begin
        if "Sales Item No." <> '' then begin
            ItemFilterEditable := false;
            "Show Field" := true;
            "Item Filter Fun"("Sales Item No.");
        end
        else begin
            ItemFilterEditable := true;
            "Show Field" := false;
        end;

    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        Clear("Prod Bom Tree Rec");
        if "Prod Bom Tree Rec".FindSet() then
            "Prod Bom Tree Rec".DeleteAll(true);
    end;

    trigger OnPageBackgroundTaskError(TaskId: Integer; ErrorCode: Text; ErrorText: Text; ErrorCallStack: Text; var IsHandled: Boolean)
    begin

    end;

    procedure "Item Filter Fun"(ItemRecPara: Code[20])
    begin
        "Bom Line Rec".SetRange("Production BOM No.", ItemRecPara);
        if "Bom Line Rec".FindSet() then begin
            InsertingLine(ItemRecPara, true);
            Parent(ItemRecPara);
        end
        else
            InsertingLine(ItemRecPara, true);
    end;

    procedure "Getting From Sales Order"(ItemRecPara: Code[20]; QuantityRecPara: Decimal)
    begin
        "Sales Item No." := ItemRecPara;
        "Sales Quantity" := QuantityRecPara;
    end;

    procedure InsertingLine(ItemRecPara: Code[20]; "Line Bool Para": Boolean)
    var
        "Production Bom Line": Record "Production BOM Line";
    begin
        "Production Bom Line".SetRange("No.", ItemRecPara);
        if "Production Bom Line".FindSet() then
            Clear("Prod Bom Tree Rec");

        "Prod Bom Tree Rec".Init();
        "Prod Bom Tree Rec"."Item No." := ItemRecPara;
        "Prod Bom Tree Rec".Insert(true);

        "Prod Bom Tree Rec".Description := "Production Bom Line".Description;
        "Prod Bom Tree Rec".Quantity := Abs("Sales Quantity" * "Production Bom Line"."Quantity per");
        "Prod Bom Tree Rec"."Quantity Per" := "Production Bom Line"."Quantity per";
        "Prod Bom Tree Rec"."Bom Bool" := "Line Bool Para";
        "Prod Bom Tree Rec".Modify(true);
        CurrPage.Update(true);
    end;

    procedure Parent(ItemRecPara: code[20])
    begin
        "Bom Line Rec".SetRange("Production BOM No.", ItemRecPara);
        if "Bom Line Rec".FindSet() then
            repeat
                Clear(SendingIndent);
                if not "Bom Line Rec".FindLast() then
                    SendingIndent := 0;

                InsertingLine("Bom Line Rec"."No.", false);
            until "Bom Line Rec".Next = 0;
        Child();

    end;

    procedure Child()
    var
        "Prod Bom Tree Rec 2": Record "Production Bom Tree";
    begin
        "Prod Bom Tree Rec 2".SetRange("Bom Bool", false);
        if "Prod Bom Tree Rec 2".FindSet() then begin
            repeat
                "Prod Bom Tree Rec 2"."Bom Bool" := true;
                "Prod Bom Tree Rec 2".Modify();
                "Bom Line Rec".SetRange("Production BOM No.", "Prod Bom Tree Rec 2"."Item No.");
                if "Bom Line Rec".FindSet() then begin
                    Parent("Prod Bom Tree Rec 2"."Item No.");
                    Child();
                end;
            until "Prod Bom Tree Rec 2".Next = 0;
        end
        else
            exit;
    end;

    procedure InsertingProductionBom(itemrecpara: Code[20]; QuantityRecpara: Decimal)
    var
        ProductionOrder: Record "Production Order";
        ProdOrderDirection: Option Forward,Backward;
        CreateProdOrderLines: Codeunit "Create Prod. Order Lines";
    begin
        CLEAR(ProductionOrder);
        ProductionOrder.INIT;
        ProductionOrder.VALIDATE("No.", '');
        ProductionOrder.VALIDATE(Status, ProductionOrder.Status::Released);
        ProductionOrder.INSERT(TRUE);
        ProductionOrder.VALIDATE("Source Type", ProductionOrder."Source Type"::Item);
        ProductionOrder.VALIDATE("Source No.", itemrecpara);
        ProductionOrder.VALIDATE(Quantity, QuantityRecpara);
        ProductionOrder.MODIFY(TRUE);
        CreateProdOrderLines.Copy(ProductionOrder, ProdOrderDirection::Forward, '', FALSE);
        DummyProdOrderNo := ProductionOrder."No.";
    end;

}