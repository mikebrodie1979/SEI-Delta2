pageextension 80023 "BA Released Prod. Order" extends "Released Production Order"
{
    layout
    {
        addafter(Blocked)
        {
            field("BA NC Work Completed"; "BA NC Work Completed")
            {
                ApplicationArea = all;
            }
            field("BA All Quantities Completed"; "BA All Quantities Completed")
            {
                ApplicationArea = all;
            }
        }
        addafter("Source No.")
        {
            field("BA Source Version"; Rec."BA Source Version")
            {
                ApplicationArea = all;
            }
        }
    }
}