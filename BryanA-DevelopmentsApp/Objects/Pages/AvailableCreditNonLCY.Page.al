page 50063 "BA Available Credit Non-LCY"
{
    Caption = 'Available Credit';
    PageType = Card;
    SourceTable = Customer;
    Editable = false;
    LinksAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the payment amount that the customer owes for completed sales. This value is also known as the customer''s balance.';

                    trigger OnDrillDown()
                    var
                        CustLedgEntry: Record "Cust. Ledger Entry";
                        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
                    begin
                        SetFilters(DtldCustLedgEntry);
                        CustLedgEntry.DrillDownOnEntries(DtldCustLedgEntry);
                    end;
                }
                field("Outstanding Orders"; Rec."Outstanding Orders")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies your expected sales income from the customer in $ based on ongoing sales orders.';
                }
                field("Shipped Not Invoiced"; Rec."Shipped Not Invoiced")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies your expected sales income from the customer in $ based on ongoing sales orders where items have been shipped.';
                }
                field("Ret. Rcd. Not Inv."; NonLCYCustomerStatistics.GetReturnRcdNotInvAmount(Rec."No."))
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the amount on sales returns from the customer that are not yet refunded.';
                }
                field("Outstanding Invoices"; Rec."Outstanding Invoices")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies your expected sales income from the customer based on unpaid sales invoices.';
                }
                field("BA Outstanding Serv. Orders"; Rec."BA Outstanding Serv. Orders")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies your expected service income from the customer based on ongoing service orders.';
                }
                field("BA Serv Shipped Not Invoiced"; Rec."BA Serv Shipped Not Invoiced")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies your expected service income from the customer based on service orders that are shipped but not invoiced.';
                }
                field("BA Outstanding Serv.Invoices"; Rec."BA Outstanding Serv.Invoices")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies your expected service income from the customer based on unpaid service invoices.';
                }
                field("Total"; NonLCYCustomerStatistics.GetTotalAmount(Rec))
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the payment amount that you owe the vendor for completed purchases plus purchases that are still ongoing.';
                }
                field("BA Credit Limit"; Rec."BA Credit Limit")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the maximum amount you allow the customer to exceed the payment balance before warnings are issued.';
                    StyleExpr = StyleTxt;
                }
                field("Available Credit"; CustomerDetailsFactbox.CalcAvailableCreditNonLCY(Rec))
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies a customer''s available credit. If the available credit is 0 and the customer''s credit limit is also 0, then the customer has unlimited credit because no credit limit has been defined.';
                }
                field("Balance Due"; Rec."Balance Due")
                {
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    var
                        CustLedgEntry: Record "Cust. Ledger Entry";
                        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
                    begin
                        SetFilters(DtldCustLedgEntry);
                        CustLedgEntry.DrillDownOnOverdueEntries(DtldCustLedgEntry);
                    end;
                }
                field("Invoice Prepayment Amount"; NonLCYCustomerStatistics.GetInvoicedPrepmtAmount(Rec."No."))
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies your sales income from the customer based on invoiced prepayments.';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.SetRange("Date Filter", 0D, WorkDate());
        StyleTxt := '';
        if CustomerDetailsFactbox.CalcAvailableCreditNonLCY(Rec) < 0 then
            StyleTxt := 'Unfavorable';
    end;

    local procedure SetFilters(var DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry")
    begin
        DtldCustLedgEntry.SetFilter("Customer No.", Rec."No.");
        Rec.CopyFilter("Global Dimension 1 Filter", DtldCustLedgEntry."Initial Entry Global Dim. 1");
        Rec.CopyFilter("Global Dimension 2 Filter", DtldCustLedgEntry."Initial Entry Global Dim. 2");
        Rec.CopyFilter("Currency Filter", DtldCustLedgEntry."Currency Code");
    end;

    var
        NonLCYCustomerStatistics: Page "BA Non-LCY Cust. Stat. Factbox";
        CustomerDetailsFactbox: Page "Customer Details FactBox";
        StyleTxt: Text;
}