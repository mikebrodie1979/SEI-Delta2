pageextension 80002 "BA Assembly BOM" extends "Assembly BOM"
{
    layout
    {
        addlast(Control1)
        {
            field("BA Optional"; "BA Optional")
            {
                ApplicationArea = all;
            }
        }
    }
}