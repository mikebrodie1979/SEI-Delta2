tableextension 80027 "BA BBD Sell-To" extends "ENC BBD Sell-To"
{
    fields
    {
        field(80000; "BA Address"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Address';
        }
        field(80001; "BA Address 2"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Address 2';
        }
        field(80002; "BA City"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'City';
        }
        field(80003; "BA County"; Code[2])
        {
            DataClassification = CustomerContent;
            TableRelation = "BA Province/State".Symbol where ("Country/Region Code" = field ("BA Country/Region Code"));
            CaptionClass = '5,1,' + "BA Country/Region Code";
        }
        field(80004; "BA Country/Region Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Country/Region".Code;
            Caption = 'Country/Region Code';
        }
        field(80005; "BA Postal/Zip Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Postal/Zip Code';
        }
        field(80006; "BA Phone No."; Text[30])
        {
            DataClassification = CustomerContent;
            ExtendedDatatype = PhoneNo;
            Caption = 'Phone No.';
        }
        field(80007; "BA Contact"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Contact';
        }
    }
}