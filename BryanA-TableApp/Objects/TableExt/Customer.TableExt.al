tableextension 80030 "BA Customer" extends Customer
{
    fields
    {
        field(80000; "BA Int. Customer"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Sales BBD Fields Mandatory';
        }
        field(80001; "BA Serv. Int. Customer"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Service BBD Fields Mandatory';
        }
        field(80010; "BA Region"; Text[30])
        {
            Caption = 'Region';
            FieldClass = FlowField;
            CalcFormula = lookup ("Country/Region"."BA Region" where (Code = field ("Country/Region Code")));
            Editable = false;
        }
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
        modify("Country/Region Code")
        {
            trigger OnAfterValidate()
            begin
                if "Country/Region Code" = '' then
                    "BA Region" := ''
                else
                    Rec.CalcFields("BA Region");
            end;
        }

        field(80020; "BA Outstanding Serv. Orders"; Decimal)
        {
            Caption = 'Outstanding Serv. Orders';
            FieldClass = FlowField;
            CalcFormula = Sum ("Service Line"."Outstanding Amount" WHERE ("Document Type" = CONST (Order), "Bill-to Customer No." = FIELD ("No."),
            "Shortcut Dimension 1 Code" = FIELD ("Global Dimension 1 Filter"), "Shortcut Dimension 2 Code" = FIELD ("Global Dimension 2 Filter"),
            "Currency Code" = FIELD ("Currency Filter")));
            Editable = false;
        }
        field(80021; "BA Serv Shipped Not Invoiced"; Decimal)
        {
            Caption = 'Serv Shipped Not Invoiced';
            FieldClass = FlowField;
            CalcFormula = Sum ("Service Line"."Shipped Not Invoiced" WHERE ("Document Type" = CONST (Order), "Bill-to Customer No." = FIELD ("No."),
            "Shortcut Dimension 1 Code" = FIELD ("Global Dimension 1 Filter"), "Shortcut Dimension 2 Code" = FIELD ("Global Dimension 2 Filter"),
            "Currency Code" = FIELD ("Currency Filter")));
            Editable = false;
        }
        field(80022; "BA Outstanding Serv.Invoices"; Decimal)
        {
            Caption = 'Outstanding Serv.Invoices';
            FieldClass = FlowField;
            CalcFormula = Sum ("Service Line"."Outstanding Amount" WHERE ("Document Type" = CONST (Invoice), "Bill-to Customer No." = FIELD ("No."),
                "Shortcut Dimension 1 Code" = FIELD ("Global Dimension 1 Filter"), "Shortcut Dimension 2 Code" = FIELD ("Global Dimension 2 Filter"),
                "Currency Code" = FIELD ("Currency Filter")));
            Editable = false;
        }
        field(80025; "BA Credit Limit"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Credit Limit';
        }
        field(80026; "BA Credit Limit Last Updated"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Credit Limit Last Updated';
            Editable = false;
        }
        field(80027; "BA Credit Limit Updated By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Credit Limit Updated By';
            Editable = false;
            TableRelation = "User Setup"."User ID";
            ValidateTableRelation = false;
        }
    }
}