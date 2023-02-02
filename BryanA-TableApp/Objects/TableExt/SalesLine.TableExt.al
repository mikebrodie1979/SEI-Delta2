tableextension 80002 "BA Sales Line" extends "Sales Line"
{
    fields
    {
        field(80000; "BA Org. Qty. To Ship"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Original Qty. to Ship';
            Editable = false;
        }
        field(80001; "BA Org. Qty. To Invoice"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Original Qty. to Invoice';
            Editable = false;
        }
        field(80002; "BA Stage"; Option)
        {
            FieldClass = FlowField;
            CalcFormula = lookup ("Sales Header"."ENC Stage" where ("Document Type" = field ("Document Type"), "No." = field ("Document No.")));
            Caption = 'Stage';
            Editable = false;
            OptionMembers = " ","Open","Closed/Lost","Closed/Other","Archive";
        }
    }
}