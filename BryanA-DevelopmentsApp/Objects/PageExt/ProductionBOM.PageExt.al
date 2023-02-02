pageextension 80006 "BA Production BOM" extends "Production BOM"
{
    actions
    {
        addfirst("&Prod. BOM")
        {
            action("BA Print")
            {
                ApplicationArea = all;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Caption = 'Print';

                trigger OnAction()
                var
                    ProdBOM: Record "Production BOM Header";
                    ProdBOMReport: Report "BA Production BOM";
                begin
                    ProdBOM.SetRange("No.", Rec."No.");
                    ProdBOMReport.SetTableView(ProdBOM);
                    ProdBOMReport.Run();
                end;
            }
        }
    }
}