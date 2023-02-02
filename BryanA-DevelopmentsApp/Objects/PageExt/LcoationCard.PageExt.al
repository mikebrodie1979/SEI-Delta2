pageextension 80035 "BA Location Card" extends "Location Card"
{
    layout
    {
        addlast(ContactDetails)
        {
            field("BA FID No."; Rec."BA FID No.")
            {
                ApplicationArea = all;
            }
        }
        addfirst(AddressDetails)
        {
            field("BA Country/Region Code"; "Country/Region Code")
            {
                Caption = 'Country';
                ApplicationArea = all;
            }
        }
        modify("Country/Region Code")
        {
            Visible = false;
            Enabled = false;
            ApplicationArea = all;
        }
    }
}