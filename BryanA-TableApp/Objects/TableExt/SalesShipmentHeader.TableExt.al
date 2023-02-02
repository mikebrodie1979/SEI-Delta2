tableextension 80060 "BA Sales Shpt. Header" extends "Sales Shipment Header"
{
    fields
    {
        field(80011; "BA Sell-to County Fullname"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Province/State Fullname';
            Editable = false;
        }
        field(80012; "BA Bill-to County Fullname"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Province/State Fullname';
            Editable = false;
        }
        field(80013; "BA Ship-to County Fullname"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Province/State Fullname';
            Editable = false;
        }
        field(80020; "BA Has Non-G/L Lines"; Boolean)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = exist ("Sales Shipment Line" where ("Document No." = field ("No."), Type = filter ('<>G/L Account')));
        }
        field(80021; "BA Has Only Empty Lines"; Boolean)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = - exist ("Sales Shipment Line" where ("Document No." = field ("No."), Type = filter ('<>G/L Account'), Quantity = filter ('<>0')));
        }
        field(80025; "BA Sales Source"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Source';
            TableRelation = "BA Sales Source".Name;
            Editable = false;
        }
        field(80026; "BA Web Lead Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Web Lead Date';
            Editable = false;
        }
    }
}