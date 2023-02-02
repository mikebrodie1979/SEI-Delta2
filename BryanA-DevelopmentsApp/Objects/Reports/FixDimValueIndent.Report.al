report 50081 "BA Fix Dim. Value Indent"
{
    ApplicationArea = all;
    UsageCategory = Tasks;
    Caption = 'Fix Dimension Value Indent';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Dimension Value"; "Dimension Value")
        {
            trigger OnPreDataItem()
            begin
                SetRange("Dimension Code", 'PRODUCT ID');
                SetRange("Dimension Value Type", "Dimension Value Type"::Standard);
                SetFilter(Indentation, '<>%1', 0);
            end;

            trigger OnAfterGetRecord()
            begin
                Indentation := 0;
                Modify(false);
                i += 1;
            end;

            trigger OnPostDataItem()
            begin
                Message('Updated %1 records.', i);
            end;
        }
    }

    var
        i: Integer;
}