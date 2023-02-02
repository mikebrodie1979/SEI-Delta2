tableextension 80006 "BA Purch. & Payables Setup" extends "Purchases & Payables Setup"
{
    fields
    {
        field(80000; "BA Requisition Nos."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Requisition Nos.';
            TableRelation = "No. Series".Code;
        }
        field(80001; "BA Requisition Receipt Nos."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Requisition Receipt Nos.';
            TableRelation = "No. Series".Code;
        }
        field(80002; "BA Requisition Return Nos."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Requisition Return Nos.';
            TableRelation = "No. Series".Code;
        }
        field(80003; "BA Requisition Cr.Memo Nos."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Requisition Credit Memo Nos.';
            TableRelation = "No. Series".Code;
        }
        field(80004; "BA Req. Return Shipment Nos."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Requisition Return Shipment Nos.';
            TableRelation = "No. Series".Code;
        }
        field(80005; "BA Posted Req. Cr.Memo Nos."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Posted Requisition Credit Memo Nos.';
            TableRelation = "No. Series".Code;
        }
    }
}