pageextension 80030 "BA Purchase Order" extends "Purchase Order"
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
        addbefore("Assigned User ID")
        {
            field("BA Omit Orders"; Rec."BA Omit Orders")
            {
                ApplicationArea = all;
            }
        }
        addafter("Order Date")
        {
            field("Expected Receipt Date2"; Rec."Expected Receipt Date")
            {
                ApplicationArea = all;
            }
        }
        modify("Expected Receipt Date")
        {
            ApplicationArea = all;
            Visible = false;
        }
        modify("Buy-from Country/Region Code")
        {
            ApplicationArea = all;
            Visible = false;
            Enabled = false;
        }
        addfirst("Buy-from")
        {
            field("BA Buy-from Country/Region Code"; "Buy-from Country/Region Code")
            {
                ApplicationArea = all;
                Caption = 'Country';
            }
        }
        modify("Pay-to Country/Region Code")
        {
            ApplicationArea = all;
            Visible = false;
            Enabled = false;
        }
        addfirst(Control95)
        {
            field("BA Pay-to Country/Region Code"; "Pay-to Country/Region Code")
            {
                ApplicationArea = all;
                Caption = 'Country';
            }
        }
        modify("Ship-to Country/Region Code")
        {
            ApplicationArea = all;
            Visible = false;
            Enabled = false;
        }
        addbefore("Ship-to Name")
        {
            field("BA Ship-to Country/Region Code"; "Ship-to Country/Region Code")
            {
                ApplicationArea = all;
                Caption = 'Country';
            }
        }
    }
}