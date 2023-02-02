page 50065 "BA Labour Rates"
{
    ApplicationArea = All;
    SourceTable = "BA Labour Rate";
    UsageCategory = Lists;
    Caption = 'SEI International Labour Rates';
    PageType = List;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field(Rate; Rec.Rate)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}