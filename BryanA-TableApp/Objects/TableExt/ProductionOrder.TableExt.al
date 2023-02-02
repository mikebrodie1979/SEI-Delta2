tableextension 80018 "BA Production Order" extends "Production Order"
{
    fields
    {
        field(80000; "BA NC Work Completed"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'NC Work Completed';
        }
        field(80010; "BA All Quantities Completed"; Boolean)
        {
            Caption = 'All Quantites Completed';
            FieldClass = FlowField;
            CalcFormula = - exist ("Prod. Order Line" where ("Prod. Order No." = field ("No."), Status = field (Status), "Remaining Quantity" = filter ('<>0')));
            Editable = false;
        }
    }
}