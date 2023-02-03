page 50072 "BA Product Profiles"
{
    UsageCategory = Lists;
    ApplicationArea = all;
    Caption = 'Product Profiles';
    SourceTable = "BA Product Profile";
    PageType = List;
    LinksAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Line)
            {
                field("Profile Code"; Rec."Profile Code")
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                }
                field("Created By"; "Created By")
                {
                    ApplicationArea = all;
                }
                field("Creation Date"; "Creation Date")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = all;
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    ApplicationArea = all;
                }
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                    ApplicationArea = all;
                }
                field("Costing Method"; Rec."Costing Method")
                {
                    ApplicationArea = all;
                }
                field("Price/Profit Calculation"; Rec."Price/Profit Calculation")
                {
                    ApplicationArea = all;
                }
                field("Core Product Code"; Rec."Core Product Code")
                {
                    ApplicationArea = all;
                }
                field("Item Tracking Code"; Rec."Item Tracking Code")
                {
                    ApplicationArea = all;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = all;
                }
                field("Manufacturing Dept."; Rec."Manufacturing Dept.")
                {
                    ApplicationArea = all;
                }
                field("Manufacturing Policy"; Rec."Manufacturing Policy")
                {
                    ApplicationArea = all;
                }
                field("Replenishment System"; Rec."Replenishment System")
                {
                    ApplicationArea = all;
                }
                field("Assembly Policy"; Rec."Assembly Policy")
                {
                    ApplicationArea = all;
                }
                field("Reordering Policy"; Rec."Reordering Policy")
                {
                    ApplicationArea = all;
                }
                field(Reserve; Rec.Reserve)
                {
                    ApplicationArea = all;
                }
                field("International HS Code"; Rec."International HS Code")
                {
                    ApplicationArea = all;
                }
                field("US HS Code"; Rec."US HS Code")
                {
                    ApplicationArea = all;
                }
                field(CUSMA; Rec.CUSMA)
                {
                    ApplicationArea = all;
                }
                field(Producer; Rec.Producer)
                {
                    ApplicationArea = all;
                }
                field("Preference Criterion"; Rec."Preference Criterion")
                {
                    ApplicationArea = all;
                }
                field("Country/Region of Origin Code"; Rec."Country/Region of Origin Code")
                {
                    ApplicationArea = all;
                }
                field("Net Cost"; Rec."Net Cost")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Shortcut Dimension 7 Code"; Rec."Shortcut Dimension 7 Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Shortcut Dimension 8 Code"; Rec."Shortcut Dimension 8 Code")
                {
                    ApplicationArea = all;
                }
                field("Product ID Code"; Rec."Product ID Code")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}