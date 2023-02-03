pageextension 80036 "BA Transfer Order" extends "Transfer Order"
{
    layout
    {
        modify("Transfer-from Code")
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                Subscribers: Codeunit "BA SEI Subscibers";
            begin
                Text := Subscribers.LocationListLookup();
                exit(Text <> '');
            end;
        }
        modify("Transfer-to Code")
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                Subscribers: Codeunit "BA SEI Subscibers";
            begin
                Text := Subscribers.LocationListLookup();
                exit(Text <> '');
            end;
        }
        addlast("Transfer-to")
        {
            field("BA Transfer-To Phone No."; Rec."BA Transfer-To Phone No.")
            {
                ApplicationArea = all;
            }
            field("BA Transfer-To FID No."; Rec."BA Transfer-To FID No.")
            {
                ApplicationArea = all;
            }
        }
    }
}