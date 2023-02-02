tableextension 81001 "BA Customer Ext." extends Customer
{
    fields
    {
        modify("Country/Region Code")
        {
            Caption = 'Country';
        }
        modify("ENC Country/Region Mandatory")
        {
            Caption = 'Country Mandatory';
        }
    }
}