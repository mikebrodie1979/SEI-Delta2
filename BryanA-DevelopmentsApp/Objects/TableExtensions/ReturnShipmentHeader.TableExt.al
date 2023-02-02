tableextension 81011 "BA Ret. Shpt. Header Ext." extends "Return Shipment Header"
{
    fields
    {
        modify("Buy-from Country/Region Code")
        {
            Caption = 'Buy-from Country';
        }
        modify("Pay-to Country/Region Code")
        {
            Caption = 'Pay-to Country';
        }
        modify("Ship-to Country/Region Code")
        {
            Caption = 'Ship-to Country';
        }
        modify("VAT Country/Region Code")
        {
            Caption = 'VAT Country';
        }
    }
}