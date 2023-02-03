pageextension 80139 "BA Item Template" extends "Item Template Card"
{
    layout
    {
        addbefore(TemplateEnabled)
        {
            field("BA Product Profile Code"; Rec."BA Product Profile Code")
            {
                ApplicationArea = all;

                trigger OnValidate()
                var
                    ProductProfile: Record "BA Product Profile";
                    RecRef: RecordRef;
                    i: Integer;
                begin
                    if (Rec."BA Product Profile Code" = xRec."BA Product Profile Code") or (Rec."BA Product Profile Code" = '') then
                        exit;
                    ProductProfile.Get(Rec."BA Product Profile Code");
                    RecRef.GetTable(Rec);
                    SetValueFromProductProfile(RecRef, Rec.FieldNo("Gen. Prod. Posting Group"), ProductProfile."Gen. Prod. Posting Group");
                    SetValueFromProductProfile(RecRef, Rec.FieldNo("ENC Manufacturing Dept."), ProductProfile."Manufacturing Dept.");
                    SetValueFromProductProfile(RecRef, Rec.FieldNo("BA Item Tracking Code"), ProductProfile."Item Tracking Code");
                    SetValueFromProductProfile(RecRef, Rec.FieldNo("Item Category Code"), ProductProfile."Item Category Code");
                    SetValueFromProductProfile(RecRef, Rec.FieldNo("BA Core Product Code"), ProductProfile."Core Product Code");
                    SetValueFromProductProfile(RecRef, Rec.FieldNo("BA Core Prod. Model Code"), ProductProfile."Core Prod. Model Code");
                    SetValueFromProductProfile(RecRef, Rec.FieldNo("BA Core Prod. Sub. Cat. Code"), ProductProfile."Core Prod. Sub. Cat. Code");
                    SetValueFromProductProfile(RecRef, Rec.FieldNo("BA International HS Code"), ProductProfile."International HS Code");
                    SetValueFromProductProfile(RecRef, Rec.FieldNo("BA US HS Code"), ProductProfile."US HS Code");
                    SetValueFromProductProfile(RecRef, Rec.FieldNo("BA CUSMA"), ProductProfile.CUSMA);
                    SetValueFromProductProfile(RecRef, Rec.FieldNo("BA Producer"), ProductProfile.Producer);
                    SetValueFromProductProfile(RecRef, Rec.FieldNo("BA Preference Criterion"), ProductProfile."Preference Criterion");
                    SetValueFromProductProfile(RecRef, Rec.FieldNo("BA Country of Origin Code"), ProductProfile."Country/Region of Origin Code");
                    SetValueFromProductProfile(RecRef, Rec.FieldNo("BA Net Cost"), ProductProfile."Net Cost");
                    SetValueFromProductProfile(RecRef, Rec.FieldNo(Type), ProductProfile.Type);
                    SetValueFromProductProfile(RecRef, Rec.FieldNo("Base Unit of Measure"), ProductProfile."Base Unit of Measure");
                    SetValueFromProductProfile(RecRef, Rec.FieldNo("ENC Base Unit of Measure"), ProductProfile."Base Unit of Measure");
                    SetValueFromProductProfile(RecRef, Rec.FieldNo("Inventory Posting Group"), ProductProfile."Inventory Posting Group");
                    SetValueFromProductProfile(RecRef, Rec.FieldNo("Costing Method"), ProductProfile."Costing Method");
                    SetValueFromProductProfile(RecRef, Rec.FieldNo("Price/Profit Calculation"), ProductProfile."Price/Profit Calculation");
                    SetValueFromProductProfile(RecRef, Rec.FieldNo("ENC Assembly Policy"), ProductProfile."Assembly Policy", false);
                    SetValueFromProductProfile(RecRef, Rec.FieldNo("ENC Replenishment System"), ProductProfile."Replenishment System", false);
                    SetValueFromProductProfile(RecRef, Rec.FieldNo("ENC Manufacturing Policy"), ProductProfile."Manufacturing Policy");
                    SetValueFromProductProfile(RecRef, Rec.FieldNo("ENC Reordering Policy"), ProductProfile."Reordering Policy");
                    SetValueFromProductProfile(RecRef, Rec.FieldNo("ENC Reserve"), ProductProfile.Reserve);
                    RecRef.SetTable(Rec);
                    // Rec.Validate("ENC Assembly Policy");
                    // Rec.Validate("ENC Replenishment System");
                    CurrPage.Update(true);
                    Rec.Get(Rec.RecordId());
                    RecRef.GetTable(Rec);
                    SetValueFromProductProfile(RecRef, Rec.FieldNo("ENC Shortcut Dimension 1 Code"), ProductProfile."Shortcut Dimension 1 Code");
                    SetValueFromProductProfile(RecRef, Rec.FieldNo("ENC Shortcut Dimension 2 Code"), ProductProfile."Shortcut Dimension 2 Code");
                    SetValueFromProductProfile(RecRef, Rec.FieldNo("ENC Shortcut Dimension 3 Code"), ProductProfile."Shortcut Dimension 3 Code");
                    SetValueFromProductProfile(RecRef, Rec.FieldNo("ENC Shortcut Dimension 4 Code"), ProductProfile."Shortcut Dimension 4 Code");
                    SetValueFromProductProfile(RecRef, Rec.FieldNo("ENC Shortcut Dimension 5 Code"), ProductProfile."Shortcut Dimension 5 Code");
                    SetValueFromProductProfile(RecRef, Rec.FieldNo("ENC Shortcut Dimension 6 Code"), ProductProfile."Shortcut Dimension 6 Code");
                    SetValueFromProductProfile(RecRef, Rec.FieldNo("ENC Shortcut Dimension 7 Code"), ProductProfile."Shortcut Dimension 7 Code");
                    SetValueFromProductProfile(RecRef, Rec.FieldNo("ENC Shortcut Dimension 8 Code"), ProductProfile."Shortcut Dimension 8 Code");
                    SetValueFromProductProfile(RecRef, Rec.FieldNo("ENC Product ID Code"), ProductProfile."Product ID Code");
                    RecRef.SetTable(Rec);
                    Rec.Modify(true);
                    for i := 1 to 9 do
                        ValidateDimCode(i);
                    CurrPage.Update(false);
                    Rec.Get(Rec.RecordId());
                end;
            }
        }

        modify("Warehouse Class Code")
        {
            ApplicationArea = all;
            Visible = false;
        }
        modify("Service Item Group")
        {
            ApplicationArea = all;
            Visible = false;
        }
        modify("Item Category Code")
        {
            ApplicationArea = all;
            Visible = false;
        }
        modify("Gen. Prod. Posting Group")
        {
            ApplicationArea = all;
            Visible = false;
        }
        modify("Inventory Posting Group")
        {
            ApplicationArea = all;
            Visible = false;
        }
        addlast(Categorization)
        {
            field("BA International HS Code"; Rec."BA International HS Code")
            {
                ApplicationArea = all;
            }
            field("BA US HS Code"; Rec."BA US HS Code")
            {
                ApplicationArea = all;
            }
            field("BA CUSMA"; Rec."BA CUSMA")
            {
                ApplicationArea = all;
            }
            field("BA Producer"; Rec."BA Producer")
            {
                ApplicationArea = all;
            }
            field("BA Preference Criterion"; Rec."BA Preference Criterion")
            {
                ApplicationArea = all;
            }
            field("BA Country of Origin Code"; Rec."BA Country of Origin Code")
            {
                ApplicationArea = all;
            }
            field("BA Net Cost"; Rec."BA Net Cost")
            {
                ApplicationArea = all;
            }
        }
        addlast("Item Setup")
        {
            field("ENC Not for Sale"; Rec."ENC Not for Sale")
            {
                ApplicationArea = all;
            }
            field("BA Core Product Code"; Rec."BA Core Product Code")
            {
                ApplicationArea = all;
            }
            field("BA Core Prod. Model Code"; Rec."BA Core Prod. Model Code")
            {
                ApplicationArea = all;
            }
            field("BA Core Prod. Sub. Cat. Code"; Rec."BA Core Prod. Sub. Cat. Code")
            {
                ApplicationArea = all;
            }
            field("Gen. Prod. Posting Group2"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = all;
            }
            field("Inventory Posting Group2"; Rec."Inventory Posting Group")
            {
                ApplicationArea = all;
            }
            field("BA Item Tracking Code"; "BA Item Tracking Code")
            {
                ApplicationArea = all;
            }

            group("Dimensions")
            {
                field("ENC Shortcut Dimension 1 Code"; Rec."ENC Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        ValidateDimCode(1);
                    end;
                }
                field("ENC Shortcut Dimension 2 Code"; Rec."ENC Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        ValidateDimCode(2);
                    end;
                }
                // field("ENC Shortcut Dimension 3 Code"; Rec."ENC Shortcut Dimension 3 Code")
                // {
                //     ApplicationArea = all;

                //     trigger OnValidate()
                //     begin
                //         ValidateDimCode(3);
                //     end;
                // }
                // field("ENC Shortcut Dimension 4 Code"; Rec."ENC Shortcut Dimension 4 Code")
                // {
                //     ApplicationArea = all;

                //     trigger OnValidate()
                //     begin
                //         ValidateDimCode(4);
                //     end;
                // }
                // field("ENC Shortcut Dimension 5 Code"; Rec."ENC Shortcut Dimension 5 Code")
                // {
                //     ApplicationArea = all;

                //     trigger OnValidate()
                //     begin
                //         ValidateDimCode(5);
                //     end;
                // }
                // field("ENC Shortcut Dimension 6 Code"; Rec."ENC Shortcut Dimension 6 Code")
                // {
                //     ApplicationArea = all;

                //     trigger OnValidate()
                //     begin
                //         ValidateDimCode(6);
                //     end;
                // }
                // field("ENC Shortcut Dimension 7 Code"; Rec."ENC Shortcut Dimension 7 Code")
                // {
                //     ApplicationArea = all;

                //     trigger OnValidate()
                //     begin
                //         ValidateDimCode(7);
                //     end;
                // }
                field("ENC Shortcut Dimension 8 Code"; Rec."ENC Shortcut Dimension 8 Code")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        ValidateDimCode(8);
                    end;
                }
                field("ENC Product ID Code"; Rec."ENC Product ID Code")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        ValidateDimCode(9);
                    end;
                }
            }
        }
    }

    actions
    {
        modify("Default Dimensions")
        {
            ApplicationArea = all;
            Visible = false;
            Enabled = false;
        }
        addafter("Default Dimensions")
        {
            action(Dimensions2)
            {
                Caption = 'Dimensions';
                ApplicationArea = all;
                Image = Dimensions;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                Enabled = Code <> '';

                trigger OnAction()
                var
                    RecVariant: Variant;
                begin
                    RecVariant := Rec;
                    SEIFunctions.ApplyTemplateDimensions(RecVariant, TemplateDim, Database::Item, Code, "ENC Template Code");
                    Rec := RecVariant;
                    CurrPage.Update(true);
                end;
            }
        }
    }


    local procedure ValidateDimCode(DimID: Integer)
    var
        RecVariant: Variant;
        FldNo: Integer;
    begin
        if DimID = 9 then
            FldNo := Rec.FieldNo("ENC Product ID Code")
        else
            FldNo := Rec.FieldNo("ENC Shortcut Dimension 1 Code");
        RecVariant := Rec;
        SEIFunctions.ValidateTemplateDimCode(TemplateDim, RecVariant, Database::Item, DimID, FldNo, "ENC Template Code");
    end;

    trigger OnAfterGetRecord()
    begin
        if (OldRecCode = Code) and (Code <> '') then
            exit;
        SEIFunctions.LoadTemplateDimensions(TemplateDim, Database::Item, "ENC Template Code");
        OldRecCode := Code;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        TemplateDim.Reset;
        TemplateDim.DeleteAll;
    end;

    local procedure SetValueFromProductProfile(var RecRef: RecordRef; FldNo: Integer; FldValue: Variant)
    begin
        SetValueFromProductProfile(RecRef, FldNo, FldValue, true)
    end;

    local procedure SetValueFromProductProfile(var RecRef: RecordRef; FldNo: Integer; FldValue: Variant; Validate: Boolean)
    begin
        if Format(FldValue) = '' then
            exit;
        if Validate then
            RecRef.Field(FldNo).Validate(FldValue)
        else
            RecRef.Field(FldNo).Value(FldValue);
    end;



    var
        TemplateDim: Record "Dimensions Template" temporary;
        SEIFunctions: Codeunit "ENC SEI Functions";
        OldRecCode: Code[10];
}