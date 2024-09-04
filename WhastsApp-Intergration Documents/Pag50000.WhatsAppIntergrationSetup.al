
page 50000 "WhatsApp-Intergration Setup"
{
    ApplicationArea = All;
    Caption = 'WhatsApp-Intergration Setup';
    PageType = Card;
    SourceTable = "WhatsApp-Setup";

    layout
    {
        area(Content)
        {
            group("API Credentials")
            {
                field("Account SID"; Rec."Account SID")
                {
                    ApplicationArea = all;
                }
                field("Auth Token"; Rec."Auth Token")
                {
                    ApplicationArea = all;
                }

            }

            group("WhatsApp Number")
            {
                field("From Number"; Rec."From Number")
                {
                    ApplicationArea = all;
                }
                field("To Number "; Rec."To Number ")
                {
                    ApplicationArea = all;
                }
            }
            group("Message Settings")
            {
                field("Message Body"; Rec."Message Body")
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
            action("Save credentials")
            {
                trigger OnAction()
                var
                    HttpClient: HttpClient;
                    HttpRequestMessage: HttpRequestMessage;
                    HttpResponseMessage: HttpResponseMessage;
                    Content: HttpContent;
                    ContentHeader: HttpHeaders;
                    JsonObject: JsonObject;
                    TypeHepler: Codeunit "Type Helper";
                    TextLable: Label 'Body=%1&To-%2&From=%3', Comment = '%1var,%2var,%3var,';
                    Body, Var1, Var2, Var3, Responsetext, Contenttext : text;
                    Convert: Codeunit "Base64 Convert";
                begin

                end;

            }

            action("Send Text Message")
            {
                trigger OnAction()
                var
                    HttpClient: HttpClient;
                    HttpRequestMessage: HttpRequestMessage;
                    HttpResponseMessage: HttpResponseMessage;
                    Content: HttpContent;
                    ContentHeader: HttpHeaders;
                    JsonObject: JsonObject;
                    TypeHepler: Codeunit "Type Helper";
                    TextLable: Label 'Body=%1&To-%2&From=%3', Comment = '%1var,%2var,%3var,';
                    Body, Var1, Var2, Var3, Responsetext, Contenttext : text;
                    Convert: Codeunit "Base64 Convert";
                begin

                end;
            }
        }
    }
}
