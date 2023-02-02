page 50062 "BA Non-LCY Cust. Stat. Factbox"
{
    Caption = 'Customer Statistics Factbox';
    PageType = CardPart;
    SourceTable = Customer;
    Editable = false;
    LinksAllowed = false;

    layout
    {
        area(Content)
        {
            field("No."; Rec."No.")
            {
                ApplicationArea = all;
                Caption = 'Customer No.';
                ToolTip = 'Specifies the number of the customer. The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';

                trigger OnDrillDown()
                begin
                    PAGE.RUN(PAGE::"Customer Card", Rec);
                end;
            }
            field(Balance; Rec.Balance)
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the payment amount that the customer owes for completed sales. This value is also known as the customer''s balance.';
            }
            group(Sales)
            {
                field("Outstanding Orders"; Rec."Outstanding Orders")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies your expected sales income from the customer based on ongoing sales orders.';
                }
                field("Shipped Not Invoiced"; Rec."Shipped Not Invoiced")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies your expected sales income from the customer based on ongoing sales orders where items have been shipped.';
                }
                field("Outstanding Invoices"; Rec."Outstanding Invoices")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies your expected sales income from the customer based on unpaid sales invoices.';
                }
            }
            group(Services)
            {
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
            group(PaymentsGroup)
            {
                Caption = 'Payments';
                field(Payments; Rec.Payments)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the sum of payments received from the customer.';
                }
                field(Refunds; Rec.Refunds)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the sum of refunds received from the customer.';
                }
                field("Last Receipt Payment Date"; CalcLastPaymentDate())
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the posting date of the last payment received from the customer.';

                    trigger OnDrillDown()
                    var
                        CustLedgerEntry: Record "Cust. Ledger Entry";
                        CustomerLedgerEntries: Page "Customer Ledger Entries";
                    begin
                        CLEAR(CustomerLedgerEntries);
                        SetFilterLastPaymentDateEntry(CustLedgerEntry);
                        IF CustLedgerEntry.FINDLAST THEN
                            CustomerLedgerEntries.SETRECORD(CustLedgerEntry);
                        CustomerLedgerEntries.SETTABLEVIEW(CustLedgerEntry);
                        CustomerLedgerEntries.RUN;
                    end;
                }
            }
            field(GetTotalAmountNonLCY; GetTotalAmount(Rec))
            {
                Caption = 'Total';
                ApplicationArea = all;
                Style = Strong;
                ToolTip = 'Specifies the payment amount that the customer owes for completed sales plus sales that are still ongoing.';
            }
            field("Credit Limit"; Rec."BA Credit Limit")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the maximum amount you allow the customer to exceed the payment balance before warnings are issued.';
            }
            field(CalcOverdueBalance; CalcOverdueBalanceNonLCY())
            {
                ApplicationArea = all;
                Caption = 'Overdue Amount';

                trigger OnDrillDown()
                var
                    CustLedgEntry: Record "Cust. Ledger Entry";
                    DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
                begin
                    DtldCustLedgEntry.SETFILTER("Customer No.", Rec."No.");
                    COPYFILTER("Global Dimension 1 Filter", DtldCustLedgEntry."Initial Entry Global Dim. 1");
                    COPYFILTER("Global Dimension 2 Filter", DtldCustLedgEntry."Initial Entry Global Dim. 2");
                    COPYFILTER("Currency Filter", DtldCustLedgEntry."Currency Code");
                    CustLedgEntry.DrillDownOnOverdueEntries(DtldCustLedgEntry);
                end;
            }
            field(GetSalesLCY2; GetSales(Rec))
            {
                ApplicationArea = all;
                Caption = 'Total Sales';
                ToolTip = 'Specifies your total sales turnover with the customer in the current fiscal year. It is calculated from amounts excluding tax on all completed and open sales invoices and credit memos.';

                trigger OnDrillDown()
                var
                    CustLedgEntry: Record "Cust. Ledger Entry";
                begin
                    CustLedgEntry.SETRANGE("Customer No.", Rec."No.");
                    CustLedgEntry.SETRANGE("Posting Date", AccountingPeriod.GetFiscalYearStartDate(WORKDATE),
                        AccountingPeriod.GetFiscalYearEndDate(WORKDATE));
                    PAGE.RUNMODAL(PAGE::"Customer Ledger Entries", CustLedgEntry);
                end;
            }
            field(GetInvoicedPrepmtAmount2; GetInvoicedPrepmtAmount(Rec."No."))
            {
                ApplicationArea = all;
                Caption = 'Invoiced Prepayment Amount';
                ToolTip = 'Specifies your sales income from the customer, based on invoiced prepayments.';
            }
        }
    }

    var
        AccountingPeriod: Record "Accounting Period";

    procedure ShouldUseNonLCYValues(var Rec: Record Customer): Boolean
    var
        CustPostingGroup: Record "Customer Posting Group";
    begin
        exit(CustPostingGroup.Get(Rec."Customer Posting Group") and not CustPostingGroup."BA Show Non-Local Currency");
    end;

    procedure GetSales(var Rec: Record Customer): Decimal
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        StartDate: Date;
        EndDate: Date;
        SalesAmt: Decimal;
    begin
        StartDate := AccountingPeriod.GetFiscalYearStartDate(WorkDate());
        EndDate := AccountingPeriod.GetFiscalYearEndDate(WorkDate());

        CustLedgerEntry.SetRange("Customer No.", Rec."No.");
        CustLedgerEntry.SetRange("Currency Code", Rec."Currency Code");
        CustLedgerEntry.SetRange("Posting Date", StartDate, EndDate);
        CustLedgerEntry.SetRange("Date Filter", StartDate, EndDate);
        CustLedgerEntry.SecurityFiltering(SecurityFiltering());
        CustLedgerEntry.SetFilter("Document Type", '<>%1', CustLedgerEntry."Document Type"::Payment);
        if not CustLedgerEntry.FindSet() then
            exit(0);
        repeat
            CustLedgerEntry.CalcFields(Amount);
            SalesAmt += CustLedgerEntry.Amount;
        until CustLedgerEntry.Next() = 0;
        exit(SalesAmt);
    end;



    procedure GetProfits(): Decimal
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        StartDate: Date;
        EndDate: Date;
        SalesAmt: Decimal;
    begin
        StartDate := AccountingPeriod.GetFiscalYearStartDate(WorkDate());
        EndDate := AccountingPeriod.GetFiscalYearEndDate(WorkDate());
        CustLedgerEntry.SetRange("Customer No.", Rec."No.");
        CustLedgerEntry.SetRange("Currency Code", Rec."Currency Code");
        CustLedgerEntry.SetRange("Posting Date", StartDate, EndDate);
        CustLedgerEntry.SetRange("Date Filter", StartDate, EndDate);
        CustLedgerEntry.SecurityFiltering(SecurityFiltering());
        CustLedgerEntry.SetFilter("Document Type", '<>%1', CustLedgerEntry."Document Type"::Payment);
        if not CustLedgerEntry.FindSet() then
            exit(0);
        repeat
            CustLedgerEntry.CalcFields(Amount);
            SalesAmt += CustLedgerEntry.Amount;
        until CustLedgerEntry.Next() = 0;
        exit(SalesAmt);
    end;




    procedure SetFilterLastPaymentDateEntry(VAR CustLedgerEntry: Record "Cust. Ledger Entry")
    begin
        CustLedgerEntry.SETCURRENTKEY("Document Type", "Customer No.", "Posting Date", "Currency Code");
        CustLedgerEntry.SETRANGE("Customer No.", "No.");
        CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Payment);
        CustLedgerEntry.SETRANGE(Reversed, FALSE);
    end;


    procedure CalcLastPaymentDate(): Date
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        SetFilterLastPaymentDateEntry(CustLedgerEntry);
        IF CustLedgerEntry.FINDLAST THEN;
        exit(CustLedgerEntry."Posting Date");
    end;

    procedure GetTotalAmount(var Rec: Record Customer): Decimal
    begin
        Rec.CalcFields("Balance", "Outstanding Orders", "Shipped Not Invoiced", "Outstanding Invoices",
             "BA Outstanding Serv. Orders", Rec."BA Serv Shipped Not Invoiced", "BA Outstanding Serv.Invoices");
        exit(GetTotalAmountCommon(Rec));
    end;

    local procedure GetTotalAmountCommon(var Rec: Record Customer): Decimal
    var
        SalesLine: Record "Sales Line";
        ServiceLine: Record "Service Line";
    begin
        exit(Rec."Balance" + Rec."Outstanding Orders" + Rec."Shipped Not Invoiced" + Rec."Outstanding Invoices" +
            Rec."BA Outstanding Serv. Orders" + Rec."BA Outstanding Serv.Invoices" + Rec."BA Serv Shipped Not Invoiced" -
            SalesLine.OutstandingInvoiceAmountFromShipment(Rec."No.") - ServiceLine.OutstandingInvoiceAmountFromShipment(Rec."No.")
            - GetInvoicedPrepmtAmount(Rec."No.") - GetReturnRcdNotInvAmount(Rec."No."));
    end;

    procedure GetInvoicedPrepmtAmount(CustomerNo: Code[20]): Decimal
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.SETCURRENTKEY("Document Type", "Bill-to Customer No.");
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SETRANGE("Bill-to Customer No.", CustomerNo);
        SalesLine.CALCSUMS("Prepmt. Amt. Inv.", "Prepmt. Amt. Incl. VAT");
        exit(SalesLine."Prepmt. Amt. Inv." + SalesLine."Prepmt. Amt. Incl. VAT");
    end;

    procedure GetReturnRcdNotInvAmount(CustomerNo: Code[20]): Decimal
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.SETCURRENTKEY("Document Type", "Bill-to Customer No.");
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::"Return Order");
        SalesLine.SETRANGE("Bill-to Customer No.", CustomerNo);
        SalesLine.CALCSUMS("Return Rcd. Not Invd.");
        exit(SalesLine."Return Rcd. Not Invd.");
    end;



    procedure CalcOverdueBalanceNonLCY(): Decimal
    var
        CustLedgEntryRemainAmtQuery: Query "Cust. Ledg. Entry Remain. Amt.";
    begin
        CustLedgEntryRemainAmtQuery.SETRANGE(Customer_No, "No.");
        CustLedgEntryRemainAmtQuery.SETRANGE(IsOpen, TRUE);
        CustLedgEntryRemainAmtQuery.SETFILTER(Due_Date, '<%1', WORKDATE);
        CustLedgEntryRemainAmtQuery.Open();
        IF CustLedgEntryRemainAmtQuery.Read THEN
            exit(CustLedgEntryRemainAmtQuery.Sum_Remaining_Amount);
    end;

}