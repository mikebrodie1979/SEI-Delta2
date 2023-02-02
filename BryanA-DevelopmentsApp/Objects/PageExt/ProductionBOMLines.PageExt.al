pageextension 80105 "BA Prod. BOM Lines" extends "Production BOM Lines"
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
        }
        addafter("No.")
        {
            field("BA Default Vendor No."; Rec."BA Default Vendor No.")
            {
                ApplicationArea = all;

                trigger OnDrillDown()
                begin
                    CrossRefDrillDown();
                end;
            }
            field("BA Default Cross-Ref. No."; Rec."BA Default Cross-Ref. No.")
            {
                ApplicationArea = all;

                trigger OnDrillDown()
                begin
                    CrossRefDrillDown();
                end;
            }
            field("BA Balloon Position"; Rec."BA Balloon Position")
            {
                ApplicationArea = all;
                BlankZero = true;
            }
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                Rec.CalcFields("BA Default Cross-Ref. No.", "BA Default Vendor No.");
            end;
        }
    }

    local procedure CrossRefDrillDown()
    var
        ItemCrossRef: Record "Item Cross Reference";
        ListPage: Page "Item Cross Reference Entries";
    begin
        ItemCrossRef.FilterGroup(2);
        ItemCrossRef.SetRange("Item No.", "No.");
        ItemCrossRef.FilterGroup(0);
        ListPage.SetTableView(ItemCrossRef);
        ListPage.RunModal();
    end;
}