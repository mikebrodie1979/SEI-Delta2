report 50085 "BA Set Prod. Order Version"
{
    ProcessingOnly = true;
    Caption = 'Set Production Order Version';
    Permissions = tabledata "Production Order" = rimd;

    dataset
    {
        dataitem("Production Order"; "Production Order")
        {
            RequestFilterFields = "No.";

            trigger OnPreDataItem()
            begin
                SetRange("Source Type", "Source Type"::Item);
                SetFilter("Source No.", '<>%1', '');
                RecCount := Count();
                Window.Open('Updating\#1##');
            end;

            trigger OnAfterGetRecord()
            var
                BOMHeader: Record "Production BOM Header";
            begin
                i += 1;
                Window.Update(1, StrSubstNo('%1 of %2', i, RecCount));
                if not BOMHeader.Get("Source No.") or (BOMHeader."ENC Active Version No." = '') then
                    exit;
                "Production Order"."BA Source Version" := BOMHeader."ENC Active Version No.";
                "Production Order".Modify(false);
                UpdateCount += 1;
            end;

            trigger OnPostDataItem()
            begin
                Window.Close();
                Message('Updated %1 records.', UpdateCount);
            end;
        }
    }

    var
        Window: Dialog;
        RecCount: Integer;
        UpdateCount: Integer;
        i: Integer;
}