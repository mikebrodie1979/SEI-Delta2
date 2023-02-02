table 75012 "BA Labour Rate"
{
    DataClassification = CustomerContent;
    Caption = 'SEI International Labour Rate';

    fields
    {
        field(1; Code; Code[15])
        {
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(2; Description; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(3; Rate; Decimal)
        {
            DataClassification = CustomerContent;
            MinValue = 0;
        }
    }

    keys
    {
        key(k1; Code)
        {
            Clustered = true;
        }
    }
}