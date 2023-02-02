pageextension 80044 "BA User Setup" extends "User Setup"
{
    layout
    {
        addlast(Control1)
        {
            field("BA Job Title"; Rec."BA Job Title")
            {
                ApplicationArea = all;
            }
            field("BA Allow Changing Counties"; "BA Allow Changing Counties")
            {
                ApplicationArea = all;
            }
            field("BA Allow Changing Regions"; "BA Allow Changing Regions")
            {
                ApplicationArea = all;
            }
            field("BA Allow Changing Countries"; "BA Allow Changing Countries")
            {
                ApplicationArea = all;
            }
        }
    }
}