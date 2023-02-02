// report 80099 "BA Uninstall Apps"
// {
//     Caption = 'Uninstall BryanA Extensions';
//     ProcessingOnly = true;
//     ApplicationArea = all;
//     UsageCategory = Administration;

//     requestpage
//     {
//         SaveValues = true;

//         layout
//         {
//             area(Content)
//             {
//                 group(Options)
//                 {
//                     field(RemoveTableApp; RemoveTableApp)
//                     {
//                         Caption = 'Uninstall Table App';
//                         ApplicationArea = all;
//                     }
//                 }
//             }
//         }
//     }

//     trigger OnInitReport()
//     var
//         User: Record User;
//     begin
//         if StrPos(UserId, 'ENCORE') = 0 then
//             Error(UserPermissionErr);
//     end;

//     trigger OnPreReport()
//     var
//         NAVApp: Record "NAV App";
//         ExtMgt: Codeunit NavExtensionInstallationMgmt;
//         DisplayStr: TextBuilder;
//     begin
//         TableAppGUID := 'd30af3a7-247a-5555-80a1-9b82e52ee5a6';
//         NAVApp.SetRange(Publisher, PublisherName);
//         NAVApp.SetFilter(ID, '<>%1', TableAppGUID);

//         with NAVApp do begin
//             if FindSet then
//                 repeat
//                     DisplayStr.AppendLine(StrSubstNo(RemovedAppMsg, Name, "Version Major", "Version Build", "Version Minor", "Version Revision"));
//                     ExtMgt.UninstallNavExtension("Package ID");
//                     ExtMgt.UnpublishNavTenantExtension("Package ID");
//                 until Next = 0;

//             if RemoveTableApp then begin
//                 SetRange(ID, TableAppGUID);
//                 FindFirst;
//                 DisplayStr.AppendLine(StrSubstNo(RemovedTableAppMsg, Name, "Version Major", "Version Build", "Version Minor", "Version Revision"));
//                 ExtMgt.UninstallNavExtension("Package ID");
//                 ExtMgt.UnpublishNavTenantExtension("Package ID");
//             end;
//         end;

//         if DisplayStr.ToText = '' then
//             Error(NoInstalledAppsErr);
//         Message(DisplayStr.ToText);
//     end;


//     var

//         RemoveTableApp: Boolean;
//         TableAppGUID: Guid;


//         PublisherName: Label 'BryanA BC Developments Inc.';
//         NoInstalledAppsErr: Label 'No installed BryanA apps to remove!';
//         RemovedAppMsg: Label 'Removed %1 %2.%3.%4.%5';
//         RemovedTableAppMsg: Label 'Removed Table App %1 %2.%3.%4.%5';
//         UserPermissionErr: Label 'You not do have permissions to run this report.';
// }