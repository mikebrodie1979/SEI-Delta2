pageextension 80089 "BA Cust. Details Factbox" extends "Customer Details FactBox"
{
    layout
    {
        modify("Credit Limit (LCY)")
        {
            ApplicationArea = all;
            Visible = false;
        }
        modify(AvailableCreditLCY)
        {
            ApplicationArea = all;
            Visible = false;
        }
        addafter(AvailableCreditLCY)
        {
            group("LCY Credit")
            {
                ShowCaption = false;
                Visible = ShowLCYBalances;

                field("Credit Limit (LCY)2"; Rec."Credit Limit (LCY)")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the maximum amount you allow the customer to exceed the payment balance before warnings are issued.';
                    StyleExpr = StyleTxt;
                }
                field("Available Credit ($)"; Rec.CalcAvailableCreditUI())
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies a customer''s available credit. If the available credit is 0 and the customer''s credit limit is also 0, then the customer has unlimited credit because no credit limit has been defined.';
                }
            }
            group("Non-LCY Credit")
            {
                ShowCaption = false;
                Visible = not ShowLCYBalances;

                field("Credit Limit"; Rec."BA Credit Limit")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the maximum amount you allow the customer to exceed the payment balance before warnings are issued.';
                    StyleExpr = StyleTxt;
                }
                field("Available Credit"; CalcAvailableCreditNonLCY(Rec))
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies a customer''s available credit. If the available credit is 0 and the customer''s credit limit is also 0, then the customer has unlimited credit because no credit limit has been defined.';

                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::"BA Available Credit Non-LCY", Rec);
                    end;
                }
            }
        }
    }

    procedure CalcAvailableCreditNonLCY(var Rec: Record Customer): Decimal
    begin
        if Rec."BA Credit Limit" = 0 then
            exit(0);
        exit(Rec."BA Credit Limit" - NonLCYCustomerStatistics.GetTotalAmount(Rec));
    end;


    var
        [InDataSet]
        ShowLCYBalances: Boolean;
        StyleTxt: Text;
        NonLCYCustomerStatistics: Page "BA Non-LCY Cust. Stat. Factbox";

    trigger OnAfterGetRecord()
    var
        CustPostingGroup: Record "Customer Posting Group";
    begin
        ShowLCYBalances := CustPostingGroup.Get(Rec."Customer Posting Group") and not CustPostingGroup."BA Show Non-Local Currency";
        StyleTxt := '';
        if ShowLCYBalances then
            StyleTxt := Rec.SetStyle()
        else
            if CalcAvailableCreditNonLCY(Rec) < 0 then
                StyleTxt := 'Unfavorable';
    end;


}