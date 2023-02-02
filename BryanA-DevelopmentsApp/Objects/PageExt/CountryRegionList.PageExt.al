pageextension 80065 "BA Country/Region List" extends "Countries/Regions"
{
    Caption = 'Countries';

    layout
    {
        addafter(Name)
        {
            field("BA Region"; Rec."BA Region")
            {
                ApplicationArea = all;
            }
        }
    }
}