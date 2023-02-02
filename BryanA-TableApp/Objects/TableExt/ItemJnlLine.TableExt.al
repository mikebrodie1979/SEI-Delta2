tableextension 80049 "BA Item Jnl. Line" extends "Item Journal Line"
{
    fields
    {
        field(80000; "BA Updated"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
            Editable = false;
            Description = 'System field used for Physical Inventory import';
        }
        field(80001; "BA Created At"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Created At';
            Editable = false;
        }
        field(80002; "BA Warning Message"; Text[256])
        {
            DataClassification = CustomerContent;
            Caption = 'Warning Message';
            Editable = false;
        }
    }
}