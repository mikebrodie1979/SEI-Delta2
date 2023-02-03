report 50082 "BA Fix Item Dim. Values"
{
    UsageCategory = Tasks;
    ApplicationArea = all;
    ProcessingOnly = true;
    Caption = 'Fix Item Dimensions';

    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.";

            trigger OnPreDataItem()
            begin
                InventorySetup.Get();
                DefaultCode := InventorySetup."ENC Def. Product ID Code";
                InventorySetup."ENC Def. Product ID Code" := '';
                InventorySetup.Modify(false);
                RecCount := Item.Count;
                Window.Open('@1@@@');
            end;

            trigger OnAfterGetRecord()
            var
                ItemCard: Page "Item Card";
            begin
                i2 += 1;
                Window.Update(1, Round(i2 / RecCount * 10000, 1));
                if ItemCard.CheckToUpdateDimValues(Item) then begin
                    Item.Modify(false);
                    i += 1;
                end;
            end;

            trigger OnPostDataItem()
            begin
                Message('Updated %1 items.', i);
                InventorySetup.Get();
                InventorySetup."ENC Def. Product ID Code" := DefaultCode;
                InventorySetup.Modify(false);
                Window.Close();
            end;
        }
    }

    var
        i: Integer;
        InventorySetup: Record "Inventory Setup";
        DefaultCode: Code[20];
        Window: Dialog;
        RecCount: Integer;
        i2: Integer;
}