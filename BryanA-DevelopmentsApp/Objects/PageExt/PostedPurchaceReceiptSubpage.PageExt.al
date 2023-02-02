pageextension 80020 "BA Posted Purch. Rcpt. Subpage" extends "Posted Purchase Rcpt. Subform"
{
    layout
    {
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