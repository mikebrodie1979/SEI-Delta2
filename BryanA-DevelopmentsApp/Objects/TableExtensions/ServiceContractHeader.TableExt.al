tableextension 81014 "BA Service Con. Header Ext." extends "Service Contract Header"
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
    }
}