pageextension 80011 "BA Posted Purch. Rcpts." extends "Posted Purchase Receipts"
{
    layout
    {
        addafter("No.")
        {
            field("Order No."; Rec."Order No.")
            {
                ApplicationArea = all;
            }
        }
    }

    trigger OnOpenPage()
    var
        FilterNo: Integer;
    begin
        FilterNo := Rec.FilterGroup();
        Rec.FilterGroup(2);
        Rec.SetRange("BA Requisition Order", false);
        Rec.FilterGroup(FilterNo);
    end;
}