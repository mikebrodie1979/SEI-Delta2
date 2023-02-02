tableextension 80064 "BA Item Cross Ref." extends "Item Cross Reference"
{
    fields
    {
        field(80000; "BA Cross Refernce Type Name"; Text[100])
        {
            Caption = 'Cross Refernce Type Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup (Vendor.Name where ("No." = field ("Cross-Reference Type No.")));
            TableRelation = if ("Cross-Reference Type" = const (Customer))
                Customer.Name where ("No." = field ("Cross-Reference Type No."))
            else
            if ("Cross-Reference Type" = const (Vendor))
                Vendor.Name where ("No." = field ("Cross-Reference Type No."));
        }
        field(80001; "BA Default Cross Refernce No."; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Default Cross Refernce No.';

            trigger OnValidate()
            var
                ItemCrossRef: Record "Item Cross Reference";
            begin
                ItemCrossRef.SetRange("Item No.", Rec."Item No.");
                ItemCrossRef.SetFilter("Cross-Reference No.", '<>%1', Rec."Cross-Reference No.");
                ItemCrossRef.SetRange("BA Default Cross Refernce No.", true);
                if ItemCrossRef.FindFirst() then
                    Error(AlreadyDefaultErr, ItemCrossRef."Cross-Reference No.", ItemCrossRef.FieldCaption("Cross-Reference No."));
            end;
        }
    }

    var
        AlreadyDefaultErr: Label '%1 has already been set as the default %2 value.', Comment = '%1 = Cross Reference No., %2 = Cross-Reference No. caption';
}