pageextension 80146 "BA P. Sales Cr.Memo Subpage" extends "Posted Sales Cr. Memo Subform"
{
    layout
    {
        addfirst(Control1)
        {
            field("BA Omit from Reports"; Rec."BA Omit from Reports")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        addlast("&Line")
        {
            action("Omit Selected Lines")
            {
                ApplicationArea = all;
                Image = MakeOrder;

                trigger OnAction()
                var
                    SalesCrMemoLine: Record "Sales Cr.Memo Line";
                    UpdatedPostedLines: Report "BA Updated Posted Lines";
                begin
                    CurrPage.SetSelectionFilter(SalesCrMemoLine);
                    UpdatedPostedLines.SalesCrMemoLines(SalesCrMemoLine);
                end;
            }
        }
    }
}