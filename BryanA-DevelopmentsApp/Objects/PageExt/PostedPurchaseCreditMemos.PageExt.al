pageextension 80013 "BA Posted Purch. Cr.Memos" extends "Posted Purchase Credit Memos"
{

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