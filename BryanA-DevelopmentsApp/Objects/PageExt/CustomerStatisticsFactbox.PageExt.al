Pageextension 80110 "BA Cust. Statistics Factbox" extends "Customer Statistics FactBox"
{
    layout
    {
        modify("No.")
        {
            ApplicationArea = all;
            Visible = false;
        }
        modify("Balance (LCY)")
        {
            ApplicationArea = all;
            Visible = false;
        }
        modify(Sales)
        {
            Visible = false;
        }
        modify(Service)
        {
            Visible = false;
        }
        modify(Payments)
        {
            Visible = false;
        }
        modify("Total (LCY)")
        {
            ApplicationArea = all;
            Visible = false;
        }
        modify("Credit Limit (LCY)")
        {
            ApplicationArea = all;
            Visible = false;
        }
        modify("Balance Due (LCY)")
        {
            ApplicationArea = all;
            Visible = false;
        }
        modify("Sales (LCY)")
        {
            ApplicationArea = all;
            Visible = false;
        }
        modify(GetInvoicedPrepmtAmountLCY)
        {
            ApplicationArea = all;
            Visible = false;
        }


        addlast(Content)
        {
            group("Non-LCY Details")
            {
                ShowCaption = false;
                Visible = not ShowLCYBalances;

                field("No.2"; Rec."No.")
                {
                    ApplicationArea = all;
                    Caption = 'Customer No.';
                    ToolTip = 'Specifies the number of the customer. The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';

                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::"Customer Card", Rec);
                    end;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the payment amount that the customer owes for completed sales. This value is also known as the customer''s balance.';

                    trigger OnDrillDown()
                    begin
                        BalanceDrillDown();
                    end;
                }
            }
            group(SalesNonLCY)
            {
                Caption = 'Sales';
                Visible = not ShowLCYBalances;
                field("Outstanding Orders NonLCY"; Rec."Outstanding Orders")
                {
                    ApplicationArea = all;
                    Caption = 'Outstanding Orders';
                    ToolTip = 'Specifies your expected sales income from the customer based on ongoing sales orders.';
                }
                field("Shipped Not Invoiced NonLCY"; Rec."Shipped Not Invoiced")
                {
                    ApplicationArea = all;
                    Caption = 'Shipped Not Invoiced';
                    ToolTip = 'Specifies your expected sales income from the customer based on ongoing sales orders where items have been shipped.';
                }
                field("Outstanding Invoices NonLCY"; Rec."Outstanding Invoices")
                {
                    ApplicationArea = all;
                    Caption = 'Outstanding Invoices';
                    ToolTip = 'Specifies your expected sales income from the customer based on unpaid sales invoices.';
                }
            }
            group(ServicesNonLCY)
            {
                Caption = 'Services';
                Visible = not ShowLCYBalances;
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
            }
            group(PaymentsGroupNonLCY)
            {
                Caption = 'Payments';
                Visible = not ShowLCYBalances;
                field(PaymentsNonLCY; Rec.Payments)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the sum of payments received from the customer.';
                    Caption = 'Payments';
                }
                field(RefundsNonLCY; Rec.Refunds)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the sum of refunds received from the customer.';
                    Caption = 'Refunds';
                }
                field("Last Receipt Payment Date NonLCY"; NonLCYCustStatFactbox.CalcLastPaymentDate())
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the posting date of the last payment received from the customer.';
                    Caption = 'Last Receipt Payment Date';

                    trigger OnDrillDown()
                    var
                        CustLedgerEntry: Record "Cust. Ledger Entry";
                        CustomerLedgerEntries: Page "Customer Ledger Entries";
                    begin
                        CLEAR(CustomerLedgerEntries);
                        NonLCYCustStatFactbox.SetFilterLastPaymentDateEntry(CustLedgerEntry);
                        IF CustLedgerEntry.FINDLAST THEN
                            CustomerLedgerEntries.SETRECORD(CustLedgerEntry);
                        CustomerLedgerEntries.SETTABLEVIEW(CustLedgerEntry);
                        CustomerLedgerEntries.Run;
                    end;
                }
            }
            group("Non-LCY")
            {
                Visible = not ShowLCYBalances;
                ShowCaption = false;
                field(GetTotalAmountNonLCY; NonLCYCustStatFactbox.GetTotalAmount(Rec))
                {
                    Caption = 'Total';
                    // Visible = not ShowLCYBalances;
                    ApplicationArea = all;
                    Style = Strong;
                    ToolTip = 'Specifies the payment amount that the customer owes for completed sales plus sales that are still ongoing.';
                }
                field("Credit LimitNonLCY"; Rec."BA Credit Limit")
                {
                    ApplicationArea = all;
                    // Visible = not ShowLCYBalances;
                    Caption = 'Credit Limit';
                    ToolTip = 'Specifies the maximum amount you allow the customer to exceed the payment balance before warnings are issued.';
                }
                field(CalcOverdueBalanceNonLCY; NonLCYCustStatFactbox.CalcOverdueBalanceNonLCY())
                {
                    ApplicationArea = all;
                    // Visible = not ShowLCYBalances;
                    Caption = 'Overdue Amount';

                    trigger OnDrillDown()
                    var
                        CustLedgEntry: Record "Cust. Ledger Entry";
                        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
                    begin
                        DtldCustLedgEntry.SETFILTER("Customer No.", Rec."No.");
                        CopyFilter("Global Dimension 1 Filter", DtldCustLedgEntry."Initial Entry Global Dim. 1");
                        CopyFilter("Global Dimension 2 Filter", DtldCustLedgEntry."Initial Entry Global Dim. 2");
                        CopyFilter("Currency Filter", DtldCustLedgEntry."Currency Code");
                        CustLedgEntry.DrillDownOnOverdueEntries(DtldCustLedgEntry);
                    end;
                }
                field(GetSalesNonLCY; NonLCYCustStatFactbox.GetSales(Rec))
                {
                    ApplicationArea = all;
                    Visible = not ShowLCYBalances;
                    Caption = 'Total Sales';
                    ToolTip = 'Specifies your total sales turnover with the customer in the current fiscal year. It is calculated from amounts excluding tax on all completed and open sales invoices and credit memos.';

                    trigger OnDrillDown()
                    var
                        CustLedgEntry: Record "Cust. Ledger Entry";
                        AccountingPeriod: Record "Accounting Period";
                    begin
                        CustLedgEntry.SetRange("Customer No.", Rec."No.");
                        CustLedgEntry.SetRange("Posting Date", AccountingPeriod.GetFiscalYearStartDate(WORKDATE),
                            AccountingPeriod.GetFiscalYearEndDate(WORKDATE));
                        Page.RunMODAL(Page::"Customer Ledger Entries", CustLedgEntry);
                    end;
                }
                field(GetInvoicedPrepmtAmountNonLCY; NonLCYCustStatFactbox.GetInvoicedPrepmtAmount(Rec."No."))
                {
                    ApplicationArea = all;
                    Visible = not ShowLCYBalances;
                    Caption = 'Invoiced Prepayment Amount';
                    ToolTip = 'Specifies your sales income from the customer, based on invoiced prepayments.';
                }
            }


            group("LCY Details")
            {
                ShowCaption = false;
                Visible = ShowLCYBalances;
                field("No.3"; Rec."No.")
                {
                    ApplicationArea = all;
                    Caption = 'Customer No.';
                    ToolTip = 'Specifies the number of the customer. The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';
                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::"Customer Card", Rec);
                    end;
                }
                field("Balance (LCY)2"; Rec."Balance (LCY)")
                {
                    ApplicationArea = all;
                    Caption = 'Balance ($)';
                    ToolTip = 'Specifies the payment amount that the customer owes for completed sales. This value is also known as the customer''s balance.';

                    trigger OnDrillDown()
                    begin
                        BalanceDrillDown();
                    end;
                }
            }
            group(SalesLCY)
            {
                Caption = 'Sales';
                Visible = ShowLCYBalances;
                field("Outstanding Orders LCY"; Rec."Outstanding Orders (LCY)")
                {
                    ApplicationArea = all;
                    Caption = 'Outstanding Orders ($)';
                    ToolTip = 'Specifies your expected sales income from the customer based on ongoing sales orders.';
                }
                field("Shipped Not Invoiced LCY"; Rec."Shipped Not Invoiced (LCY)")
                {
                    ApplicationArea = all;
                    Caption = 'Shipped Not Invoiced ($)';
                    ToolTip = 'Specifies your expected sales income from the customer based on ongoing sales orders where items have been shipped.';
                }
                field("Outstanding Invoices LCY"; Rec."Outstanding Invoices (LCY)")
                {
                    ApplicationArea = all;
                    Caption = 'Outstanding Invoices ($)';
                    ToolTip = 'Specifies your expected sales income from the customer based on unpaid sales invoices.';
                }
            }
            group(ServicesLCY)
            {
                Caption = 'Services';
                Visible = ShowLCYBalances;
                field("Outstanding Serv. Orders"; Rec."Outstanding Serv. Orders (LCY)")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies your expected service income from the customer based on ongoing service orders.';
                }
                field("Serv Shipped Not Invoiced"; Rec."Serv Shipped Not Invoiced(LCY)")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies your expected service income from the customer based on service orders that are shipped but not invoiced.';
                }
                field("Outstanding Serv.Invoices"; Rec."Outstanding Serv.Invoices(LCY)")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies your expected service income from the customer based on unpaid service invoices.';
                }
            }
            group(PaymentsGroupLCY)
            {
                Caption = 'Payments';
                Visible = ShowLCYBalances;
                field(PaymentsLCY; Rec."Payments (LCY)")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the sum of payments received from the customer.';
                    Caption = 'Payments ($)';
                }
                field(RefundsLCY; Rec."Refunds (LCY)")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the sum of refunds received from the customer.';
                    Caption = 'Refunds ($)';
                }
                field("Last Receipt Payment Date LCY"; NonLCYCustStatFactbox.CalcLastPaymentDate())
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the posting date of the last payment received from the customer.';
                    Caption = 'Last Receipt Payment Date';

                    trigger OnDrillDown()
                    var
                        CustLedgerEntry: Record "Cust. Ledger Entry";
                        CustomerLedgerEntries: Page "Customer Ledger Entries";
                    begin
                        CLEAR(CustomerLedgerEntries);
                        NonLCYCustStatFactbox.SetFilterLastPaymentDateEntry(CustLedgerEntry);
                        IF CustLedgerEntry.FINDLAST THEN
                            CustomerLedgerEntries.SETRECORD(CustLedgerEntry);
                        CustomerLedgerEntries.SETTABLEVIEW(CustLedgerEntry);
                        CustomerLedgerEntries.Run;
                    end;
                }
            }
            group("LCY")
            {
                Visible = ShowLCYBalances;
                ShowCaption = false;
                field(GetTotalAmountLCY; Rec.GetTotalAmountLCY())
                {
                    Caption = 'Total ($)';
                    ApplicationArea = all;
                    Style = Strong;
                    // Visible = ShowLCYBalances;
                    ToolTip = 'Specifies the payment amount that the customer owes for completed sales plus sales that are still ongoing.';
                }
                field("Credit LimitLCY"; Rec."Credit Limit (LCY)")
                {
                    ApplicationArea = all;
                    // Visible = ShowLCYBalances;
                    Caption = 'Credit Limit ($)';
                    ToolTip = 'Specifies the maximum amount you allow the customer to exceed the payment balance before warnings are issued.';
                }
                field(CalcOverdueBalanceLCY; Rec.CalcOverdueBalance())
                {
                    ApplicationArea = all;
                    // Visible = ShowLCYBalances;
                    Caption = 'Overdue Amount ($)';

                    trigger OnDrillDown()
                    var
                        CustLedgEntry: Record "Cust. Ledger Entry";
                        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
                    begin
                        DtldCustLedgEntry.SETFILTER("Customer No.", Rec."No.");
                        CopyFilter("Global Dimension 1 Filter", DtldCustLedgEntry."Initial Entry Global Dim. 1");
                        CopyFilter("Global Dimension 2 Filter", DtldCustLedgEntry."Initial Entry Global Dim. 2");
                        CopyFilter("Currency Filter", DtldCustLedgEntry."Currency Code");
                        CustLedgEntry.DrillDownOnOverdueEntries(DtldCustLedgEntry);
                    end;
                }
                field(GetSalesLCY; Rec.GetSalesLCY())
                {
                    ApplicationArea = all;
                    // Visible = ShowLCYBalances;
                    Caption = 'Total Sales ($)';
                    ToolTip = 'Specifies your total sales turnover with the customer in the current fiscal year. It is calculated from amounts excluding tax on all completed and open sales invoices and credit memos.';

                    trigger OnDrillDown()
                    var
                        CustLedgEntry: Record "Cust. Ledger Entry";
                        AccountingPeriod: Record "Accounting Period";
                    begin
                        CustLedgEntry.SetRange("Customer No.", Rec."No.");
                        CustLedgEntry.SetRange("Posting Date", AccountingPeriod.GetFiscalYearStartDate(WORKDATE),
                            AccountingPeriod.GetFiscalYearEndDate(WORKDATE));
                        Page.RunMODAL(Page::"Customer Ledger Entries", CustLedgEntry);
                    end;
                }
                field(GetInvoicedPrepmtAmountLCY2; Rec.GetInvoicedPrepmtAmountLCY())
                {
                    ApplicationArea = all;
                    // Visible = ShowLCYBalances;
                    Caption = 'Invoiced Prepayment Amount ($)';
                    ToolTip = 'Specifies your sales income from the customer, based on invoiced prepayments.';
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        ShowLCYBalances := NonLCYCustStatFactbox.ShouldUseNonLCYValues(Rec);
    end;

    var
        NonLCYCustStatFactbox: Page "BA Non-LCY Cust. Stat. Factbox";
        [InDataSet]
        ShowLCYBalances: Boolean;

    local procedure BalanceDrillDown()
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
    begin
        DtldCustLedgEntry.SetRange("Customer No.", "No.");
        Rec.CopyFilter("Global Dimension 1 Filter", DtldCustLedgEntry."Initial Entry Global Dim. 1");
        Rec.CopyFilter("Global Dimension 2 Filter", DtldCustLedgEntry."Initial Entry Global Dim. 2");
        Rec.CopyFilter("Currency Filter", DtldCustLedgEntry."Currency Code");
        CustLedgEntry.DrillDownOnEntries(DtldCustLedgEntry);
    end;
}
