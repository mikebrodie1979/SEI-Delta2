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
        modify("Location Code")
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                Subscribers: Codeunit "BA SEI Subscibers";
            begin
                Text := Subscribers.LocationListLookup();
                exit(Text <> '');
            end;
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