pageextension 50001 "General Ledger Setup Ext" extends "General Ledger Setup"
{
    layout
    {
        addafter("Shortcut Dimension 8 Code")
        {
            field("Shortcut Dimension 9 Code "; Rec."Shortcut Dimension 9 Code")
            {
                ApplicationArea = all;
            }
        }
    }
}
