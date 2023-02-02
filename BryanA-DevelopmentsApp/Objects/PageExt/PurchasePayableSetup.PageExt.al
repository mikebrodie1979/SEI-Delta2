pageextension 80008 "BA Purch. & Payables Setup" extends "Purchases & Payables Setup"
{
    layout
    {
        addlast("Number Series")
        {
            field("BA Requisition Nos."; Rec."BA Requisition Nos.")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the code for the number series that will be used to assign numbers to requisition orders.';
            }
            field("BA Requisition Receipt Nos."; Rec."BA Requisition Receipt Nos.")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the code for the number series that will be used to assign numbers to posted requisition receipts.';
            }
            field("BA Requisition Return Nos."; Rec."BA Requisition Return Nos.")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the code for the number series that will be used to assign numbers to requisition return orders.';
            }
            field("BA Req. Return Shipment Nos."; "BA Req. Return Shipment Nos.")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the code for the number series that will be used to assign numbers to posted requisition return shipments.';
            }
            // field("BA Requisition Cr.Memo Nos."; Rec."BA Requisition Cr.Memo Nos.")
            // {
            //     ApplicationArea = all;
            //     ToolTip = 'Specifies the code for the number series that will be used to assign numbers to requisition credit memos.';
            // }
            // field("BA Posted Req. Cr.Memo Nos."; "BA Posted Req. Cr.Memo Nos.")
            // {
            //     ApplicationArea = all;
            //     ToolTip = 'Specifies the code for the number series that will be used to assign numbers to posted requisition credit memos.';
            // }
        }
    }
}
