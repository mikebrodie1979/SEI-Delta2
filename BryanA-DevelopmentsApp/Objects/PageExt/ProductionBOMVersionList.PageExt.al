pageextension 80107 "BA Production BOM Version List" extends "Prod. BOM Version List"
{
    layout
    {
        addlast(Control1)
        {
            field("BA Item Gen. Posting Group"; "BA Item Gen. Posting Group")
            {
                ApplicationArea = all;
            }
            field("BA Item Manufacturing Policy"; "BA Item Manufacturing Policy")
            {
                ApplicationArea = all;
            }
            field("BA Item Replenishment System"; "BA Item Replenishment System")
            {
                ApplicationArea = all;
            }
        }
    }
}