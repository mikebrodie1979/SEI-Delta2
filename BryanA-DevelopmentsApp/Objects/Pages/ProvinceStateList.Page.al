page 50060 "BA Province/State List"
{
    Caption = 'Provinces/States';
    SourceTable = "BA Province/State";
    UsageCategory = Lists;
    ApplicationArea = all;
    PageType = List;
    LinksAllowed = false;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = all;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        CalcFields("Country/Region Name");
                    end;
                }
                field("Country/Region Name"; "Country/Region Name")
                {
                    ApplicationArea = all;
                }
                field(Symbol; Rec.Symbol)
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = all;
                }
                field("Print Full Name"; "Print Full Name")
                {
                    ApplicationArea = all;
                }
                //derp
            }
        }
    }
}