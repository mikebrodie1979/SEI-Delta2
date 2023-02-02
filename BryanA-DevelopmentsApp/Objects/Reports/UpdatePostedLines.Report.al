report 50072 "BA Updated Posted Lines"
{
    Caption = 'Updated Posted Lines';
    ProcessingOnly = true;
    UseRequestPage = false;
    Permissions = tabledata "Sales Invoice Line" = rimd,
        tabledata "Sales Cr.Memo Line" = rimd,
        tabledata "Service Invoice Line" = rimd,
        tabledata "Service Cr.Memo Line" = rimd;

    procedure SalesInvoiceLines(var Rec: Record "Sales Invoice Line")
    begin
        if Rec.FindSet(true) then
            repeat
                Rec."BA Omit from Reports" := not Rec."BA Omit from Reports";
                Rec.Modify(false);
            until Rec.Next() = 0;
    end;

    procedure SalesCrMemoLines(var Rec: Record "Sales Cr.Memo Line")
    begin
        if Rec.FindSet(true) then
            repeat
                Rec."BA Omit from Reports" := not Rec."BA Omit from Reports";
                Rec.Modify(false);
            until Rec.Next() = 0;
    end;

    procedure ServiceInvoiceLines(var Rec: Record "Service Invoice Line")
    begin
        if Rec.FindSet(true) then
            repeat
                Rec."BA Omit from Reports" := not Rec."BA Omit from Reports";
                Rec.Modify(false);
            until Rec.Next() = 0;
    end;

    procedure ServiceCrMemoLines(var Rec: Record "Service Cr.Memo Line")
    begin
        if Rec.FindSet(true) then
            repeat
                Rec."BA Omit from Reports" := not Rec."BA Omit from Reports";
                Rec.Modify(false);
            until Rec.Next() = 0;
    end;
}