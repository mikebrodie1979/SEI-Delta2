pageextension 80122 "BA Posted Sales Shipments" extends "Posted Sales Shipments"
{
    trigger OnOpenPage()
    begin
        Rec.FilterGroup(2);
        Rec.SetRange("BA Has Non-G/L Lines", true);
        Rec.SetRange("BA Has Only Empty Lines", false);
        Rec.FilterGroup(0);
    end;
}