tableextension 80013 "BA Currency" extends Currency
{
    fields
    {
        field(80000; "BA Local Purchase Cost"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Local Purchase Cost';
        }
    }
}