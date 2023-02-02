page 50066 "BA Sales Source"
{
    ApplicationArea = all;
    UsageCategory = Lists;
    SourceTable = "BA Sales Source";
    PageType = List;
    Caption = 'Sales Source';
    DelayedInsert = true;
    LinksAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field(Name; Name)
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                }
            }
        }
    }
}