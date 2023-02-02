pageextension 80145 "BA Posted Sales Inv. Subpage" extends "Posted Sales Invoice Subform"
{
    Editable = true;

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
                    SalesInvLine: Record "Sales Invoice Line";
                    UpdatedPostedLines: Report "BA Updated Posted Lines";
                begin
                    CurrPage.SetSelectionFilter(SalesInvLine);
                    UpdatedPostedLines.SalesInvoiceLines(SalesInvLine);
                end;
            }
        }
    }
}