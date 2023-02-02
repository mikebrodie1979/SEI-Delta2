pageextension 80081 "BA Cross Reference List" extends "Cross Reference List"
{
    layout
    {
        addafter("Cross-Reference Type No.")
        {
            field("BA Cross Refernce Type Name"; "BA Cross Refernce Type Name")
            {
                ApplicationArea = all;
            }
        }
        addlast(Control1)
        {
            field("BA Default Cross Refernce No."; "BA Default Cross Refernce No.")
            {
                ApplicationArea = all;
            }
        }
    }
}