pageextension 80056 "BA Vendor Card" extends "Vendor Card"
{
    layout
    {
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
        modify("Country/Region Code")
        {
            ApplicationArea = all;
            Visible = false;
        }
        addfirst(AddressDetails)
        {
            field("BA Country/Region Code"; "Country/Region Code")
            {
                ApplicationArea = all;
                Caption = 'Country';
            }
        }
        addafter(County)
        {
            field("BA County Fullname"; "BA County Fullname")
            {
                ApplicationArea = all;
            }
        }
        modify(County)
        {
            trigger OnAfterValidate()
            begin
                Rec.CalcFields("BA County Fullname");
            end;
        }
    }
}