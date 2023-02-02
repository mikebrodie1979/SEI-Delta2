pageextension 80060 "BA Released Prod. Order Lines" extends "Released Prod. Order Lines"
{
    layout
    {
        modify("Item No.")
        {
            ApplicationArea = all;
            trigger OnAfterValidate()
            begin
                CalcFields("BA Default Cross-Ref. No.", "BA Default Vendor No.");
            end;
        }
        addafter("Item No.")
        {
            field("BA Default Vendor No."; "BA Default Vendor No.")
            {
                ApplicationArea = all;
            }
            field("BA Default Cross-Ref. No."; "BA Default Cross-Ref. No.")
            {
                ApplicationArea = all;
            }
            field("BA NC Work Completed"; "BA NC Work Completed")
            {
                ApplicationArea = all;
            }
        }
    }
}