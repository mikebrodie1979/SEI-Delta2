tableextension 80079 "BA No. Series Line" extends "No. Series Line"
{
    fields
    {
        field(80000; "BA Replacement"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Replacement';
            Editable = false;
        }
        field(80001; "BA Replacement DateTime"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Replacement DateTime';
            Editable = false;
        }
    }
}