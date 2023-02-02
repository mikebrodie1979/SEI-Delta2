tableextension 81016 "BA Ship-to Address" extends "Ship-to Address"
{
    fields
    {
        modify("Country/Region Code")
        {
            Caption = 'Country';
        }
        modify("Shipment Method Code")
        {
            Caption = 'Freight Carrier';
            TableRelation = "Shipment Method".Code where ("ENC Sales" = const (true));
        }
        modify("Shipping Agent Code")
        {
            Caption = 'Service Level';
            TableRelation = "Shipping Agent".Code;
        }
        modify("Shipping Agent Service Code")
        {
            Caption = 'Freight Term';
            TableRelation = "ENC Freight Term".Code;
        }
        modify(County)
        {
            TableRelation = "BA Province/State".Symbol where ("Country/Region Code" = field ("Country/Region Code"));
        }
    }

    procedure ShipmentMethodCodeLookup()
    var
        ShipmentMethod: Record "Shipment Method";
    begin
        ShipmentMethod.SetRange("ENC Sales", true);
        if Page.RunModal(Page::"Shipment Methods", ShipmentMethod) = Action::LookupOK then
            Validate("Shipment Method Code", ShipmentMethod.Code);
    end;
}