pageextension 80043 "BA Cust. Posting Groups" extends "Customer Posting Groups"
{
    layout
    {
        addlast(Control1)
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