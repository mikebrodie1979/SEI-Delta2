pageextension 80135 "BA Company Information" extends "Company Information"
{
    layout
    {
        modify("System Indicator Text")
        {
            ApplicationArea = all;
            Editable = false;
        }
        // addlast("System Indicator")
        // {
        //     field("BA Environment Name"; Rec."BA Environment Name")
        //     {
        //         ApplicationArea = all;
        //         ShowMandatory = true;
        //     }
        // }
    }
}