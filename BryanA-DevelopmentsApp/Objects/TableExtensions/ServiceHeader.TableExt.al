tableextension 81003 "BA Service Header Ext." extends "Service Header"
{
    fields
    {
        modify("Bill-to Country/Region Code")
        {
            Caption = 'Bill-to Country';
        }
        modify("Country/Region Code")
        {
            Caption = 'Country';
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