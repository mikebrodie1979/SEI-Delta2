pageextension 80091 "BA Item Ledger Entries" extends "Item Ledger Entries"
{
    layout
    {
        addlast(Control1)
        {
            field("BA Year-end Adjst."; "BA Year-end Adjst.")
            {
                ApplicationArea = all;
            }
        }
    }
}