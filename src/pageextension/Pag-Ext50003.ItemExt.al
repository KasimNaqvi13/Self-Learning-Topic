pageextension 50003 "Item Ext" extends "Item Card"
{
    layout
    {

    }

    actions
    {
        addlast(RequestApproval)
        {

            action("Import & Export items")
            {
                ApplicationArea = all;
                trigger OnAction()
                var
                    "Import export item": XmlPort ExportItemsXmlPort;
                begin
                    "Import export item".Run();
                end;
            }
        }
    }



}

