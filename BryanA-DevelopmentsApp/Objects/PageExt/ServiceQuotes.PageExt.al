// pageextension 80093 "BA Serv ice Quotes" extends "Service Quotes"
// {
//     layout
//     {
//         modify(Control1902018507)
//         {
//             Visible = ShowLCYBalances;
//         }
//         addafter(Control1902018507)
//         {
//             part("BA Non-LCY Customer Statistics Factbox"; "BA Non-LCY Cust. Stat. Factbox")
//             {
//                 SubPageLink = "No." = Field ("Bill-to Customer No.");
//                 Visible = not ShowLCYBalances;
//                 ApplicationArea = all;
//             }
//         }
//     }

//     var
//         [InDataSet]
//         ShowLCYBalances: Boolean;

//     trigger OnAfterGetRecord()
//     var
//         CustPostingGroup: Record "Customer Posting Group";
//     begin
//         ShowLCYBalances := CustPostingGroup.Get(Rec."Customer Posting Group") and not CustPostingGroup."BA Show Non-Local Currency";
//     end;
// }