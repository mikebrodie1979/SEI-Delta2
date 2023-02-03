codeunit 75010 "BA SEI Subscibers"
{
    Permissions = tabledata "Return Shipment Header" = rimd,
                  tabledata "Purch. Rcpt. Header" = rimd,
                  tabledata "Sales Shipment Line" = i,
                  tabledata "Item Ledger Entry" = rimd;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnBeforeOnRun', '', false, false)]
    local procedure SalesQuoteToOrderOnBeforeRun(var SalesHeader: Record "Sales Header")
    begin
        SalesHeader."BA Copied Doc." := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Invoice", 'OnBeforeOnRun', '', false, false)]
    local procedure SalesQuoteToInvoiceOnBeforeRun(var SalesHeader: Record "Sales Header")
    begin
        SalesHeader."BA Copied Doc." := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterInitRecord', '', false, false)]
    local procedure SalesHeaderOnAfterInitRecord(var SalesHeader: Record "Sales Header")
    begin
        case SalesHeader."Document Type" of
            SalesHeader."Document Type"::Quote:
                begin
                    SalesHeader.Validate("ENC Stage", SalesHeader."ENC Stage"::Open);
                    SalesHeader.Validate("Shipment Date", 0D);
                end;
            SalesHeader."Document Type"::Order:
                SalesHeader.Validate("Shipment Date", 0D);
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnCheckItemAvailabilityInLinesOnAfterSetFilters', '', false, false)]
    local procedure SalesHeaderOnCheckItemAvailabilityInLinesOnAfterSetFilters(var SalesLine: Record "Sales Line")
    begin
        SalesLine.SetFilter("Shipment Date", '<>%1', 0D);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'No.', false, false)]
    local procedure SalesLineOnAfterValdiateNo(var Rec: Record "Sales Line"; var xRec: Record "Sales Line")
    begin
        if Rec."No." <> xRec."No." then
            ClearShipmentDates(Rec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'Quantity', false, false)]
    local procedure SalesLineOnAfterValdiateQuantity(var Rec: Record "Sales Line"; var xRec: Record "Sales Line")
    begin
        if Rec.Quantity <> xRec.Quantity then
            ClearShipmentDates(Rec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeSalesLineByChangedFieldNo', '', false, false)]
    local procedure SalesHeaderOnBeforeSalesLineByChangedFieldNo(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; var IsHandled: Boolean; ChangedFieldNo: Integer)
    var
        AssembleToOrderLink: Record "Assemble-to-Order Link";
    begin
        if (SalesHeader."Shipment Date" = 0D) and AssembleToOrderLink.AsmExistsForSalesLine(SalesLine)
                and (ChangedFieldNo = SalesHeader.FieldNo("Shipment Date")) and (SalesLine."Shipment Date" <> 0D) then
            IsHandled := true;
    end;

    local procedure ClearShipmentDates(var Rec: Record "Sales Line")
    var
        SalesHeader: Record "Sales Header";
        AssembleToOrderLink: Record "Assemble-to-Order Link";
    begin
        if not SalesHeader.Get(Rec."Document Type", Rec."Document No.") or Rec.IsTemporary or (SalesHeader."Shipment Date" <> 0D)
                or not (Rec."Document Type" in [Rec."Document Type"::Quote, Rec."Document Type"::Order])
                  or AssembleToOrderLink.AsmExistsForSalesLine(Rec)
                 then
            exit;
        Rec.Validate("Shipment Date", 0D);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'Shipment Date', false, false)]
    local procedure SalesLineOnAfterValdiateShipmentDate(var Rec: Record "Sales Line"; var xRec: Record "Sales Line")
    var
        SalesHeader: Record "Sales Header";
    begin
        if not SalesHeader.Get(Rec."Document Type", Rec."Document No.") or Rec.IsTemporary or (Rec."Shipment Date" = xRec."Shipment Date")
                or not (Rec."Document Type" in [Rec."Document Type"::Quote, Rec."Document Type"::Order]) then
            exit;
        if Rec."Shipment Date" <> 0D then
            exit;
        Rec.Validate("Planned Delivery Date", 0D);
        Rec.Validate("Planned Shipment Date", 0D);
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Activity-Post", 'OnBeforeCheckLines', '', false, false)]
    local procedure WhseActivityPostOnBeforeCheckLines(var WhseActivityHeader: Record "Warehouse Activity Header")
    var
        SalesLine: Record "Sales Line";
    begin
        if (WhseActivityHeader."Source Type" <> Database::"Sales Line") or (WhseActivityHeader."Source Subtype" <> WhseActivityHeader."Source Subtype"::"1") then
            exit;
        SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SetRange("Document No.", WhseActivityHeader."Source No.");
        SalesLine.FindSet(true);
        repeat
            SalesLine."BA Org. Qty. To Ship" := SalesLine."Qty. to Ship";
            SalesLine."BA Org. Qty. To Invoice" := SalesLine."Qty. to Invoice";
            SalesLine.Modify(false);
        until SalesLine.Next() = 0;
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Activity-Post", 'OnCodeOnAfterCreatePostedWhseActivDocument', '', false, false)]
    local procedure WhseActivityPostOnAfterWhseActivLineModify(var WhseActivityHeader: Record "Warehouse Activity Header")
    var
        WhseActivityLine: Record "Warehouse Activity Line";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
    begin
        WhseActivityLine.SetRange("Activity Type", WhseActivityHeader.Type);
        WhseActivityLine.SetRange("No.", WhseActivityHeader."No.");
        WhseActivityLine.SetRange("Source Type", Database::"Sales Line");
        WhseActivityLine.SetRange("Source Subtype", WhseActivityLine."Source Subtype"::"1");
        WhseActivityLine.SetFilter("Qty. to Handle", '>%1', 0);
        WhseActivityLine.SetFilter(Quantity, '>%1', 0);
        if not WhseActivityLine.FindSet() then
            exit;

        SalesHeader.Get(SalesHeader."Document Type"::Order, WhseActivityLine."Source No.");
        if not SalesHeader.Invoice then
            repeat
                if SalesLine.Get(SalesLine."Document Type"::Order, WhseActivityLine."Source No.", WhseActivityLine."Source Line No.") then begin
                    SalesLine.Validate("Qty. to Invoice", WhseActivityLine.Quantity);
                    SalesLine.Modify(true);
                end;
            until WhseActivityLine.Next() = 0;

        SalesLine.SetRange("Document No.", WhseActivityLine."Source No.");
        if SalesLine.FindSet() then
            repeat
                WhseActivityLine.SetRange("Source Line No.", SalesLine."Line No.");
                if WhseActivityLine.IsEmpty() then begin
                    if SalesHeader.Invoice then
                        SalesLine.Validate("Qty. to Ship", SalesLine."BA Org. Qty. To Ship");
                    SalesLine.Validate("Qty. to Invoice", SalesLine."BA Org. Qty. To Invoice");
                    SalesLine.Modify(true);
                end;
            until SalesLine.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Assembly Line Management", 'OnAfterTransferBOMComponent', '', false, false)]
    local procedure AssemblyLineMgtOnAfterTransferBOMComponent(var AssemblyLine: Record "Assembly Line"; BOMComponent: Record "BOM Component")
    begin
        if not BOMComponent."BA Optional" then
            exit;
        AssemblyLine.Validate(Quantity, 0);
        AssemblyLine.Validate("Quantity per", 0);
        AssemblyLine.Validate("BA Optional", true);
    end;


    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterGetNoSeriesCode', '', false, false)]
    local procedure PurchaseHeaderOnAfterGetNoSeriesCode(var PurchHeader: Record "Purchase Header"; var NoSeriesCode: Code[20])
    var
        PurchPaySetup: Record "Purchases & Payables Setup";
    begin
        if not PurchHeader."BA Requisition Order" then
            exit;
        PurchPaySetup.Get();
        case PurchHeader."Document Type" of
            PurchHeader."Document Type"::Order, PurchHeader."Document Type"::Invoice:
                begin
                    PurchPaySetup.TestField("BA Requisition Nos.");
                    NoSeriesCode := PurchPaySetup."BA Requisition Nos.";
                end;
            PurchHeader."Document Type"::"Credit Memo":
                begin
                    PurchPaySetup.TestField("BA Requisition Cr.Memo Nos.");
                    NoSeriesCode := PurchPaySetup."BA Requisition Cr.Memo Nos.";
                end;
            PurchHeader."Document Type"::"Return Order":
                begin
                    PurchPaySetup.TestField("BA Requisition Return Nos.");
                    NoSeriesCode := PurchPaySetup."BA Requisition Return Nos.";
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterInitRecord', '', false, false)]
    local procedure PurchaseHeaderOnAfterInitRecord(var PurchHeader: Record "Purchase Header")
    var
        PurchPaySetup: Record "Purchases & Payables Setup";
    begin
        if PurchHeader."Expected Receipt Date" = 0D then
            PurchHeader.Validate("Expected Receipt Date", WorkDate());
        if not PurchHeader."BA Requisition Order" then
            exit;
        PurchPaySetup.Get();
        case PurchHeader."Document Type" of
            PurchHeader."Document Type"::Order, PurchHeader."Document Type"::Invoice:
                begin
                    PurchPaySetup.TestField("BA Requisition Receipt Nos.");
                    PurchHeader."Receiving No. Series" := PurchPaySetup."BA Requisition Receipt Nos.";
                    PurchHeader."Posting No. Series" := PurchPaySetup."BA Requisition Receipt Nos.";
                end;
            PurchHeader."Document Type"::"Credit Memo":
                begin
                    PurchPaySetup.TestField("BA Posted Req. Cr.Memo Nos.");
                    PurchHeader."Return Shipment No. Series" := PurchPaySetup."BA Posted Req. Cr.Memo Nos.";
                    PurchHeader."Posting No. Series" := PurchPaySetup."BA Posted Req. Cr.Memo Nos.";
                end;
            PurchHeader."Document Type"::"Return Order":
                begin
                    PurchPaySetup.TestField("BA Req. Return Shipment Nos.");
                    PurchHeader."Return Shipment No. Series" := PurchPaySetup."BA Req. Return Shipment Nos.";
                    PurchHeader."Posting No. Series" := PurchPaySetup."BA Req. Return Shipment Nos.";
                end;
        end;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterInitHeaderDefaults', '', false, false)]
    local procedure PurchaseLineOnAfterInitHeaderDefaults(var PurchLine: Record "Purchase Line"; PurchHeader: Record "Purchase Header")
    begin
        if PurchHeader."BA Requisition Order" then
            PurchLine."BA Requisition Order" := true;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", 'OnBeforeConfirmPost', '', false, false)]
    local procedure PurchPostYesNoOnBeforeConfirmPost(var PurchaseHeader: Record "Purchase Header"; var HideDialog: Boolean)
    begin
        UpdatePostingConfirmation(PurchaseHeader, HideDialog);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post + Print", 'OnBeforeConfirmPost', '', false, false)]
    local procedure PurchPostPrintOnBeforeConfirmPost(var PurchaseHeader: Record "Purchase Header"; var HideDialog: Boolean)
    begin
        UpdatePostingConfirmation(PurchaseHeader, HideDialog);
    end;

    local procedure UpdatePostingConfirmation(var PurchaseHeader: Record "Purchase Header"; var HideDialog: Boolean)
    begin
        if not PurchaseHeader."BA Requisition Order" then
            exit;
        case PurchaseHeader."Document Type" of
            PurchaseHeader."Document Type"::Order, PurchaseHeader."Document Type"::Invoice:
                begin
                    HideDialog := true;
                    if not Confirm(StrSubstNo('Receive Requisition Order %1?', PurchaseHeader."No.")) then
                        Error('');
                    PurchaseHeader.Receive := true;
                end;
            PurchaseHeader."Document Type"::"Return Order":
                begin
                    HideDialog := true;
                    if not Confirm(StrSubstNo('Ship Requisition Return Order %1?', PurchaseHeader."No.")) then
                        Error('');
                    PurchaseHeader.Ship := true;
                end;
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", 'OnRunPreviewOnBeforePurchPostRun', '', false, false)]
    local procedure PurchPostYesNoOnRunPreviewOnBeforePurchPostRun(var PurchaseHeader: Record "Purchase Header")
    begin
        PurchaseHeader.Invoice := not PurchaseHeader."BA Requisition Order";
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPostItemLine', '', false, false)]
    local procedure PurchPostOnAfterPostItemLine(PurchaseLine: Record "Purchase Line")
    var
        PurchaseHeader: Record "Purchase Header";
        Item: Record Item;
        Currency: Record Currency;
        GLSetup: Record "General Ledger Setup";
        CurrencyExchageRate: Record "Currency Exchange Rate";
        ItemCostMgt: Codeunit ItemCostManagement;
        TotalAmount: Decimal;
        LastDirectCost: Decimal;
        FullyPostedReqOrder: Boolean;
    begin
        PurchaseHeader.Get(PurchaseLine."Document Type", PurchaseLine."Document No.");
        FullyPostedReqOrder := PurchaseHeader.Receive and PurchaseHeader."BA Requisition Order";
        if FullyPostedReqOrder and (PurchaseLine."Qty. to Receive" <> 0) then begin
            Item.Get(PurchaseLine."No.");
            GLSetup.Get();
            GLSetup.TestField("Unit-Amount Rounding Precision");
            TotalAmount := PurchaseLine."Unit Cost" * PurchaseLine."Qty. to Receive";
            LastDirectCost := Round(TotalAmount / PurchaseLine."Qty. to Receive", GLSetup."Unit-Amount Rounding Precision");
            if PurchaseHeader."Currency Code" <> '' then
                LastDirectCost := CurrencyExchageRate.ExchangeAmount(LastDirectCost, PurchaseHeader."Currency Code", '', PurchaseHeader."Posting Date");
            ItemCostMgt.UpdateUnitCost(Item, PurchaseLine."Location Code", PurchaseLine."Variant Code",
                LastDirectCost, 0, true, true, false, 0);
        end;
        if Currency.Get(PurchaseLine."Currency Code") and Currency."BA Local Purchase Cost" then
            if PurchaseHeader.Invoice or FullyPostedReqOrder then begin
                Item.Get(PurchaseLine."No.");
                Item.SetLastCurrencyPurchCost(Currency.Code, PurchaseLine."Unit Cost");
                Item.Modify(true);
            end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchRcptLineInsert', '', false, false)]
    local procedure PurchPostOnBeforePurchRcptLineInsert(var PurchLine: Record "Purchase Line"; var PurchRcptLine: Record "Purch. Rcpt. Line")
    var
        PurchLine2: Record "Purchase Line";
    begin
        PurchLine2.Get(PurchLine.RecordId());
        PurchRcptLine."BA Line Discount Amount" := PurchLine2."Line Discount Amount";
        PurchRcptLine."BA Line Amount" := PurchLine2."Line Amount";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeReturnShptLineInsert', '', false, false)]
    local procedure PurchPostOnBeforeReturnShptLineInsert(var PurchLine: Record "Purchase Line"; var ReturnShptLine: Record "Return Shipment Line")
    var
        PurchLine2: Record "Purchase Line";
    begin
        PurchLine2.Get(PurchLine.RecordId());
        ReturnShptLine."BA Line Discount Amount" := PurchLine2."Line Discount Amount";
        ReturnShptLine."BA Line Amount" := PurchLine2."Line Amount";
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterFinalizePosting', '', false, false)]
    local procedure PurchPostOnAfterFinalizePosting(var PurchHeader: Record "Purchase Header")
    var
        PurchLine: Record "Purchase Line";
    begin
        if not PurchHeader."BA Requisition Order" then
            exit;
        case PurchHeader."Document Type" of
            PurchHeader."Document Type"::Order, PurchHeader."Document Type"::Invoice:
                PurchHeader."BA Fully Rec'd. Req. Order" := PurchHeader.QtyToReceiveIsZero();
            PurchHeader."Document Type"::"Return Order":
                begin
                    PurchLine.SetRange("Document Type", PurchHeader."Document Type");
                    PurchLine.SetRange("Document No.", PurchHeader."No.");
                    if PurchLine.FindSet() then
                        repeat
                            if PurchLine."Return Qty. Shipped" <> PurchLine.Quantity then
                                exit;
                        until PurchLine.Next() = 0;
                    PurchHeader."BA Fully Rec'd. Req. Order" := true;
                end;
            else
                exit;
        end;
        PurchHeader.Modify(false);
    end;


    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterValidateEvent', 'No.', false, false)]
    local procedure PurchLineOnAfterValidateNo(var Rec: Record "Purchase Line")
    var
        Item: Record Item;
        PurchHeader: Record "Purchase Header";
        Currency: Record Currency;
        LastUnitCost: Decimal;
    begin
        if (Rec.Type <> Rec.Type::Item) or Rec.IsTemporary() or (Rec."No." = '') then
            exit;
        PurchHeader.Get(Rec."Document Type", Rec."Document No.");
        if not Currency.Get(PurchHeader."Currency Code") or not Currency."BA Local Purchase Cost" then
            exit;
        Item.Get(Rec."No.");
        LastUnitCost := Item.GetLastCurrencyPurchCost(Currency.Code);
        if LastUnitCost = 0 then
            exit;
        Rec.Validate("Direct Unit Cost", LastUnitCost);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Report Selections", 'OnPrintDocumentsOnAfterSelectTempReportSelectionsToPrint', '', false, false)]
    local procedure ReportSelectionsOnPrintDocumentsOnAfterSelectTempReportSelectionsToPrint(var TempReportSelections: Record "Report Selections"; RecordVariant: Variant)
    var
        PurchHeader: Record "Purchase Header";
        RecRef: RecordRef;
    begin
        RecRef.GetTable(RecordVariant);
        if RecRef.Number() <> Database::"Purchase Header" then
            exit;
        RecRef.SetTable(PurchHeader);
        if not PurchHeader."BA Requisition Order" then
            exit;
        TempReportSelections.Validate("Report ID", Report::"BA Requisition Order");
        TempReportSelections.Modify(false);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Transfer Header", 'OnAfterValidateEvent', 'Transfer-to Code', false, false)]
    local procedure TransferHeaderOnAfterValidateTransferToCode(var Rec: Record "Transfer Header"; var xRec: Record "Transfer Header")
    var
        Location: Record Location;
    begin
        if Rec.IsTemporary or (Rec."Transfer-to Code" = xRec."Transfer-to Code") or not Location.Get(Rec."Transfer-to Code") then
            exit;
        Rec.Validate("BA Transfer-To Phone No.", Location."Phone No.");
        Rec.Validate("BA Transfer-To FID No.", Location."BA FID No.");
        Rec.Modify(false);
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnAfterCheckSalesApprovalPossible', '', false, false)]
    local procedure ApprovalsMgtOnAfterCheckSalesApprovalPossible(var SalesHeader: Record "Sales Header")
    var
        Customer: Record Customer;
    begin
        SalesHeader.TestField("Sell-to Customer No.");
        Customer.Get(SalesHeader."Sell-to Customer No.");
        if not Customer."BA Int. Customer" then
            exit;
        SalesHeader.TestField("ENC BBD Sell-To No.");
        SalesHeader.TestField("ENC BBD Sell-To Name");
        SalesHeader.TestField("External Document No.");
        FormatInternationalExtDocNo(SalesHeader."External Document No.", SalesHeader.FieldCaption("External Document No."));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Service-Post", 'OnBeforePostWithLines', '', false, false)]
    local procedure ServicePostOnBeforePostWithLines(var PassedServHeader: Record "Service Header")
    var
        Customer: Record Customer;
    begin
        PassedServHeader.TestField("Customer No.");
        Customer.Get(PassedServHeader."Customer No.");
        if not Customer."BA Serv. Int. Customer" then
            exit;
        PassedServHeader.TestField("ENC BBD Sell-To No.");
        PassedServHeader.TestField("ENC BBD Sell-To Name");
        PassedServHeader.TestField("ENC External Document No.");
        FormatInternationalExtDocNo(PassedServHeader."ENC External Document No.", PassedServHeader.FieldCaption("External Document No."));
    end;

    local procedure FormatInternationalExtDocNo(var ExtDocNo: Code[35]; FieldCaption: Text)
    var
        Length: Integer;
        i: Integer;
        c: Char;
    begin
        Length := StrLen(ExtDocNo);
        if (ExtDocNo[1] <> 'S') or (ExtDocNo[2] <> 'O') then
            Error(ExtDocNoFormatError, FieldCaption, InvalidPrefixError);
        if Length = 2 then
            Error(ExtDocNoFormatError, FieldCaption, MissingNumeralError);
        if Length < 9 then
            Error(ExtDocNoFormatError, FieldCaption, TooShortSuffixError);
        for i := 3 to Length do begin
            c := ExtDocNo[i];
            if (c > '9') or (c < '0') then
                Error(ExtDocNoFormatError, FieldCaption, StrSubstNo(NonNumeralError, c));
        end;
        if Length > 9 then
            Error(ExtDocNoFormatError, FieldCaption, TooLongSuffixError);
    end;


    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterValidateEvent', 'Customer Posting Group', false, false)]
    local procedure CustomerOnAfterValidateCustomerPostingGroup(var Rec: Record Customer)
    var
        CustPostGroup: Record "Customer Posting Group";
    begin
        if Rec."Customer Posting Group" = '' then
            exit;
        CustPostGroup.Get(Rec."Customer Posting Group");
        if CustPostGroup."BA Blocked" then
            Error('%1 %2 is blocked', CustPostGroup.TableCaption, CustPostGroup.Code);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeAutoReserve', '', false, false)]
    local procedure SalesLineOnBeforeAutoReserve(SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    begin
        if SalesLine."Shipment Date" = 0D then
            IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Default Dimension", 'OnAfterValidateEvent', 'Dimension Value Code', false, false)]
    local procedure DefaultDimOnAfterValidateDimValueCode(var Rec: Record "Default Dimension"; var xRec: Record "Default Dimension")
    var
        Item: Record Item;
        GLSetup: Record "General Ledger Setup";
    begin
        if (Rec."Dimension Value Code" = xRec."Dimension Value Code") or (Rec."Table ID" <> Database::Item)
                or (Rec."No." = '') or not Item.Get(Rec."No.") then
            exit;
        GLSetup.Get();
        case true of
            Rec."Dimension Code" = GLSetup."Shortcut Dimension 1 Code":
                Item."Global Dimension 1 Code" := Rec."Dimension Value Code";
            Rec."Dimension Code" = GLSetup."Shortcut Dimension 2 Code":
                Item."Global Dimension 2 Code" := Rec."Dimension Value Code";
            Rec."Dimension Code" = GLSetup."Shortcut Dimension 3 Code":
                Item."ENC Shortcut Dimension 3 Code" := Rec."Dimension Value Code";
            Rec."Dimension Code" = GLSetup."Shortcut Dimension 4 Code":
                Item."ENC Shortcut Dimension 4 Code" := Rec."Dimension Value Code";
            Rec."Dimension Code" = GLSetup."Shortcut Dimension 5 Code":
                Item."ENC Shortcut Dimension 5 Code" := Rec."Dimension Value Code";
            Rec."Dimension Code" = GLSetup."Shortcut Dimension 6 Code":
                Item."ENC Shortcut Dimension 6 Code" := Rec."Dimension Value Code";
            Rec."Dimension Code" = GLSetup."Shortcut Dimension 7 Code":
                Item."ENC Shortcut Dimension 7 Code" := Rec."Dimension Value Code";
            Rec."Dimension Code" = GLSetup."Shortcut Dimension 8 Code":
                Item."ENC Shortcut Dimension 8 Code" := Rec."Dimension Value Code";
            Rec."Dimension Code" = GLSetup."ENC Product ID Dim. Code":
                Item."ENC Product ID Code" := Rec."Dimension Value Code";
            else
                exit;
        end;
        Rec.Modify(true);
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnAfterFormatAddress', '', false, false)]
    local procedure FormatAddressOnAfterFormatAddress(var CountryCode: Code[10]; var County: Text[50]; var AddrArray: array[8] of Text)
    var
        ProvinceState: Record "BA Province/State";
        CompInfo: Record "Company Information";
        i: Integer;
    begin
        if CountryCode = '' then begin
            CompInfo.Get('');
            CompInfo.TestField("Country/Region Code");
            CountryCode := CompInfo."Country/Region Code";
        end;

        if not ProvinceState.Get(CountryCode, CopyStr(County, 1, MaxStrLen(ProvinceState.Symbol))) then begin
            ProvinceState.SetRange("Country/Region Code", CountryCode);
            ProvinceState.SetRange(Name, County);
            if not ProvinceState.FindFirst() then
                exit;
        end;
        if not ProvinceState."Print Full Name" then
            exit;

        for i := 1 to 8 do
            if AddrArray[i].Contains(County) then begin
                AddrArray[i] := AddrArray[i].Replace(County, ProvinceState.Name);
                exit;
            end;
    end;




    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Price Calc. Mgt.", 'OnAfterFindSalesPrice', '', false, false)]
    local procedure SalesLineOnAfterFindSalesPrice(var FromSalesPrice: Record "Sales Price"; var ToSalesPrice: Record "Sales Price"; ItemNo: Code[20])
    var
        NewestDate: Date;
    begin
        if (ItemNo = '') or not ToSalesPrice.FindSet() then
            exit;
        NewestDate := ToSalesPrice."Starting Date";
        repeat
            if ToSalesPrice."Starting Date" > NewestDate then
                NewestDate := ToSalesPrice."Starting Date";
        until ToSalesPrice.Next() = 0;
        ToSalesPrice.SetFilter("Starting Date", '<>%1', NewestDate);
        ToSalesPrice.DeleteAll(false);
        ToSalesPrice.SetRange("Starting Date");
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Price Calc. Mgt.", 'OnAfterFindSalesLineItemPrice', '', false, false)]
    local procedure SalesPriceMgtOnAfterFindSalesLineItemPrice(var SalesLine: Record "Sales Line"; var TempSalesPrice: Record "Sales Price"; var FoundSalesPrice: Boolean)
    var
        SalesHeader: Record "Sales Header";
        SalesPrice: Record "Sales Price";
        SalesRecSetup: Record "Sales & Receivables Setup";
        GLSetup: Record "General Ledger Setup";
        ExchangeRate: Record "Currency Exchange Rate";
        CurrencyCode: Code[10];
        RateValue: Decimal;
    begin
        if not SalesRecSetup.Get() or not SalesRecSetup."BA Use Single Currency Pricing" then
            exit;
        SalesRecSetup.TestField("BA Single Price Currency");
        if not FoundSalesPrice then begin
            TempSalesPrice."Unit Price" := SalesLine."Unit Price";
            exit;
        end;
        GLSetup.Get();
        GLSetup.TestField("LCY Code");
        if SalesRecSetup."BA Single Price Currency" <> GLSetup."LCY Code" then
            CurrencyCode := SalesRecSetup."BA Single Price Currency";
        SalesPrice.SetRange("Item No.", SalesLine."No.");
        SalesPrice.SetRange("Currency Code", CurrencyCode);
        SalesPrice.SetRange("Starting Date", 0D, WorkDate());
        SalesPrice.SetAscending("Starting Date", true);
        if not SalesPrice.FindLast() then begin
            FoundSalesPrice := false;
            exit;
        end;
        TempSalesPrice := SalesPrice;
        if not (SalesLine."Document Type" in [SalesLine."Document Type"::Quote, SalesLine."Document Type"::Order]) then
            exit;
        if (SalesLine."Currency Code" <> CurrencyCode) and GetExchangeRate(ExchangeRate, CurrencyCode) then begin
            GLSetup.TestField("Amount Rounding Precision");
            TempSalesPrice."Unit Price" := Round(TempSalesPrice."Unit Price" * ExchangeRate."Relational Exch. Rate Amount",
                GLSetup."Amount Rounding Precision");
            RateValue := Round(ExchangeRate."Relational Exch. Rate Amount", GLSetup."Amount Rounding Precision");
        end else
            RateValue := 1;
        SalesHeader.Get(SalesLine."Document Type", SalesLine."Document No.");
        SalesHeader."BA Quote Exch. Rate" := RateValue;
        SalesHeader.Modify(true);
    end;




    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Price Calc. Mgt.", 'OnAfterFindServLiveItemPrice', '', false, false)]
    local procedure SalesPriceMgtOnAfterFindServLiveItemPrice(var ServiceLine: Record "Service Line"; var TempSalesPrice: Record "Sales Price"; var FoundSalesPrice: Boolean)
    var
        ServiceHeader: Record "Service Header";
        SalesPrice: Record "Sales Price";
        ServiceSetup: Record "Service Mgt. Setup";
        GLSetup: Record "General Ledger Setup";
        ExchangeRate: Record "Currency Exchange Rate";
        CurrencyCode: Code[10];
        RateValue: Decimal;
    begin
        if not ServiceSetup.Get() or not ServiceSetup."BA Use Single Currency Pricing" then
            exit;
        ServiceSetup.TestField("BA Single Price Currency");
        if not FoundSalesPrice then
            exit;
        GLSetup.Get();
        GLSetup.TestField("LCY Code");
        if ServiceSetup."BA Single Price Currency" <> GLSetup."LCY Code" then
            CurrencyCode := ServiceSetup."BA Single Price Currency";
        SalesPrice.SetRange("Item No.", ServiceLine."No.");
        SalesPrice.SetRange("Currency Code", CurrencyCode);
        SalesPrice.SetRange("Starting Date", 0D, WorkDate());
        SalesPrice.SetAscending("Starting Date", true);
        if not SalesPrice.FindLast() then begin
            FoundSalesPrice := false;
            exit;
        end;
        TempSalesPrice := SalesPrice;
        if not (ServiceLine."Document Type" in [ServiceLine."Document Type"::Quote, ServiceLine."Document Type"::Order]) then
            exit;
        if (ServiceLine."Currency Code" <> CurrencyCode) and GetExchangeRate(ExchangeRate, CurrencyCode) then begin
            GLSetup.TestField("Amount Rounding Precision");
            TempSalesPrice."Unit Price" := Round(TempSalesPrice."Unit Price" * ExchangeRate."Relational Exch. Rate Amount",
                GLSetup."Amount Rounding Precision");
            RateValue := Round(ExchangeRate."Relational Exch. Rate Amount", GLSetup."Amount Rounding Precision");
        end else
            RateValue := 1;
        ServiceHeader.Get(ServiceLine."Document Type", ServiceLine."Document No.");
        ServiceHeader."BA Quote Exch. Rate" := RateValue;
        ServiceHeader.Modify(true);
    end;


    procedure GetExchangeRate(var ExchangeRate: Record "Currency Exchange Rate"; CurrencyCode: Code[10]): Boolean
    begin
        ExchangeRate.SetRange("Currency Code", CurrencyCode);
        ExchangeRate.SetRange("Starting Date", 0D, WorkDate());
        exit(ExchangeRate.FindLast());
    end;

    procedure UpdateSalesPrice(var SalesHeader: Record "Sales Header")
    var
        SalesRecSetup: Record "Sales & Receivables Setup";
        SalesLine: Record "Sales Line";
        ExchangeRate: Record "Currency Exchange Rate";
        SalesPriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
    begin
        SalesRecSetup.Get();
        SalesRecSetup.TestField("BA Use Single Currency Pricing", true);
        SalesRecSetup.TestField("BA Single Price Currency");
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetRange(Type, SalesLine.Type::Item);
        if not SalesLine.FindSet(true) then
            exit;
        repeat
            SalesPriceCalcMgt.FindSalesLinePrice(SalesHeader, SalesLine, 0);
            SalesLine.UpdateUnitPrice(0);
            SalesLine.Modify(true);
        until SalesLine.Next() = 0;
        SalesHeader.Get(SalesHeader.RecordId());
        Message(ExchageRateUpdateMsg, SalesHeader."BA Quote Exch. Rate");
    end;


    procedure UpdateServicePrice(var ServiceHeader: Record "Service Header")
    var
        ServiceMgtSetup: Record "Service Mgt. Setup";
        ServiceLine: Record "Service Line";
        ExchangeRate: Record "Currency Exchange Rate";
        SalesPriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
    begin
        ServiceMgtSetup.Get();
        ServiceMgtSetup.TestField("BA Use Single Currency Pricing", true);
        ServiceMgtSetup.TestField("BA Single Price Currency");
        ServiceLine.SetRange("Document Type", ServiceHeader."Document Type");
        ServiceLine.SetRange("Document No.", ServiceHeader."No.");
        ServiceLine.SetRange(Type, ServiceLine.Type::Item);
        if not ServiceLine.FindSet(true) then
            exit;
        repeat
            SalesPriceCalcMgt.FindServLinePrice(ServiceHeader, ServiceLine, 0);
            ServiceLine.UpdateUnitPrice(0);
            ServiceLine.Modify(true);
        until ServiceLine.Next() = 0;
        ServiceHeader.Get(ServiceHeader.RecordId());
        Message(ExchageRateUpdateMsg, ServiceHeader."BA Quote Exch. Rate");
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesShptHeaderInsert', '', false, false)]
    local procedure SalesPostOnBeforeSalesShptHeaderInsert(var SalesShptHeader: Record "Sales Shipment Header"; SalesHeader: Record "Sales Header")
    begin
        SalesHeader.CalcFields("BA Ship-to County Fullname", "BA Bill-to County Fullname", "BA Sell-to County Fullname");
        SalesShptHeader."BA Bill-to County Fullname" := SalesHeader."BA Bill-to County Fullname";
        SalesShptHeader."BA Ship-to County Fullname" := SalesHeader."BA Ship-to County Fullname";
        SalesShptHeader."BA Sell-to County Fullname" := SalesHeader."BA Sell-to County Fullname";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesInvHeaderInsert', '', false, false)]
    local procedure SalesPostOnBeforeSalesInveaderInsert(var SalesInvHeader: Record "Sales Invoice Header"; SalesHeader: Record "Sales Header")
    begin
        SalesHeader.CalcFields("BA Ship-to County Fullname", "BA Bill-to County Fullname", "BA Sell-to County Fullname");
        SalesInvHeader."BA Bill-to County Fullname" := SalesHeader."BA Bill-to County Fullname";
        SalesInvHeader."BA Ship-to County Fullname" := SalesHeader."BA Ship-to County Fullname";
        SalesInvHeader."BA Sell-to County Fullname" := SalesHeader."BA Sell-to County Fullname";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesCrMemoHeaderInsert', '', false, false)]
    local procedure SalesPostOnBeforeSalesCrMemoHeaderInsert(var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; SalesHeader: Record "Sales Header")
    begin
        SalesHeader.CalcFields("BA Ship-to County Fullname", "BA Bill-to County Fullname", "BA Sell-to County Fullname");
        SalesCrMemoHeader."BA Bill-to County Fullname" := SalesHeader."BA Bill-to County Fullname";
        SalesCrMemoHeader."BA Ship-to County Fullname" := SalesHeader."BA Ship-to County Fullname";
        SalesCrMemoHeader."BA Sell-to County Fullname" := SalesHeader."BA Sell-to County Fullname";
    end;




    procedure AddMissingLineToShpt(ShptNo: Code[20])
    var
        SalesShptHeader: Record "Sales Shipment Header";
        SalesShptLine: Record "Sales Shipment Line";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
    begin
        SalesShptHeader.Get(ShptNo);
        SalesHeader.Get(SalesHeader."Document Type"::Order, SalesShptHeader."Order No.");

        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetRange(Type, SalesLine.Type::"G/L Account");
        SalesLine.FindFirst();

        SalesShptLine.SetRange("Document No.", SalesShptHeader."No.");
        SalesShptLine.SetRange(Type, SalesShptLine.Type::"G/L Account");
        if not SalesShptLine.IsEmpty() then
            Error('Already added');

        SalesShptLine.Init();
        SalesShptLine.TransferFields(SalesLine);
        SalesShptLine."Posting Date" := SalesShptHeader."Posting Date";
        SalesShptLine."Document No." := SalesShptHeader."No.";
        SalesShptLine."Order No." := SalesLine."Document No.";
        SalesShptLine."Order Line No." := SalesLine."Line No.";
        SalesShptLine."Quantity Invoiced" := 0;
        SalesShptLine."Qty. Invoiced (Base)" := 0;
        SalesShptLine."Qty. Shipped Not Invoiced" := SalesLine.Quantity;
        SalesShptLine.Insert(true);
    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterValidateEvent', 'BA Credit Limit', false, false)]
    local procedure CustomerOnAfterValidateCreditLimitNonLCY(var Rec: Record Customer)
    var
        Currency: Record Currency;
        ExchRate: Record "Currency Exchange Rate";
    begin
        if not Currency.Get(Rec."Customer Posting Group") then
            exit;
        ExchRate.SetRange("Currency Code", Currency.Code);
        ExchRate.SetRange("Starting Date", 0D, WorkDate());
        if ExchRate.FindLast() and (ExchRate."Relational Exch. Rate Amount" <> 0) then
            Rec.Validate("Credit Limit (LCY)", Rec."BA Credit Limit" * ExchRate."Relational Exch. Rate Amount");
    end;


    [EventSubscriber(ObjectType::Table, Database::"Currency Exchange Rate", 'OnAfterValidateEvent', 'Relational Exch. Rate Amount', false, false)]
    local procedure CurrencyExchangeRateOnAfterValidateRelationExchRateAmount(var Rec: Record "Currency Exchange Rate"; var xRec: Record "Currency Exchange Rate")
    var
        Customer: Record Customer;
        Window: Dialog;
        RecCount: Integer;
        i: Integer;
    begin
        if (Rec."Currency Code" <> 'USD') or (Rec."Relational Exch. Rate Amount" = xRec."Relational Exch. Rate Amount") then
            exit;
        UpdateSystemIndicator(Rec);
        Customer.SetFilter("BA Credit Limit", '<>%1', 0);
        if not Customer.FindSet(true) then
            exit;
        RecCount := Customer.Count;
        if not Confirm(UpdateCreditLimitMsg) then
            exit;
        Window.Open(UpdateCreditLimitDialog);
        repeat
            i += 1;
            Window.Update(1, StrSubstNo('%1 of %2', i, RecCount));
            Customer.Validate("Credit Limit (LCY)", Customer."BA Credit Limit" * Rec."Relational Exch. Rate Amount");
            Customer.Modify(true);
        until Customer.Next() = 0;
        Window.Close();
    end;


    local procedure UpdateSystemIndicator(var CurrExchRate: Record "Currency Exchange Rate")
    var
        CompInfo: Record "Company Information";
        DateRec: Record Date;
    begin
        CompInfo.Get('');
        DateRec.SetRange("Period Type", DateRec."Period Type"::Month);
        DateRec.SetRange("Period Start", DMY2Date(1, Date2DMY(CurrExchRate."Starting Date", 2), 2000));
        DateRec.FindFirst();
        CompInfo."Custom System Indicator Text" := CopyStr(StrSubstNo('%1 - USD Exch. Rate %2 (%3)', CompanyName(), CurrExchRate."Relational Exch. Rate Amount", DateRec."Period Name"), 1, MaxStrLen(CompInfo."Custom System Indicator Text"));
        CompInfo.Modify(false);
    end;


    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterValidateEvent', 'Credit Limit (LCY)', false, false)]
    local procedure CustomerNoAfterValidateCreditLimit(var Rec: Record Customer; var xRec: Record Customer)
    begin
        if Rec."Credit Limit (LCY)" = xRec."Credit Limit (LCY)" then
            exit;
        Rec."BA Credit Limit Last Updated" := CurrentDateTime();
        Rec."BA Credit Limit Updated By" := UserId();
        Rec.Modify(true);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterPostItemJnlLine', '', false, false)]
    local procedure ItemJnlLinePostOnAfterPostItemJnlLine(ItemLedgerEntry: Record "Item Ledger Entry"; var ItemJournalLine: Record "Item Journal Line"; var ValueEntryNo: Integer)
    begin
        if not ItemJournalLine."BA Updated" then
            exit;
        ItemLedgerEntry."BA Year-end Adjst." := true;
        ItemLedgerEntry.Modify(false);
    end;


    [EventSubscriber(ObjectType::Report, Report::"Calculate Inventory", 'OnBeforeInsertItemJnlLine', '', false, false)]
    local procedure CalcInventoryOnBeforeInsertItemJnlLine(var ItemJournalLine: Record "Item Journal Line"; YearEndInventoryAdjust: Boolean)
    begin
        if YearEndInventoryAdjust then
            ItemJournalLine."BA Updated" := true;
    end;

    [EventSubscriber(ObjectType::Report, Report::"Calculate Inventory", 'OnAfterPostItemDataItem', '', false, false)]
    local procedure CalcInventoryOnAfterPostItemDataItem(var ItemJnlLine: Record "Item Journal Line")
    var
        ItemJnlLine2: Record "Item Journal Line";
    begin
        ItemJnlLine2.CopyFilters(ItemJnlLine);
        ItemJnlLine.Reset();
        ItemJnlLine.SetRange("Journal Template Name", ItemJnlLine."Journal Template Name");
        ItemJnlLine.SetRange("Journal Batch Name", ItemJnlLine."Journal Batch Name");
        if DoesItemJnlHaveMultipleItemLines(ItemJnlLine) then
            Message(ImportWarningsMsg);
        ItemJnlLine.Reset();
        ItemJnlLine.CopyFilters(ItemJnlLine2);
    end;

    procedure DoesItemJnlHaveMultipleItemLines(var ItemJnlLine: Record "Item Journal Line"): Boolean
    var
        TempItemJnlLine: Record "Item Journal Line" temporary;
        ItemNos: List of [Code[20]];
        ItemNo: Code[20];
        HasWarnings: Boolean;
    begin
        if ItemJnlLine.IsEmpty() then
            exit(false);
        ItemJnlLine.SetFilter("BA Warning Message", '<>%1', '');
        ItemJnlLine.ModifyAll("BA Warning Message", '');
        ItemJnlLine.SetRange("BA Warning Message");
        if not ItemJnlLine.FindSet() then
            exit(false);
        repeat
            if ItemNos.Contains(ItemJnlLine."Item No.") then begin
                TempItemJnlLine := ItemJnlLine;
                TempItemJnlLine.Insert(false);
            end else
                ItemNos.Add(ItemJnlLine."Item No.");
        until ItemJnlLine.Next() = 0;
        if not TempItemJnlLine.FindSet() then
            exit(false);
        repeat
            ItemJnlLine.SetRange("Item No.", TempItemJnlLine."Item No.");
            if ItemJnlLine.Count() > 1 then begin
                HasWarnings := true;
                ItemJnlLine.ModifyAll("BA Warning Message", StrSubstNo(MultiItemMsg, TempItemJnlLine."Item No."));
            end;
        until TempItemJnlLine.Next() = 0;
        exit(HasWarnings);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Phys. Inventory Journal", 'OnAfterActionEvent', 'CalculateInventory', false, false)]
    local procedure PhysInvJournalOnAfterCalculateInventory(var Rec: Record "Item Journal Line")
    var
        ItemJnlLine: Record "Item Journal Line";
    begin
        ItemJnlLine.CopyFilters(Rec);
        Rec.SetRange("Journal Template Name", Rec."Journal Template Name");
        Rec.SetRange("Journal Batch Name", Rec."Journal Batch Name");
        Rec.SetRange("BA Created At", 0DT);
        Rec.ModifyAll("BA Created At", CurrentDateTime());
        Rec.CopyFilters(ItemJnlLine);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnAfterInsertEvent', '', false, false)]
    local procedure ItemJounalLineOnAfterInsert(var Rec: Record "Item Journal Line")
    begin
        Rec."BA Created At" := CurrentDateTime();
    end;


    procedure ReuseItemNo(ItemNo: Code[20])
    var
        InventorySetup: Record "Inventory Setup";
        NoSeriesLine: Record "No. Series Line";
        NoSeriesLine2: Record "No. Series Line";
        LineNo: Integer;
    begin
        InventorySetup.Get();
        InventorySetup.TestField("Item Nos.");
        NoSeriesLine2.SetRange("Series Code", InventorySetup."Item Nos.");
        if NoSeriesLine2.FindLast() then
            LineNo := NoSeriesLine2."Line No.";
        NoSeriesLine.Init();
        NoSeriesLine.Validate("Series Code", InventorySetup."Item Nos.");
        NoSeriesLine."Line No." := LineNo + 10000;
        NoSeriesLine."Last No. Used" := ItemNo;
        NoSeriesLine."BA Replacement" := true;
        NoSeriesLine."BA Replacement DateTime" := CurrentDateTime;
        NoSeriesLine.Open := false;
        NoSeriesLine.Insert(false);
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::NoSeriesManagement, 'OnBeforeDoGetNextNo', '', false, false)]
    local procedure NoSeriesMgtOnBeforeDoGetNextNo(var ModifySeries: Boolean; var NoSeriesCode: Code[20])
    var
        InventorySetup: Record "Inventory Setup";
    begin
        InventorySetup.Get();
        if (InventorySetup."Item Nos." = '') or (InventorySetup."Item Nos." <> NoSeriesCode) then
            exit;
        ModifySeries := false;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::NoSeriesManagement, 'OnAfterGetNextNo3', '', false, false)]
    local procedure NoSeriesMgtOnAfterGetNextNo3(var NoSeriesLine: Record "No. Series Line")
    var
        Item: Record Item;
        InventorySetup: Record "Inventory Setup";
        NoSeriesLine2: Record "No. Series Line";
        TempNoSeriesLine: Record "No. Series Line" temporary;
        Reuse: Boolean;
    begin
        InventorySetup.Get();
        if (InventorySetup."Item Nos." = '') or (InventorySetup."Item Nos." <> NoSeriesLine."Series Code") then
            exit;
        SetSeriesLineFilters(NoSeriesLine2, InventorySetup."Item Nos.");
        if not NoSeriesLine2.FindSet() then
            exit;
        repeat
            if Item.Get(NoSeriesLine2."Last No. Used") then begin
                TempNoSeriesLine := NoSeriesLine2;
                TempNoSeriesLine.Insert(false);
            end else
                Reuse := true;
        until Reuse or (NoSeriesLine2.Next() = 0);
        if TempNoSeriesLine.FindSet() then
            repeat
                NoSeriesLine2.Get(TempNoSeriesLine.RecordId());
                NoSeriesLine2.Delete(true);
            until TempNoSeriesLine.Next() = 0;
        if Reuse then
            NoSeriesLine."Last No. Used" := NoSeriesLine2."Last No. Used";
    end;

    local procedure SetSeriesLineFilters(var NoSeriesLine2: Record "No. Series Line"; SeriesCode: Code[20])
    begin
        NoSeriesLine2.SetRange("Series Code", SeriesCode);
        NoSeriesLine2.SetRange("BA Replacement", true);
        NoSeriesLine2.SetCurrentKey("Series Code", "Line No.", "Last No. Used");
        NoSeriesLine2.SetAscending(NoSeriesLine2."Last No. Used", true);
    end;

    [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterInsertEvent', '', false, false)]
    local procedure ItemOnAfterInsert(var Rec: Record Item)
    var
        InventorySetup: Record "Inventory Setup";
        NoSeriesLine: Record "No. Series Line";
    begin
        InventorySetup.Get();
        if (InventorySetup."Item Nos." = '') then
            exit;
        NoSeriesLine.SetRange("Series Code", InventorySetup."Item Nos.");
        NoSeriesLine.SetRange("Last No. Used", Rec."No.");
        NoSeriesLine.SetRange("BA Replacement", true);
        if NoSeriesLine.FindFirst() then
            NoSeriesLine.Delete(true);
    end;


    [EventSubscriber(ObjectType::Report, Report::"Refresh Production Order", 'OnAfterRefreshProdOrder', '', false, false)]
    local procedure RefreshProdOrderOnAfterRefreshProdOrder(var ProductionOrder: Record "Production Order"; ErrorOccured: Boolean)
    var
        ProdBOMHeader: Record "Production BOM Header";
    begin
        if ErrorOccured or (ProductionOrder."Source Type" <> ProductionOrder."Source Type"::Item) or not ProdBOMHeader.Get(ProductionOrder."Source No.") then
            exit;
        ProductionOrder."BA Source Version" := ProdBOMHeader."ENC Active Version No.";
        ProductionOrder.Modify(true);
    end;


    var
        UpdateCreditLimitMsg: Label 'Do you want to update all USD customer''s credit limit?\This may take a while depending on the number of customers.';
        UpdateCreditLimitDialog: Label 'Updating Customer Credit Limits\#1###';
        ExtDocNoFormatError: Label '%1 field is improperly formatted for International Orders:\%2';
        InvalidPrefixError: Label 'Missing "SO" prefix.';
        MissingNumeralError: Label 'Missing numeral suffix.';
        NonNumeralError: Label 'Non-numeric character: %1.';
        TooLongSuffixError: Label 'Numeral suffix length is greater than 7.';
        TooShortSuffixError: Label 'Numeral suffix length is less than 7.';
        ExchageRateUpdateMsg: Label 'Updated exchange rate to %1.';
        MultiItemMsg: Label 'Item %1 occurs on multiple lines.';
        ImportWarningsMsg: Label 'Inventory calculation completed with warnings.\Please review warning messages per line, where applicable.';
}