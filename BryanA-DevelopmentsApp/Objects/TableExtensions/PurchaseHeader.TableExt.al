tableextension 81004 "BA Purch. Header Ext." extends "Purchase Header"
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
        //
    }
}