pageextension 80076 "BA Sales Quote Subpage" extends "Sales Quote Subform"
{
    layout
    {
        addafter("Total Amount Incl. VAT")
        {
            field("BA Exchange Rate"; ExchageRate)
            {
                ApplicationArea = all;
                Editable = false;
                BlankZero = true;
                ToolTip = 'Specifies the exchange rate used to calculate prices for item sales lines.';
                Caption = 'Exchange Rate';
            }
        }
    }


    trigger OnAfterGetRecord()
    var
        SalesHeader: Record "Sales Header";
    begin
        if SalesHeader.Get(Rec."Document Type", rec."Document No.") then
            ExchageRate := SalesHeader."BA Quote Exch. Rate";
    end;

    procedure SetExchangeRate(NewExchangeRate: Decimal)
    begin
        ExchageRate := NewExchangeRate;
    end;

    var
        ExchageRate: Decimal;
}