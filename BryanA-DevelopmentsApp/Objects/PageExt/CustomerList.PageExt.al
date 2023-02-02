pageextension 80083 "BA Customer List" extends "Customer List"
{
    layout
    {
        addafter("Credit Limit (LCY)")
        {
            field("BA Credit Limit"; Rec."BA Credit Limit")
            {
                ApplicationArea = all;
            }
        }
    }
}