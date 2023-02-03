pageextension 80131 "BA Location List" extends "Location List"
{
    layout
    {
        addlast(Control1)
        {
            field("BA Inactive"; Rec."BA Inactive")
            {
                ApplicationArea = all;
            }
        }
    }
}