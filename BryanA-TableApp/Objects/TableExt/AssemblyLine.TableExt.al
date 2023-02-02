tableextension 80005 "BA Assembly Line" extends "Assembly Line"
{
    fields
    {
        field(80000; "BA Optional"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Optional';
            Editable = false;
        }
    }
}