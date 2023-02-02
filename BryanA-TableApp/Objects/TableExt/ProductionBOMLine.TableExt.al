tableextension 80071 "BA Prod. BOM Line" extends "Production BOM Line"
{
    fields
    {
        field(80000; "BA Default Vendor No."; Code[30])
        {
            Caption = 'Default Vendor No.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup ("Item Cross Reference"."Cross-Reference Type No." where ("Item No." = field ("No."),
                "Cross-Reference Type" = const (Vendor), "Cross-Reference No." = field ("BA Default Cross-Ref. No.")));
        }
        field(80001; "BA Default Cross-Ref. No."; Code[20])
        {
            Caption = 'Default Cross-Ref. No.';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup ("Item Cross Reference"."Cross-Reference No." where ("Item No." = field ("No."),
                "Cross-Reference Type" = const (Vendor), "BA Default Cross Refernce No." = const (true)));
        }
        field(80005; "BA Balloon Position"; BigInteger)
        {
            DataClassification = CustomerContent;
            Caption = 'Balloon Position';
        }
    }
}