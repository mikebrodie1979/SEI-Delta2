tableextension 80050 "BA Prod. Order Line" extends "Prod. Order Line"
{
    fields
    {
        field(80000; "BA NC Work Completed"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'NC Work Completed';
        }
        field(80010; "BA Default Vendor No."; Code[30])
        {
            Caption = 'Default Vendor No.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup ("Item Cross Reference"."Cross-Reference Type No." where ("Item No." = field ("Item No."),
                "Cross-Reference Type" = const (Vendor), "Cross-Reference No." = field ("BA Default Cross-Ref. No.")));
        }
        field(80011; "BA Default Cross-Ref. No."; Code[20])
        {
            Caption = 'Default Cross-Ref. No.';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup ("Item Cross Reference"."Cross-Reference No." where ("Item No." = field ("Item No."),
                "Cross-Reference Type" = const (Vendor), "BA Default Cross Refernce No." = const (true)));
        }
    }
}