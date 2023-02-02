pageextension 80140 "BA Posted Sales Shpt. Subpage" extends "Posted Sales Shpt. Subform"
{
    trigger OnOpenPage()
    begin
        Rec.FilterGroup(2);
        Rec.SetFilter(Type, '<>%1', Rec.Type::"G/L Account");
        Rec.FilterGroup(0);
    end;
}