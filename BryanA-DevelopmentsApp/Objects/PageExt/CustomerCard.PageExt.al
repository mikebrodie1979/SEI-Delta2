pageextension 80045 "BA Customer Card" extends "Customer Card"
{
    layout
    {
        addlast(Content)
        {
            group("Account & System Control")
            {
                field(Blocked2; Rec.Blocked)
                {
                    ApplicationArea = all;
                }
                field("Privacy Blocked2"; Rec."Privacy Blocked")
                {
                    ApplicationArea = all;
                }
                field("ENC Country/Region Mandatory"; Rec."ENC Country/Region Mandatory")
                {
                    ApplicationArea = all;
                }
                field("ENC Salesperson Code Mandatory"; Rec."ENC Salesperson Code Mandatory")
                {
                    ApplicationArea = all;
                }
                field("BA Int. Customer"; Rec."BA Int. Customer")
                {
                    ApplicationArea = all;
                }
                field("BA Serv. Int. Customer"; Rec."BA Serv. Int. Customer")
                {
                    ApplicationArea = all;
                }
                field("IC Partner Code2"; Rec."IC Partner Code")
                {
                    ApplicationArea = all;
                }
                field("Service Zone Code2"; Rec."Service Zone Code")
                {
                    ApplicationArea = all;
                }
                field("ENC CRM GUID"; Rec."ENC CRM GUID")
                {
                    ApplicationArea = all;
                }
            }

        }
        modify(Blocked)
        {
            ApplicationArea = all;
            Visible = false;
        }
        modify("Privacy Blocked")
        {
            ApplicationArea = all;
            Visible = false;
        }
        modify("IC Partner Code")
        {
            ApplicationArea = all;
            Visible = false;
        }
        modify("Service Zone Code")
        {
            ApplicationArea = all;
            Visible = false;
        }

        addafter("Post Code")
        {
            field("BA Region"; Rec."BA Region")
            {
                ApplicationArea = all;
            }
        }
        addfirst(AddressDetails)
        {
            field("BA Country/Region Code"; "Country/Region Code")
            {
                ApplicationArea = all;
                Caption = 'Country';
            }
        }
        addafter(County)
        {
            field("BA County Fullname"; "BA County Fullname")
            {
                ApplicationArea = all;
            }
        }
        modify("Country/Region Code")
        {
            ApplicationArea = all;
            Visible = false;
            Enabled = false;
            Editable = false;
        }
        modify(County)
        {
            trigger OnAfterValidate()
            begin
                Rec.CalcFields("BA County Fullname");
            end;
        }
        modify("Customer Posting Group")
        {
            trigger OnAfterValidate()
            begin
                UpdateBalanaceDisplay();
            end;
        }
        modify("Balance (LCY)")
        {
            ApplicationArea = all;
            Visible = false;
        }
        modify("Balance Due (LCY)")
        {
            ApplicationArea = all;
            Visible = false;
        }
        modify("Credit Limit (LCY)")
        {
            ApplicationArea = all;
            Visible = false;
        }
        modify(TotalSales2)
        {
            ApplicationArea = all;
            Visible = false;

        }
        addafter(TotalSales2)
        {
            group("Total Sales")
            {
                ShowCaption = false;
                Visible = ShowLCYBalances;
                field("TotalSales"; GetTotalSales())
                {
                    ApplicationArea = all;
                    Caption = 'Total Sales';
                    Style = Strong;
                    ToolTip = 'Specifies your total sales turnover with the customer in the current fiscal year. It is calculated from amounts excluding tax on all completed and open invoices and credit memos.';
                }
            }
            group("Non-LCY Sales")
            {
                ShowCaption = false;
                Visible = not ShowLCYBalances;
                field("TotalSales Non-LCY"; NonLCYCustomerStatistics.GetSales(Rec))
                {
                    ApplicationArea = all;
                    Caption = 'Total Sales';
                    Style = Strong;
                    ToolTip = 'Specifies your total sales turnover with the customer in the current fiscal year. It is calculated from amounts excluding tax on all completed and open invoices and credit memos.';
                }
            }
        }
        addafter("Balance (LCY)")
        {
            group("BA Local Balances")
            {
                Visible = ShowLCYBalances;
                ShowCaption = false;
                field("Credit Limit (LCY)2"; "Credit Limit (LCY)")
                {
                    ApplicationArea = all;
                    StyleExpr = StyleTxt;
                    ToolTip = 'Specifies the maximum amount you allow the customer to exceed the payment balance before warnings are issued.';
                }
                field("BA Credit Limit Last Updated2"; Rec."BA Credit Limit Last Updated")
                {
                    ApplicationArea = all;
                }
                field("BA Credit Limit Updated By2"; Rec."BA Credit Limit Updated By")
                {
                    ApplicationArea = all;
                }
                field("BA Balance (LCY)"; "Balance (LCY)")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the payment amount that the customer owes for completed sales. This value is also known as the customer''s balance.';

                    trigger OnDrillDown()
                    begin
                        Rec.OpenCustomerLedgerEntries(false);
                    end;
                }
                field("BA Balance Due (LCY)"; "Balance Due (LCY)")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies payments from the customer that are overdue per today''s date.';

                    trigger OnDrillDown()
                    begin
                        Rec.OpenCustomerLedgerEntries(true);
                    end;
                }
            }
            group("BA Non-Local Balances")
            {
                Visible = not ShowLCYBalances;
                ShowCaption = false;
                field("BA Credit Limit"; "BA Credit Limit")
                {
                    ApplicationArea = all;
                    StyleExpr = StyleTxt;
                    ToolTip = 'Specifies the maximum amount you allow the customer to exceed the payment balance before warnings are issued.';
                }
                field("BA Credit Limit Last Updated"; Rec."BA Credit Limit Last Updated")
                {
                    ApplicationArea = all;
                }
                field("BA Credit Limit Updated By"; Rec."BA Credit Limit Updated By")
                {
                    ApplicationArea = all;
                }
                field("BA Balance"; Balance)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the payment amount that the customer owes for completed sales. This value is also known as the customer''s balance.';

                    trigger OnDrillDown()
                    begin
                        Rec.OpenCustomerLedgerEntries(false);
                    end;
                }
                field("BA Balance Due"; "Balance Due")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies payments from the customer that are overdue per today''s date.';

                    trigger OnDrillDown()
                    begin
                        Rec.OpenCustomerLedgerEntries(true);
                    end;
                }
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

    actions
    {
        addlast(Creation)
        {
            action("BA Cancel Customer")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = Cancel;
                Caption = 'Cancel Customer';
                ToolTip = 'Deletes a customer that has been accidently created.';

                trigger OnAction()
                begin
                    if not Confirm('Cancel customer?') then
                        exit;
                    Rec."ENC Has Been Renamed" := true;
                    Rec.Delete(true);
                end;
            }
        }
    }

    var
        [InDataSet]
        ShowLCYBalances: Boolean;
        [InDataSet]
        StyleTxt: Text;
        NonLCYCustomerStatistics: Page "BA Non-LCY Cust. Stat. Factbox";


    trigger OnAfterGetRecord()
    var
        CustomDetailsFactbox: page "Customer Details FactBox";
    begin
        UpdateBalanaceDisplay();
        StyleTxt := '';
        if ShowLCYBalances then
            StyleTxt := Rec.SetStyle()
        else
            if CustomDetailsFactbox.CalcAvailableCreditNonLCY(Rec) < 0 then
                StyleTxt := 'Unfavorable';
        GetTotalSales();
    end;

    local procedure UpdateBalanaceDisplay()
    var
        CustPostingGroup: Record "Customer Posting Group";
    begin
        if Rec."Customer Posting Group" = '' then
            ShowLCYBalances := true
        else
            ShowLCYBalances := CustPostingGroup.Get(Rec."Customer Posting Group") and not CustPostingGroup."BA Show Non-Local Currency";
    end;



    local procedure GetTotalSales(): Decimal
    var
        AmountOnPostedInvoices: Decimal;
        AmountOnPostedCrMemos: Decimal;
        AmountOnOutstandingInvoices: Decimal;
        AmountOnOutstandingCrMemos: Decimal;
        NoPostedInvoices: Integer;
        NoPostedCrMemos: Integer;
        NoOutstandingInvoices: Integer;
        NoOutstandingCrMemos: Integer;
        Totals: Decimal;
        CustomerMgt: Codeunit "Customer Mgt.";
    begin
        AmountOnPostedInvoices := CustomerMgt.CalcAmountsOnPostedInvoices("No.", NoPostedInvoices);
        AmountOnPostedCrMemos := CustomerMgt.CalcAmountsOnPostedCrMemos("No.", NoPostedCrMemos);
        AmountOnOutstandingInvoices := CustomerMgt.CalculateAmountsOnUnpostedInvoices("No.", NoOutstandingInvoices);
        AmountOnOutstandingCrMemos := CustomerMgt.CalculateAmountsOnUnpostedCrMemos("No.", NoOutstandingCrMemos);
        Totals := AmountOnPostedInvoices + AmountOnPostedCrMemos + AmountOnOutstandingInvoices + AmountOnOutstandingCrMemos;
        CustomerMgt.CalculateStatistic(Rec, AdjmtCost, AdjCustProfit, AdjProfitPct,
              CustInvDiscAmount, CustPayments, CustSales, CustProfit);
        EXIT(Totals)
    end;



    var
        AdjmtCost: Decimal;
        AdjCustProfit: Decimal;
        AdjProfitPct: Decimal;
        CustInvDiscAmount: Decimal;
        CustPayments: Decimal;
        CustSales: Decimal;
        CustProfit: Decimal;
}