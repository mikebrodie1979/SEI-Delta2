pageextension 80090 "BA Phys. Inventory Jnl." extends "Phys. Inventory Journal"
{
    layout
    {
        addfirst(Control1)
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("BA Warning Message"; Rec."BA Warning Message")
            {
                ApplicationArea = all;
                Style = Unfavorable;
                Editable = false;
            }
        }
        addafter(Description)
        {
            field("BA Updated"; "BA Updated")
            {
                ApplicationArea = all;
                Caption = 'Year-End Inventory Adjustment';
                Editable = true;
            }
        }
    }

    actions
    {
        addlast(Processing)
        {
            action("BA Import Item Inventory")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = PhysicalInventory;
                Caption = 'Import Item Inventory';

                trigger OnAction()
                var
                    ImportInventory: Report "BA Physical Inventory Import";
                begin
                    ImportInventory.SetParameters(Rec);
                    ImportInventory.RunModal();
                end;
            }
            action("BA View Import Errors")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = PhysicalInventoryLedger;
                Caption = 'View Inventory Import Errors';

                trigger OnAction()
                var
                    NameBuffer: Record "Name/Value Buffer" temporary;
                    ItemJnlLine: Record "Item Journal Line";
                    ErrorPage: Page "BA Phys. Invt. Import Errors";
                begin
                    ItemJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                    ItemJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    ItemJnlLine.SetFilter("BA Warning Message", '<>%1', '');
                    ErrorPage.PopulateRecords(ItemJnlLine);
                    ErrorPage.RunModal();
                end;
            }
        }
    }
}