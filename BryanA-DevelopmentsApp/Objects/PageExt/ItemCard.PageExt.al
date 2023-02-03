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
            field("BA Qty. on Closed Sales Quote"; Rec."BA Qty. on Closed Sales Quote")
            {
                ApplicationArea = all;
            }
        }
        addafter("Last Direct Cost")
        {
            field("BA Last USD Purch. Cost"; Rec."BA Last USD Purch. Cost")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the most recent USD purchase unit cost for the item.';
            }
        }
        addlast(Item)
        {
            group("BA Dimensions")
            {
                Caption = 'Dimensions';
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = all;
                }
                field("ENC Shortcut Dimension 3 Code"; DimValue[3])
                {
                    ApplicationArea = all;
                    Visible = false;
                    TableRelation = "Dimension Value".Code where ("Global Dimension No." = const (3), Blocked = const (false));
                    CaptionClass = '1,2,3';

                    trigger OnValidate()
                    begin
                        Rec.Validate("ENC Shortcut Dimension 3 Code", DimValue[3]);
                        Rec."ENC Shortcut Dimension 3 Code" := DimValue[3];
                    end;
                }
                field("ENC Shortcut Dimension 4 Code"; DimValue[4])
                {
                    ApplicationArea = all;
                    Visible = false;
                    TableRelation = "Dimension Value".Code where ("Global Dimension No." = const (4), Blocked = const (false));
                    CaptionClass = '1,2,4';

                    trigger OnValidate()
                    begin
                        Rec.Validate("ENC Shortcut Dimension 4 Code", DimValue[4]);
                        Rec."ENC Shortcut Dimension 4 Code" := DimValue[4];
                    end;
                }
                field("ENC Shortcut Dimension 5 Code"; DimValue[5])
                {
                    ApplicationArea = all;
                    Visible = false;
                    TableRelation = "Dimension Value".Code where ("Global Dimension No." = const (5), Blocked = const (false));
                    CaptionClass = '1,2,5';

                    trigger OnValidate()
                    begin
                        Rec.Validate("ENC Shortcut Dimension 5 Code", DimValue[5]);
                        Rec."ENC Shortcut Dimension 5 Code" := DimValue[5];
                    end;
                }
                field("ENC Shortcut Dimension 6 Code"; DimValue[6])
                {
                    ApplicationArea = all;
                    Visible = false;
                    TableRelation = "Dimension Value".Code where ("Global Dimension No." = const (6), Blocked = const (false));
                    CaptionClass = '1,2,6';

                    trigger OnValidate()
                    begin
                        Rec.Validate("ENC Shortcut Dimension 6 Code", DimValue[6]);
                        Rec."ENC Shortcut Dimension 6 Code" := DimValue[6];
                    end;
                }
                field("ENC Shortcut Dimension 7 Code"; DimValue[7])
                {
                    ApplicationArea = all;
                    Visible = false;
                    TableRelation = "Dimension Value".Code where ("Global Dimension No." = const (7), Blocked = const (false));
                    CaptionClass = '1,2,7';

                    trigger OnValidate()
                    begin
                        Rec.Validate("ENC Shortcut Dimension 7 Code", DimValue[7]);
                        Rec."ENC Shortcut Dimension 7 Code" := DimValue[7];
                    end;
                }
                field("ENC Shortcut Dimension 8 Code"; DimValue[8])
                {
                    ApplicationArea = all;
                    TableRelation = "Dimension Value".Code where ("Global Dimension No." = const (8), Blocked = const (false));
                    CaptionClass = '1,2,8';

                    trigger OnValidate()
                    begin
                        Rec.Validate("ENC Shortcut Dimension 8 Code", DimValue[8]);
                        Rec."ENC Shortcut Dimension 8 Code" := DimValue[8];
                    end;
                }
                field("ENC Product ID Code"; Rec."ENC Product ID Code")
                {
                    ApplicationArea = all;
                }
            }
        }
        addbefore(Blocked)
        {
            field("BA Product Profile Code"; Rec."BA Product Profile Code")
            {
                ApplicationArea = all;
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
            field("BA Default Cross-Ref. No."; Rec."BA Default Cross-Ref. No.")
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
            field("BA Default Vendor No."; Rec."BA Default Vendor No.")
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
                    Cancelled := true;
                    Rec.Delete(true);
                    Subscribers.ReuseItemNo(ItemNo);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CheckToUpdateDimValues(Rec);
    end;



    procedure CheckToUpdateDimValues(var Item: Record Item): Boolean
    var
        DefaultDim: Record "Default Dimension";
        RecRef: RecordRef;
        RecRef2: RecordRef;
        UpdateRec: Boolean;
        i: Integer;
    begin
        if (Item."No." = '') or Cancelled then
            exit(false);

        RecRef.GetTable(Item);
        for i := 3 to 8 do
            DimValue[i] := RecRef.Field(Rec.FieldNo("ENC Shortcut Dimension 3 Code") + i - 3).Value();
        GLSetup.Get();
        RecRef2.GetTable(GLSetup);

        if UpdateDimValue(RecRef, RecRef2, GLSetup.FieldNo("Shortcut Dimension 3 Code"), Item.FieldNo("ENC Shortcut Dimension 3 Code")) then
            UpdateRec := true;
        if UpdateDimValue(RecRef, RecRef2, GLSetup.FieldNo("Shortcut Dimension 4 Code"), Item.FieldNo("ENC Shortcut Dimension 4 Code")) then
            UpdateRec := true;
        if UpdateDimValue(RecRef, RecRef2, GLSetup.FieldNo("Shortcut Dimension 5 Code"), Item.FieldNo("ENC Shortcut Dimension 5 Code")) then
            UpdateRec := true;
        if UpdateDimValue(RecRef, RecRef2, GLSetup.FieldNo("Shortcut Dimension 6 Code"), Item.FieldNo("ENC Shortcut Dimension 6 Code")) then
            UpdateRec := true;
        if UpdateDimValue(RecRef, RecRef2, GLSetup.FieldNo("Shortcut Dimension 7 Code"), Item.FieldNo("ENC Shortcut Dimension 7 Code")) then
            UpdateRec := true;
        if UpdateDimValue(RecRef, RecRef2, GLSetup.FieldNo("Shortcut Dimension 8 Code"), Item.FieldNo("ENC Shortcut Dimension 8 Code")) then
            UpdateRec := true;
        if UpdateDimValue(RecRef, RecRef2, GLSetup.FieldNo("ENC Product ID Dim. Code"), Item.FieldNo("ENC Product ID Code")) then
            UpdateRec := true;


        if UpdateRec then begin
            for i := 3 to 8 do
                DimValue[i] := RecRef.Field(Rec.FieldNo("ENC Shortcut Dimension 3 Code") + i - 3).Value();
            RecRef.SetTable(Item);
            CurrPage.Update(true);
            Rec.Get(Rec.RecordId());
        end;
        exit(UpdateRec);
    end;

    local procedure UpdateDimValue(var RecRef: RecordRef; var GLRecRef: RecordRef; GLFldNo: Integer; DimFldNo: Integer): Boolean
    var
        GLSetup: Record "General Ledger Setup";
        DefaultDim: Record "Default Dimension";
        DimValue: Record "Dimension Value";
        FldRef: FieldRef;
        FldRef2: FieldRef;
        FldRef3: FieldRef;
    begin
        FldRef := GLRecRef.Field(GLFldNo);
        if Format(FldRef.Value()) = '' then
            exit(false);
        FldRef2 := RecRef.Field(Rec.FieldNo("No."));
        FldRef3 := RecRef.Field(DimFldNo);
        if DefaultDim.Get(Database::Item, FldRef2.Value(), FldRef.Value()) and DimValue.Get(DefaultDim."Dimension Code", DefaultDim."Dimension Value Code") then begin
            if Format(FldRef3.Value) <> DefaultDim."Dimension Value Code" then begin
                FldRef3.Validate(DefaultDim."Dimension Value Code");
                exit(true);
            end;
        end else
            if Format(FldRef3.Value()) <> '' then begin
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
        GLSetup: Record "General Ledger Setup";
        Subscribers: Codeunit "BA SEI Subscibers";
        DimValue: array[8] of Code[20];
        Deleted: Boolean;
        Cancelled: Boolean;
        CancelItemMsg: Label 'Do you want to cancel creating Item No. %1?';
        CancelMsg: Label 'Cancel item?';

}