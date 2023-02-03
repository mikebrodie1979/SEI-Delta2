pageextension 80139 "BA Sales Return Subpage" extends "Sales Return Order Subform"
{
    layout
    {
        modify("Location Code")
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                Subscribers: Codeunit "BA SEI Subscibers";
            begin
                Text := Subscribers.LocationListLookup();
                exit(Text <> '');
            end;
        }
    }
}