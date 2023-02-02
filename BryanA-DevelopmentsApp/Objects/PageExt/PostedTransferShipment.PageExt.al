pageextension 80038 "BA Posted Transfer Shpt." extends "Posted Transfer Shipment"
{
    layout
    {
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