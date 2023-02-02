pageextension 80048 "BA BDD Sell To List" extends "ENC BBD Sell-To List"
{
    layout
    {
        addlast(Lines)
        {
            field("BA Address"; Rec."BA Address")
            {
                ApplicationArea = all;
            }
            field("BA Address 2"; Rec."BA Address 2")
            {
                ApplicationArea = all;
            }
            field("BA City"; Rec."BA City")
            {
                ApplicationArea = all;
            }
            field("BA Country/Region Code"; Rec."BA Country/Region Code")
            {
                ApplicationArea = all;
            }
            field("BA County"; Rec."BA County")
            {
                ApplicationArea = all;
            }
            field("BA Postal/Zip Code"; Rec."BA Postal/Zip Code")
            {
                ApplicationArea = all;
            }
            field("BA Contact"; Rec."BA Contact")
            {
                ApplicationArea = all;
            }
            field("BA Phone No."; Rec."BA Phone No.")
            {
                ApplicationArea = all;
            }
        }
    }
}