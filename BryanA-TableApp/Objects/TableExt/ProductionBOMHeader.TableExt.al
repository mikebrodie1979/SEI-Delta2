tableextension 80070 "BA Prod. BOM Header" extends "Production BOM Header"
{
    fields
    {
        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                CalcFields("BA Item Gen. Posting Group", "BA Item Manufacturing Policy", "BA Item Replenishment System");
            end;
        }
        field(80000; "BA Item Replenishment System"; Option)
        {
            Caption = 'Replenishment System';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup (Item."Replenishment System" where ("No." = field ("No.")));
            OptionMembers = "Purchase","Prod. Order","","Assembly";
            OptionCaption = 'Purchase,Prod. Order,,Assembly';
        }
        field(80001; "BA Item Manufacturing Policy"; Option)
        {
            Caption = 'Manufacturing Policy';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup (Item."Manufacturing Policy" where ("No." = field ("No.")));
            OptionMembers = "Make-to-Stock","Make-to-Order";
            OptionCaption = 'Make-to-Stock,Make-to-Order';
        }
        field(80002; "BA Item Gen. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup (Item."Gen. Prod. Posting Group" where ("No." = field ("No.")));
        }
    }
}