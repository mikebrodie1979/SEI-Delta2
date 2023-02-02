pageextension 80000 "BA Purch. Order Subpage" extends "Purchase Order Subform"
{
    layout
    {
        modify("Direct Unit Cost")
        {
            ApplicationArea = all;
            Visible = not "BA Requisition Order";
        }
        modify("Line Discount Amount")
        {
            ApplicationArea = all;
            Visible = not "BA Requisition Order";
        }

        modify("Line Discount %")
        {
            ApplicationArea = all;
            Visible = not "BA Requisition Order";
        }
        modify("Cross-Reference No.")
        {
            ApplicationArea = all;
            trigger OnLookup(var Text: Text): Boolean
            var
                PurchHeader: Record "Purchase Header";
                ItemCrossRef: Record "Item Cross Reference";
                CrossRefList: Page "Cross Reference List";
            begin
                if (Rec.Type <> Rec.Type::Item) or not PurchHeader.Get(Rec."Document Type", Rec."Document No.")
                        or (PurchHeader."Buy-from Vendor No." = '') then
                    exit;
                ItemCrossRef.SetRange("Item No.", Rec."No.");
                ItemCrossRef.SetRange("Cross-Reference Type", ItemCrossRef."Cross-Reference Type"::Vendor);
                ItemCrossRef.SetRange("Cross-Reference Type No.", PurchHeader."Buy-from Vendor No.");
                CrossRefList.LookupMode(true);
                CrossRefList.SetTableView(ItemCrossRef);
                if CrossRefList.RunModal() <> Action::LookupOK then
                    exit;
                CrossRefList.GetRecord(ItemCrossRef);
                Rec.Validate("Cross-Reference No.", ItemCrossRef."Cross-Reference No.");
            end;
        }
        addafter(Quantity)
        {
            field("Direct Unit Cost2"; Rec."Direct Unit Cost")
            {
                ApplicationArea = all;
                Visible = "BA Requisition Order";
            }
            field("Line Discount %2"; Rec."Line Discount %")
            {
                ApplicationArea = all;
                Visible = "BA Requisition Order";
            }
            field("Line Discount Amount2"; Rec."Line Discount Amount")
            {
                ApplicationArea = all;
                Visible = "BA Requisition Order";
            }
        }
        addafter(ShortcutDimCode4)
        {
            field("BA Sales Person Code"; SalesPersonCode)
            {
                ApplicationArea = all;
                TableRelation = "Dimension Value".Code where ("Dimension Code" = field ("BA Salesperson Filter Code"), "ENC Inactive" = const (false));
                Caption = 'Sales Person Code';

                trigger OnValidate()
                begin
                    ValidateShortcutDimCode(5, SalesPersonCode);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        TempDimSet: Record "Dimension Set Entry" temporary;
    begin
        SalesPersonCode := '';
        DimMgt.GetDimensionSet(TempDimSet, Rec."Dimension Set ID");
        TempDimSet.SetRange("Dimension Code", GLSetup."ENC Salesperson Dim. Code");
        if TempDimSet.FindFirst then
            SalesPersonCode := TempDimSet."Dimension Value Code";
        Rec."BA Salesperson Filter Code" := GLSetup."ENC Salesperson Dim. Code";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        SalesPersonCode := '';
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."BA Salesperson Filter Code" := GLSetup."ENC Salesperson Dim. Code";
    end;

    trigger OnModifyRecord(): Boolean
    begin
        Rec."BA Salesperson Filter Code" := GLSetup."ENC Salesperson Dim. Code";
    end;

    trigger OnOpenPage()
    begin
        GLSetup.Get;
        GLSetup.TestField("ENC Salesperson Dim. Code");
    end;

    var
        GLSetup: Record "General Ledger Setup";
        DimMgt: Codeunit DimensionManagement;
        SalesPersonCode: Code[20];
}