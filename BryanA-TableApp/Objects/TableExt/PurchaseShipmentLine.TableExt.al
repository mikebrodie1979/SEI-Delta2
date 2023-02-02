tableextension 80016 "BA Return Shpt. Line" extends "Return Shipment Line"
{
    fields
    {
        field(80001; "BA Requisition Order"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Requisition Order';
            Editable = false;
            Description = 'System field to specify Requisition Orders';
        }
        field(80005; "BA Line Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Line Amount Excl. Tax';
            Editable = false;
        }
        field(80006; "BA Line Discount Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Line Discount Amount';
            Editable = false;
        }
    }
}