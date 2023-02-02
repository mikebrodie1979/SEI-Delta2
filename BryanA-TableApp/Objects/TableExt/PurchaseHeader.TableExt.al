tableextension 80007 "BA Purchase Header" extends "Purchase Header"
{
    fields
    {
        field(80000; "BA Requisition Order"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Requisition Order';
            Editable = false;
            Description = 'System field to specify Requisition Orders';
        }
        field(80001; "BA Fully Rec'd. Req. Order"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Fully Received Requisition Order';
            Editable = false;
            Description = 'System field to specify when a Requisition Order is to be considered fully recieved/posted';
        }
        field(80005; "BA Omit Orders"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Omit from Outstanding Orders';
        }

        modify("Buy-from County")
        {
            TableRelation = "BA Province/State".Symbol where ("Country/Region Code" = field ("Buy-from Country/Region Code"));
        }
        modify("Pay-to County")
        {
            TableRelation = "BA Province/State".Symbol where ("Country/Region Code" = field ("Pay-to Country/Region Code"));
        }
        modify("Ship-to County")
        {
            TableRelation = "BA Province/State".Symbol where ("Country/Region Code" = field ("Ship-to Country/Region Code"));
        }
    }
}