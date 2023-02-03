report 50083 "BA Add Missing Item Dims."
{
    UsageCategory = Tasks;
    ApplicationArea = all;
    ProcessingOnly = true;
    Caption = 'Add Missing Item Dimensions';

    dataset
    {
        dataitem("Default Dimension"; "Default Dimension")
        {
            DataItemTableView = sorting ("Table ID") where ("Table ID" = const (27));
            RequestFilterFields = "No.";

            trigger OnPreDataItem()
            begin
                InventorySetup.Get();
                DefaultCode := InventorySetup."ENC Def. Product ID Code";
                InventorySetup."ENC Def. Product ID Code" := '';
                InventorySetup.Modify(false);
                RecCount := "Default Dimension".Count();
                Window.Open('@1@@@');
                GLSetup.Get();
                if GetFilter("No.") = '' then
                    SetFilter("No.", '<>%1', '');
            end;

            trigger OnAfterGetRecord()
            var
                Item: Record Item;
                RecRef: RecordRef;
                RecRef2: RecordRef;
                i: Integer;
                FldNo: Integer;
                FldNo2: Integer;
                SaveRec: Boolean;
            begin
                Index += 1;
                Window.Update(1, Round(Index / RecCount * 10000, 1));

                if not Item.Get("No.") then
                    CurrReport.Skip();
                RecRef.GetTable(GLSetup);
                FldNo := GLSetup.FieldNo("Shortcut Dimension 1 Code");
                RecRef2.GetTable(Item);

                for i := 0 to 7 do begin
                    if i < 2 then
                        FldNo2 := Item.FieldNo("Global Dimension 1 Code") + i
                    else
                        FldNo2 := Item.FieldNo("ENC Shortcut Dimension 3 Code") + i - 2;
                    if ("Dimension Code" = Format(RecRef.Field(FldNo + i).Value()))
                            and ((Format(RecRef2.Field(FldNo2).Value()) = '') or ("Dimension Value Code" <> Format(RecRef2.Field(FldNo2).Value()))) then
                        if TryUpdate(RecRef2, FldNo2, "Dimension Code", "Dimension Value Code") then
                            SaveRec := true
                        else
                            ErrorCount += 1;
                end;
                if ("Dimension Code" = GLSetup."ENC Product ID Dim. Code") and
                    ((Item."ENC Product ID Code" = '') or ("Dimension Value Code" <> Item."ENC Product ID Code")) then
                    if TryUpdate(RecRef2, Item.FieldNo("ENC Product ID Code"), "Dimension Code", "Dimension Value Code") then
                        SaveRec := true
                    else
                        ErrorCount += 1;
                if SaveRec then begin
                    RecRef2.Modify(true);
                    UpdateCount += 1;
                end;
            end;



            trigger OnPostDataItem()
            begin
                Message('Updated %1 items, with %2 errors.', UpdateCount, ErrorCount);
                InventorySetup.Get();
                InventorySetup."ENC Def. Product ID Code" := DefaultCode;
                InventorySetup.Modify(false);
                Window.Close();
            end;
        }
    }

    var
        InventorySetup: Record "Inventory Setup";
        DefaultCode: Code[20];
        Window: Dialog;
        RecCount: Integer;
        UpdateCount: Integer;
        ErrorCount: Integer;
        Index: Integer;
        GLSetup: Record "General Ledger Setup";


    local procedure TryUpdate(var RecRef: RecordRef; FldNo: Integer; DimCode: Code[20]; DimValue: Code[20]): Boolean
    var
        DimValueRec: Record "Dimension Value";
    begin
        if not DimValueRec.Get(DimCode, DimValue) then
            exit(false);
        RecRef.Field(FldNo).Validate(DimValue);
        exit(true);
    end;
}