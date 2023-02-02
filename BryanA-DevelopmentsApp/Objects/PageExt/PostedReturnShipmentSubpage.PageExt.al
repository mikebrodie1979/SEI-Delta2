pageextension 80021 "BA Posted Purch. Shpt. Subpage" extends "Posted Return Shipment Subform"
{
    layout
    {
        addfirst(Control1)
        {
            field("Line No."; "Line No.")
            {
                ApplicationArea = all;
            }
        }
        addafter(Quantity)
        {
            field("BA Direct Unit Cost"; Rec."Direct Unit Cost")
            {
                ApplicationArea = all;
            }
            field("BA Line Amount"; "BA Line Amount")
            {
                ApplicationArea = all;
            }
            field("Line Discount %"; Rec."Line Discount %")
            {
                ApplicationArea = all;
            }
            field("BA Line Discount Amount"; Rec."BA Line Discount Amount")
            {
                ApplicationArea = all;
            }
        }
    }

}