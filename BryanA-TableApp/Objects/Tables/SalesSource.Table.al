table 75013 "BA Sales Source"
{
    Caption = 'Sales Source';
    DataClassification = CustomerContent;

    fields
    {
        field(1; Name; Text[30])
        {
            DataClassification = CustomerContent;
            NotBlank = true;
        }
    }

    keys
    {
        key(k1; Name)
        {
            Clustered = true;
        }
    }
}