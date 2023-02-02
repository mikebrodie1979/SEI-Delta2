tableextension 81005 "BA Vendor Ext." extends Vendor
{
    fields
    {
        modify("Country/Region Code")
        {
            Caption = 'Country';
        }
    }
}