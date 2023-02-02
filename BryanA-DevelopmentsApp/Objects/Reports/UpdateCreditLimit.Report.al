report 50071 "BA Update Credit Limit"
{
    ApplicationArea = all;
    Caption = 'Update Credit Limits';
    UsageCategory = Tasks;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customer; Customer)
        {
            trigger OnPreDataItem()
            begin
                Customer.SetFilter("BA Credit Limit", '<>%1', 0);
                RecCount := Customer.Count();
                Window.Open('Updating: #1#');
            end;

            trigger OnAfterGetRecord()
            begin
                i += 1;
                Window.Update(1, StrSubstNo('%1 of %2', i, RecCount));
                Customer.Validate("BA Credit Limit");
                Customer.Modify(true);
            end;

            trigger OnPostDataItem()
            begin
                Window.Close();
            end;
        }
    }

    var
        Window: Dialog;
        RecCount: Integer;
        i: Integer;
}