tableextension 80081 "BA Sales Cr.Memo Line" extends "Sales Cr.Memo Line"
{
    fields
    {
        field(80010; "BA Omit from Reports"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Omit From Reports';
        }
    }
}