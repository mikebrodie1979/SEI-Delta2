// report 50085 "BA Remove Return Order"
// {
//     Permissions = tabledata customer = m,
//     tabledata "Sales Header" = d;

//     ApplicationArea = all;
//     UsageCategory = Tasks;
//     ProcessingOnly = true;
//     UseRequestPage = false;

//     trigger OnPreReport()
//     var
//         SalesHeader: Record "Sales Header";
//     begin
//         if not Confirm('Delete SR001358?') then
//             exit;
//         //SR001358

//         SalesHeader.Get(SalesHeader."Document Type"::"Return Order", 'SR001358');
//         SalesHeader.Delete(true);
//     end;
// }