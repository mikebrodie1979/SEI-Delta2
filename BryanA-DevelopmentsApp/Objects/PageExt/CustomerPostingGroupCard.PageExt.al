pageextension 80047 "BA Cust. Posting Group Card" extends "Customer Posting Group Card"
{
    layout
    {
        addlast(General)
        {
            field("BA Blocked"; Rec."BA Blocked")
            {
                ApplicationArea = all;
            }
            field("BA Show Non-Local Currency"; "BA Show Non-Local Currency")
            {
                ApplicationArea = all;
            }
        }
    }
}