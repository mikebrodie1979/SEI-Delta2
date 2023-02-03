pageextension 80023 "BA Released Prod. Order" extends "Released Production Order"
{
    layout
    {
        addafter(Blocked)
        {
            field("BA NC Work Completed"; "BA NC Work Completed")
            {
                ApplicationArea = all;
            }
            field("BA All Quantities Completed"; "BA All Quantities Completed")
            {
                ApplicationArea = all;
            }
        }
        modify("Location Code")
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                Subscribers: Codeunit "BA SEI Subscibers";
            begin
                Text := Subscribers.LocationListLookup();
                exit(Text <> '');
            end;
        }
        addafter("Source No.")
        {
            field("BA Source Version"; Rec."BA Source Version")
            {
                ApplicationArea = all;
            }
        }
    }
}