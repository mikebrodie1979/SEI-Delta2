pageextension 80037 "BA Posted Transfer Rcpt." extends "Posted Transfer Receipt"
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