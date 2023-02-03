pageextension 80135 "BA No. Series Lines" extends "No. Series Lines"
{
    layout
    {
        addafter(Open)
        {
            field("BA Replacement"; "BA Replacement")
            {
                ApplicationArea = all;
            }
            field("BA Replacement DateTime"; "BA Replacement DateTime")
            {
                ApplicationArea = all;
            }
        }
    }
}