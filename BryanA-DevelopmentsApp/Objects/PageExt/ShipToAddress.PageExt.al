pageextension 80049 "BA Ship-to Address" extends "Ship-to Address"
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
        modify(GLN)
        {
            ApplicationArea = all;
            Visible = false;
        }
        modify("Fax No.")
        {
            ApplicationArea = all;
            Visible = false;
        }
        modify("Home Page")
        {
            ApplicationArea = all;
            Visible = false;
        }
        modify("Service Zone Code")
        {
            ApplicationArea = all;
            Visible = false;
        }
        modify("Country/Region Code")
        {
            ApplicationArea = all;
            Caption = 'Country';
        }
        modify("Shipping Agent Code")
        {
            ApplicationArea = all;
            Visible = false;
            Editable = false;
            Enabled = false;
        }
        modify("Shipment Method Code")
        {
            ApplicationArea = all;
            Visible = false;
            Editable = false;
            Enabled = false;
        }
        modify("Shipping Agent Service Code")
        {
            ApplicationArea = all;
            Visible = false;
            Editable = false;
            Enabled = false;
        }
        addafter("Shipping Agent Service Code")
        {
            field("BA Freight Carrier"; "Shipping Agent Code")
            {
                ApplicationArea = all;
                Caption = 'Freight Carrier';
            }
            field("BA Service Level"; "Shipment Method Code")
            {
                ApplicationArea = all;
                Caption = 'Service Level';
            }
            field("BA Freight Term"; ServiceCode)
            {
                ApplicationArea = all;
                Caption = 'Freight Term';
                TableRelation = "ENC Freight Term".Code;

                trigger OnValidate()
                begin
                    Rec."Shipping Agent Service Code" := ServiceCode;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        ServiceCode := Rec."Shipping Agent Service Code";
    end;

    var
        ServiceCode: Code[10];
}