pageextension 80010 "BA Currency Card" extends "Currency Card"
{
    layout
    {
        addlast(General)
        {
            field("BA Local Purchase Cost"; "BA Local Purchase Cost")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies if the Currency is to record the last purchase unit cost.';
            }
        }
    }
}