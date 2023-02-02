tableextension 80031 "BA Vendor" extends Vendor
{
    fields
    {
        field(80011; "BA County Fullname"; Text[30])
        {
            Caption = 'Province/State Fullname';
            FieldClass = FlowField;
            CalcFormula = lookup ("BA Province/State".Name where ("Print Full Name" = const (true), "Country/Region Code" = field ("Country/Region Code"), Symbol = field (County)));
            Editable = false;
        }
        modify(County)
        {
            TableRelation = "BA Province/State".Symbol where ("Country/Region Code" = field ("Country/Region Code"));
        }
    }
}