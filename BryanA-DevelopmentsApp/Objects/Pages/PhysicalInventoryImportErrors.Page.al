page 50067 "BA Phys. Invt. Import Errors"
{
    SourceTable = "Name/Value Buffer";
    PageType = List;
    Caption = 'Physical Inventory Import Errors';
    Editable = false;
    LinksAllowed = false;
    SourceTableTemporary = true;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Item No."; Rec.Name)
                {
                    ApplicationArea = all;
                    Caption = 'Item No.';
                    TableRelation = Item."No.";
                }
                field("Line No."; Rec.ID)
                {
                    ApplicationArea = all;
                    Caption = 'Journal Line No.';

                    trigger OnDrillDown()
                    var
                        ItemJnlLine: Record "Item Journal Line";
                        RecID: RecordId;
                        PhysicalInvJnl: Page "Phys. Inventory Journal";
                    begin
                        if not Evaluate(RecID, Rec."Value Long") or not ItemJnlLine.Get(RecID) then
                            exit;
                        ItemJnlLine.FilterGroup(2);
                        ItemJnlLine.SetRange("Journal Template Name", ItemJnlLine."Journal Template Name");
                        ItemJnlLine.SetRange("Journal Batch Name", ItemJnlLine."Journal Batch Name");
                        ItemJnlLine.SetRange("Item No.", ItemJnlLine."Item No.");
                        PhysicalInvJnl.SetTableView(ItemJnlLine);
                        ItemJnlLine.FilterGroup(0);
                        PhysicalInvJnl.RunModal();
                    end;
                }
                field(Error; Rec.Value)
                {
                    ApplicationArea = all;
                    Caption = 'Error Message';
                    Style = Unfavorable;
                }
            }
        }
    }

    procedure PopulateRecords(var ItemJnlLine: Record "Item Journal Line")
    begin
        if ItemJnlLine.FindSet() then
            repeat
                Rec.Init();
                Rec.ID := ItemJnlLine."Line No.";
                Rec.Name := ItemJnlLine."Item No.";
                Rec.Value := ItemJnlLine."BA Warning Message";
                Rec."Value Long" := Format(ItemJnlLine.RecordId());
                Rec.Insert(false);
            until ItemJnlLine.Next() = 0;
    end;
}