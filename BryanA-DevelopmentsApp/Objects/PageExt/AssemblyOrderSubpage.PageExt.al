pageextension 80003 "BA Assembly Order Subpage" extends "Assembly Order Subform"
{
    layout
    {
        addafter(Description)
        {
            field("BA Optional"; "BA Optional")
            {
                ApplicationArea = all;
            }
        }
    }
}