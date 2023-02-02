tableextension 80069 "BA Item Ledger Entry" extends "Item Ledger Entry"
{
    fields
    {
        field(80000; "BA Year-end Adjst."; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Year-end Inventory Adjustment';
            Editable = false;
        }
    }
}