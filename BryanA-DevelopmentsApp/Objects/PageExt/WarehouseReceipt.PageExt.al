pageextension 80134 "BA Warehouse Receipt" extends "Warehouse Receipt"
{
    layout
    {
        modify("Location Code")
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                Subscribers: Codeunit "BA SEI Subscibers";
            begin
                Text := Subscribers.LocationListLookup(true);
                exit(Text <> '');
            end;
        }
    }
}