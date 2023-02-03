pageextension 80155 "BA Warehouse Shpt." extends "Warehouse Shipment"
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