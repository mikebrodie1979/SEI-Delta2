pageextension 80080 "BA Item Cross Ref. Entries" extends "Item Cross Reference Entries"
{
    layout
    {
        modify("Cross-Reference Type No.")
        {
            trigger OnAfterValidate()
            begin
                CalcFields("BA Cross Refernce Type Name");
            end;
        }
        addafter("Cross-Reference Type No.")
        {
            field("BA Cross Refernce Type Name"; "BA Cross Refernce Type Name")
            {
                ApplicationArea = all;
            }
            field("BA Default Cross Refernce No."; "BA Default Cross Refernce No.")
            {
                ApplicationArea = all;
            }
        }
    }
}