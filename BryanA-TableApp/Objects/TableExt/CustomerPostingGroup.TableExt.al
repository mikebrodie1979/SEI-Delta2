tableextension 80025 "BA Cust. Posting Group" extends "Customer Posting Group"
{
    fields
    {
        field(80000; "BA Blocked"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Blocked';
        }
        field(80001; "BA Show Non-Local Currency"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Show Non-Local Currency';
        }
    }
}