pageextension 80009 "BA Item Card" extends "Item Card"
{
    layout
    {
        addafter("Qty. on Sales Order")
        {
            field("BA Qty. on Sales Quote"; Rec."BA Qty. on Sales Quote")
            {
                ApplicationArea = all;
            }
            field("BA Qty. on Closed Sales Quote"; "BA Qty. on Closed Sales Quote")
            {
                ApplicationArea = all;
            }
        }
        addafter("Last Direct Cost")
        {
            field("BA Last USD Purch. Cost"; "BA Last USD Purch. Cost")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the most recent USD purchase unit cost for the item.';
            }
        }
        addlast(Item)
        {
            group("Dimensions")
            {
                Caption = 'Dimensions';
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = all;
                }
                field("ENC Shortcut Dimension 3 Code"; "ENC Shortcut Dimension 3 Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("ENC Shortcut Dimension 4 Code"; "ENC Shortcut Dimension 4 Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("ENC Shortcut Dimension 5 Code"; "ENC Shortcut Dimension 5 Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("ENC Shortcut Dimension 6 Code"; "ENC Shortcut Dimension 6 Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("ENC Shortcut Dimension 7 Code"; "ENC Shortcut Dimension 7 Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("ENC Shortcut Dimension 8 Code"; "ENC Shortcut Dimension 8 Code")
                {
                    ApplicationArea = all;
                }
                field("ENC Product ID Code"; "ENC Product ID Code")
                {
                    ApplicationArea = all;
                }
            }
        }
        addafter("Base Unit of Measure")
        {
            field("ENC Is Fabric"; "ENC Is Fabric")
            {
                ApplicationArea = all;
            }
            field("BA ETL Approved Fabric"; "BA ETL Approved Fabric")
            {
                ApplicationArea = all;
            }
            field("ENC Fabric Brand Name"; "ENC Fabric Brand Name")
            {
                ApplicationArea = all;
            }
        }
        modify("Vendor Item No.")
        {
            ApplicationArea = all;
            Visible = false;
        }
        modify("Vendor No.")
        {
            ApplicationArea = all;
            Visible = false;
        }
        addafter("Vendor Item No.")
        {
            field("BA Default Cross-Ref. No."; "BA Default Cross-Ref. No.")
            {
                ApplicationArea = all;
                Editable = false;

                trigger OnDrillDown()
                var
                    ItemCrossRef: Record "Item Cross Reference";
                    ItemCrossRefEntries: Page "Item Cross Reference Entries";
                begin
                    ItemCrossRef.FilterGroup(2);
                    ItemCrossRef.SetRange("Item No.", Rec."No.");
                    ItemCrossRefEntries.SetTableView(ItemCrossRef);
                    ItemCrossRefEntries.RunModal();
                    ItemCrossRef.FilterGroup(0);
                    Rec.CalcFields("BA Default Cross-Ref. No.", "BA Default Vendor No.");
                end;
            }
            field("BA Default Vendor No."; "BA Default Vendor No.")
            {
                ApplicationArea = all;
                Editable = false;

                trigger OnDrillDown()
                var
                    Vendor: Record Vendor;
                begin
                    if Rec."BA Default Vendor No." = '' then
                        exit;
                    Vendor.SetRange("No.", Rec."BA Default Vendor No.");
                    Page.RunModal(Page::"Vendor Card", Vendor);
                end;
            }
        }
    }

    actions
    {
        addlast(Processing)
        {
            action("BA Cancel Item")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = Cancel;
                Caption = 'Cancel Item';
                ToolTip = 'Deletes an item that has been accidently created.';

                trigger OnAction()
                var
                    ItemNo: Code[20];
                begin
                    if not Confirm(CancelMsg) then
                        exit;
                    ItemNo := Rec."No.";
                    Rec.Delete(true);
                    Subscribers.ReuseItemNo(ItemNo);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        GLSetup: Record "General Ledger Setup";
        DefaultDim: Record "Default Dimension";
        RecRef: RecordRef;
        RecRef2: RecordRef;
        UpdateRec: Boolean;
    begin
        if Rec."No." = '' then
            exit;
        RecRef.GetTable(Rec);
        GLSetup.Get();
        RecRef2.GetTable(GLSetup);

        if UpdateDimValue(RecRef, RecRef2, GLSetup.FieldNo("Shortcut Dimension 3 Code"), Rec.FieldNo("ENC Shortcut Dimension 3 Code")) then
            UpdateRec := true;
        if UpdateDimValue(RecRef, RecRef2, GLSetup.FieldNo("Shortcut Dimension 4 Code"), Rec.FieldNo("ENC Shortcut Dimension 4 Code")) then
            UpdateRec := true;
        if UpdateDimValue(RecRef, RecRef2, GLSetup.FieldNo("Shortcut Dimension 5 Code"), Rec.FieldNo("ENC Shortcut Dimension 5 Code")) then
            UpdateRec := true;
        if UpdateDimValue(RecRef, RecRef2, GLSetup.FieldNo("Shortcut Dimension 6 Code"), Rec.FieldNo("ENC Shortcut Dimension 6 Code")) then
            UpdateRec := true;
        if UpdateDimValue(RecRef, RecRef2, GLSetup.FieldNo("Shortcut Dimension 7 Code"), Rec.FieldNo("ENC Shortcut Dimension 7 Code")) then
            UpdateRec := true;
        if UpdateDimValue(RecRef, RecRef2, GLSetup.FieldNo("Shortcut Dimension 8 Code"), Rec.FieldNo("ENC Shortcut Dimension 8 Code")) then
            UpdateRec := true;
        if UpdateDimValue(RecRef, RecRef2, GLSetup.FieldNo("ENC Product ID Dim. Code"), Rec.FieldNo("ENC Product ID Code")) then
            UpdateRec := true;

        if UpdateRec then begin
            RecRef.SetTable(Rec);
            CurrPage.Update(true);
        end;
    end;

    local procedure UpdateDimValue(var RecRef: RecordRef; var GLRecRef: RecordRef; GLFldNo: Integer; DimFldNo: Integer): Boolean
    var
        GLSetup: Record "General Ledger Setup";
        DefaultDim: Record "Default Dimension";
        FldRef: FieldRef;
        FldRef2: FieldRef;
        FldRef3: FieldRef;
    begin
        FldRef := GLRecRef.Field(GLFldNo);
        if Format(FldRef.Value) = '' then
            exit(false);
        FldRef2 := RecRef.Field(Rec.FieldNo("No."));
        FldRef3 := RecRef.Field(DimFldNo);
        if DefaultDim.Get(Database::Item, FldRef2.Value, FldRef.Value) then begin
            if Format(FldRef3.Value) <> DefaultDim."Dimension Value Code" then begin
                FldRef3.Validate(DefaultDim."Dimension Value Code");
                exit(true);
            end;
        end else
            if Format(FldRef3.Value) <> '' then begin
                FldRef3.Validate('');
                exit(true);
            end;
        exit(false);
    end;


    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        ItemNo: Code[20];
    begin
        if (Rec."No." = '') or (Rec.Description <> '') or Deleted or (Rec."ENC Created Date" <> Today()) then
            exit;
        if not Confirm(StrSubstNo(CancelItemMsg, Rec."No.")) then
            Error('');
        ItemNo := Rec."No.";
        Rec.Delete(true);
        Subscribers.ReuseItemNo(ItemNo);
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        Deleted := true;
    end;

    var
        Subscribers: Codeunit "BA SEI Subscibers";
        Deleted: Boolean;
        CancelItemMsg: Label 'Do you want to cancel creating Item No. %1?';
        CancelMsg: Label 'Cancel item?';
}