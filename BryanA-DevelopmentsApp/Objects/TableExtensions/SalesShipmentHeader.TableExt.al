tableextension 81008 "BA Sales Shpt. Header Ext." extends "Sales Shipment Header"
{
    fields
    {
        modify("Bill-to Country/Region Code")
        {
            Caption = 'Bill-to Country';
        }
        modify("Sell-to Country/Region Code")
        {
            Caption = 'Sell-to Country';
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