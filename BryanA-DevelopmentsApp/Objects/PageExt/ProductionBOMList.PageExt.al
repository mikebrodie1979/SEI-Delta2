pageextension 80007 "BA Production BOM List" extends "Production BOM List"
{
    layout
    {
        addlast(Control1)
        {
            field("BA Item Gen. Posting Group"; "BA Item Gen. Posting Group")
            {
                ApplicationArea = all;
            }
            field("BA Item Manufacturing Policy"; "BA Item Manufacturing Policy")
            {
                ApplicationArea = all;
            }
            field("BA Item Replenishment System"; "BA Item Replenishment System")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        addfirst(Reporting)
        {
            action("BA Print")
            {
                ApplicationArea = all;
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;
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