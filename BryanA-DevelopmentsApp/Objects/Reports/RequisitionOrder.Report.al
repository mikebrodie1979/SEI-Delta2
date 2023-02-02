report 50008 "BA Requisition Order"
{
    DefaultLayout = Word;
    Caption = 'Requisition Order';
    WordLayout = '.\Objects\ReportLayouts\RequisitionOrder.docx';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING ("Document Type", "No.");
            // WHERE ("Document Type" = CONST (Order));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Buy-from Vendor No.", "Pay-to Vendor No.", "No. Printed";
            column(No_PurchaseHeader; "No.") { }
            column(VendorFaxNo; VendorFaxNo) { }
            column(VendorPhoneNo; VendorPhoneNo) { }
            column(CurrencyCode; CurrencyCode) { }
            column(VNo; "Buy-from Vendor No.") { }
            column(VFax; VendorFaxNo) { }
            column(VPhone; VendorPhoneNo) { }
            column(Cur; CurrencyCode) { }
            column(CompanyInfoPicture; CompanyInformation.Picture) { }
            column(ReceiveDate; Format("ENC Received Date", 0, '<Month>/<Day,2>/<Year>')) { }
            column(PurchDept; "Your Reference") { }
            column(CompanyName; CompanyNameText) { }
            column(CName; CompanyNameText) { }
            column(ShipDesc; ShipmentMethod.Description) { }
            column(PayDesc; PaymentTerms.Description) { }
            column(TotalText; TotalText) { }
            column(Sym; Sym) { }
            column(TitleCaption; titlecaption) { }
            column(SubtypeCaption; SubtypeCaption) { }
            column(ReturnText; ReturnText) { }

            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING (Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING (Number)
                                        WHERE (Number = CONST (1));
                    column(CompanyAddress1; CompanyAddress[1])
                    {
                    }
                    column(CompanyAddress2; CompanyAddress[2])
                    {
                    }
                    column(CompanyAddress3; CompanyAddress[3])
                    {
                    }
                    column(CompanyAddress4; CompanyAddress[4])
                    {
                    }
                    column(CompanyAddress5; CompanyAddress[5])
                    {
                    }
                    column(CompanyAddress6; CompanyAddress[6])
                    {
                    }
                    column(CopyTxt; CopyTxt)
                    {
                    }
                    column(BuyFromAddress1; BuyFromAddress[1])
                    {
                    }
                    column(BuyFromAddress2; BuyFromAddress[2])
                    {
                    }
                    column(BuyFromAddress3; BuyFromAddress[3])
                    {
                    }
                    column(BuyFromAddress4; BuyFromAddress[4])
                    {
                    }
                    column(BuyFromAddress5; BuyFromAddress[5])
                    {
                    }
                    column(BuyFromAddress6; BuyFromAddress[6])
                    {
                    }
                    column(BuyFromAddress7; BuyFromAddress[7])
                    {
                    }
                    column(ExptRecptDt_PurchaseHeader; "Purchase Header"."Expected Receipt Date")
                    {
                    }
                    column(ShipToAddress1; ShipToAddress[1])
                    {
                    }
                    column(ShipToAddress2; ShipToAddress[2])
                    {
                    }
                    column(ShipToAddress3; ShipToAddress[3])
                    {
                    }
                    column(ShipToAddress4; ShipToAddress[4])
                    {
                    }
                    column(ShipToAddress5; ShipToAddress[5])
                    {
                    }
                    column(ShipToAddress6; ShipToAddress[6])
                    {
                    }
                    column(ShipToAddress7; ShipToAddress[7])
                    {
                    }
                    column(BuyfrVendNo_PurchaseHeader; "Purchase Header"."Buy-from Vendor No.")
                    {
                    }
                    column(YourRef_PurchaseHeader; "Purchase Header"."Your Reference")
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(No1_PurchaseHeader; "Purchase Header"."No.")
                    {
                    }
                    column(OrderDate_PurchaseHeader; Format("Purchase Header"."Order Date", 0, '<Month,2>/<Day,2>/20<Year,2>'))
                    {
                    }
                    column(CompanyAddress7; CompanyAddress[7])
                    {
                    }
                    column(CompanyAddress8; CompanyAddress[8])
                    {
                    }
                    column(BuyFromAddress8; BuyFromAddress[8])
                    {
                    }
                    column(ShipToAddress8; ShipToAddress[8])
                    {
                    }
                    column(ShipmentMethodDescription; ShipmentMethod.Description)
                    {
                    }
                    column(PaymentTermsDescription; PaymentTerms.Description)
                    {
                    }
                    column(CompanyInformationPhoneNo; CompanyInformation."Phone No.")
                    {
                    }
                    column(CopyNo; CopyNo)
                    {
                    }
                    column(VendTaxIdentificationType; FORMAT(Vend."Tax Identification Type"))
                    {
                    }
                    column(ToCaption; ToCaptionLbl)
                    {
                    }
                    column(ReceiveByCaption; ReceiveByCaptionLbl)
                    {
                    }
                    column(VendorIDCaption; VendorIDCaptionLbl)
                    {
                    }
                    column(ConfirmToCaption; ConfirmToCaptionLbl)
                    {
                    }
                    column(BuyerCaption; BuyerCaptionLbl)
                    {
                    }
                    column(ShipCaption; ShipCaptionLbl)
                    {
                    }
                    column(ToCaption1; ToCaption1Lbl)
                    {
                    }
                    column(PurchOrderCaption; PurchOrderCaptionLbl)
                    {
                    }
                    column(PurchOrderNumCaption; PurchOrderNumCaptionLbl)
                    {
                    }
                    column(PurchOrderDateCaption; PurchOrderDateCaptionLbl)
                    {
                    }
                    column(PageCaption; PageCaptionLbl)
                    {
                    }
                    column(ShipViaCaption; ShipViaCaptionLbl)
                    {
                    }
                    column(TermsCaption; TermsCaptionLbl)
                    {
                    }
                    column(PhoneNoCaption; PhoneNoCaptionLbl)
                    {
                    }
                    column(TaxIdentTypeCaption; TaxIdentTypeCaptionLbl)
                    {
                    }
                    column(VendorOrderNo_Lbl; VendorOrderNoLbl)
                    {
                    }
                    column(VendorInvoiceNo_Lbl; VendorInvoiceNoLbl)
                    {
                    }
                    column(VendorOrderNo; "Purchase Header"."Vendor Order No.")
                    {
                    }
                    column(VendorInvoiceNo; "Purchase Header"."Vendor Invoice No.")
                    {
                    }


                    dataitem("Purchase Line"; "Purchase Line")
                    {
                        DataItemLink = "Document No." = FIELD ("No.");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING ("Document Type", "Document No.", "Line No.");
                        // WHERE ("Document Type" = CONST (Order));
                        column(AmountExclInvDisc; AmountExclInvDisc)
                        {
                        }
                        column(ItemNumberToPrint; ItemNumberToPrint)
                        {
                        }
                        column(UnitofMeasure_PurchaseLine; "Unit of Measure")
                        {
                        }
                        column(Quantity_PurchaseLine; Quantity)
                        {
                        }
                        column(UnitPriceToPrint; UnitPriceToPrint)
                        {
                            DecimalPlaces = 2 : 5;
                        }
                        column(Description_PurchaseLine; DescriptionToPrint)
                        {
                        }
                        column(PrintFooter; PrintFooter)
                        {
                        }
                        column(InvDiscountAmt_PurchaseLine; "Inv. Discount Amount")
                        {
                        }
                        column(TaxAmount; TaxAmount)
                        {
                        }
                        column(LineAmtTaxAmtInvDiscountAmt; "Line Amount" + TaxAmount - "Inv. Discount Amount")
                        {
                        }
                        column(TotalTaxLabel; TotalTaxLabel)
                        {
                        }
                        column(BreakdownTitle; BreakdownTitle)
                        {
                        }
                        column(BreakdownLabel1; BreakdownLabel[1])
                        {
                        }
                        column(BreakdownAmt1; BreakdownAmt[1])
                        {
                        }
                        column(BreakdownLabel2; BreakdownLabel[2])
                        {
                        }
                        column(BreakdownAmt2; BreakdownAmt[2])
                        {
                        }
                        column(BreakdownLabel3; BreakdownLabel[3])
                        {
                        }
                        column(BreakdownAmt3; BreakdownAmt[3])
                        {
                        }
                        column(BreakdownAmt4; BreakdownAmt[4])
                        {
                        }
                        column(BreakdownLabel4; BreakdownLabel[4])
                        {
                        }
                        column(DocumentNo_PurchaseLine; "Document No.")
                        {
                        }
                        column(ItemNoCaption; ItemNoCaptionLbl)
                        {
                        }
                        column(UnitCaption; UnitCaptionLbl)
                        {
                        }
                        column(DescriptionCaption; DescriptionCaptionLbl)
                        {
                        }
                        column(QuantityCaption; QuantityCaptionLbl)
                        {
                        }
                        column(UnitPriceCaption; UnitPriceCaptionLbl)
                        {
                        }
                        column(TotalPriceCaption; TotalPriceCaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(InvDiscCaption; InvDiscCaptionLbl)
                        {
                        }
                        column(TotalCaption; TotalCaptionLbl)
                        {
                        }
                        column(Type; Type) { }
                        column(LineCount; OnLineNumber) { }
                        column(OnLineNumber; OnLineNumber) { }
                        column(LNo; OnLineNumber) { }
                        column(UoM; "Unit of Measure") { }
                        column(RequestedRcptDate; Format("Purchase Line"."Requested Receipt Date")) { }
                        column(CrossReferenceNo; "Purchase Line"."Vendor Item No.") { }
                        column(DrawingNo; "ENC Drawing No.") { }
                        column(DrawingRevNo; "ENC Drawing Rev. No.") { }
                        column(ManufacturingDept; "ENC Manufacturing Dept.") { }
                        column(DNo; "ENC Drawing No.") { }
                        column(RevNo; RevNo) { }
                        column(MangDept; "ENC Manufacturing Dept.") { }
                        column(RcptDate; Format("Purchase Line"."Requested Receipt Date")) { }
                        column(CRNo; "Purchase Line"."Vendor Item No.") { }
                        column(Amt; AmountExclInvDiscText) { }
                        column(Qty; QuantityText) { }
                        column(ItemNo; ItemNumberToPrint) { }
                        column(Price; UnitPriceToPrintText) { }

                        trigger OnPreDataItem()
                        begin
                            CLEAR(AmountExclInvDisc);
                            // SetFilter("Buy-from Vendor No.", '<>%1', '');
                            NumberOfLines := COUNT;
                            OnLineNumber := 0;
                            PrintFooter := FALSE;
                        end;

                        trigger OnAfterGetRecord()
                        var
                            Item: Record Item;
                        begin
                            OnLineNumber := OnLineNumber + 1;

                            IF ("Purchase Header"."Tax Area Code" <> '') AND NOT UseExternalTaxEngine THEN
                                SalesTaxCalc.AddPurchLine("Purchase Line");

                            if Type = Type::Item then
                                if Item.Get("No.") and (Item."No. 2" <> '') then
                                    ItemNumberToPrint := StrSubstNo(Text1000000002, "No.", Item."No. 2")
                                else
                                    ItemNumberToPrint := "No."
                            else
                                ItemNumberToPrint := "No.";

                            if "Description 2" <> '' then
                                DescriptionToPrint := Description + ' ' + "Description 2"
                            else
                                DescriptionToPrint := Description;

                            IF Type = 0 THEN BEGIN
                                ItemNumberToPrint := '';
                                "Unit of Measure" := '';
                                "Line Amount" := 0;
                                "Inv. Discount Amount" := 0;
                                Quantity := 0;
                            END;

                            AmountExclInvDisc := "Line Amount";
                            SumAmountExclInvDisc += AmountExclInvDisc;
                            SumInvDiscountAmt += "Inv. Discount Amount";
                            SumLineAmtTaxAmtInvDiscountAmt += ("Line Amount" + TaxAmount - "Inv. Discount Amount");

                            if "Purchase Line"."ENC Drawing Rev. No." <> '' then
                                RevNo := StrSubstNo('Rev. %1', "ENC Drawing Rev. No.")
                            else
                                RevNo := '';

                            IF Quantity = 0 THEN
                                UnitPriceToPrint := 0 // so it won't print
                            ELSE
                                UnitPriceToPrint := ROUND(AmountExclInvDisc / Quantity, 0.00001);
                            UnitPriceToPrintText := AddDecimalText(Format(UnitPriceToPrint));
                            AmountExclInvDiscText := AddDecimalText(Format(AmountExclInvDisc));
                            QuantityText := Format(Quantity);
                            if Type = Type::" " then begin
                                UnitPriceToPrintText := '';
                                AmountExclInvDiscText := '';
                                QuantityText := '';
                            end;


                            IF OnLineNumber = NumberOfLines THEN BEGIN
                                PrintFooter := TRUE;

                                IF "Purchase Header"."Tax Area Code" <> '' THEN BEGIN
                                    IF UseExternalTaxEngine THEN
                                        SalesTaxCalc.CallExternalTaxEngineForPurch("Purchase Header", TRUE)
                                    ELSE
                                        SalesTaxCalc.EndSalesTaxCalculation(UseDate);
                                    SalesTaxCalc.GetSummarizedSalesTaxTable(TempSalesTaxAmtLine);
                                    BrkIdx := 0;
                                    PrevPrintOrder := 0;
                                    PrevTaxPercent := 0;
                                    TaxAmount := 0;
                                    WITH TempSalesTaxAmtLine DO BEGIN
                                        RESET;
                                        SETCURRENTKEY("Print Order", "Tax Area Code for Key", "Tax Jurisdiction Code");
                                        IF FIND('-') THEN
                                            REPEAT
                                                IF ("Print Order" = 0) OR
                                                   ("Print Order" <> PrevPrintOrder) OR
                                                   ("Tax %" <> PrevTaxPercent)
                                                THEN BEGIN
                                                    BrkIdx := BrkIdx + 1;
                                                    IF BrkIdx > 1 THEN BEGIN
                                                        IF TaxArea."Country/Region" = TaxArea."Country/Region"::CA THEN
                                                            BreakdownTitle := Text006
                                                        ELSE
                                                            BreakdownTitle := Text003;
                                                    END;
                                                    IF BrkIdx > ARRAYLEN(BreakdownAmt) THEN BEGIN
                                                        BrkIdx := BrkIdx - 1;
                                                        BreakdownLabel[BrkIdx] := Text004;
                                                    END ELSE
                                                        BreakdownLabel[BrkIdx] := STRSUBSTNO("Print Description", "Tax %");
                                                END;
                                                BreakdownAmt[BrkIdx] := BreakdownAmt[BrkIdx] + "Tax Amount";
                                                TaxAmount := TaxAmount + "Tax Amount";
                                            UNTIL NEXT = 0;
                                    END;
                                END;
                            END;
                        end;


                    }
                }

                trigger OnAfterGetRecord()
                begin
                    // CurrReport.PAGENO := 1;
                    IF CopyNo = NoLoops THEN BEGIN
                        IF NOT CurrReport.PREVIEW THEN
                            PurchasePrinted.RUN("Purchase Header");
                        CurrReport.BREAK;
                    END;
                    CopyNo := CopyNo + 1;
                    IF CopyNo = 1 THEN // Original
                        CLEAR(CopyTxt)
                    ELSE
                        CopyTxt := Text000;
                    TaxAmount := 0;

                    CLEAR(BreakdownTitle);
                    CLEAR(BreakdownLabel);
                    CLEAR(BreakdownAmt);
                    TotalTaxLabel := Text008;
                    IF "Purchase Header"."Tax Area Code" <> '' THEN BEGIN
                        TaxArea.GET("Purchase Header"."Tax Area Code");
                        CASE TaxArea."Country/Region" OF
                            TaxArea."Country/Region"::US:
                                TotalTaxLabel := Text005;
                            TaxArea."Country/Region"::CA:
                                TotalTaxLabel := Text007;
                        END;
                        UseExternalTaxEngine := TaxArea."Use External Tax Engine";
                        SalesTaxCalc.StartSalesTaxCalculation;
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    NoLoops := 1 + ABS(NoCopies);
                    IF NoLoops <= 0 THEN
                        NoLoops := 1;
                    CopyNo := 0;
                end;
            }

            trigger OnAfterGetRecord()
            var
                Vendor: Record Vendor;
                GLSetup: Record "General Ledger Setup";
                Currency: Record Currency;
            begin
                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                    FormatAddress.RespCenter(CompanyAddress, RespCenter);
                    CompanyInformation."Phone No." := RespCenter."Phone No.";
                    CompanyInformation."Fax No." := RespCenter."Fax No.";
                END;
                CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");

                IF "Purchaser Code" = '' THEN
                    CLEAR(SalesPurchPerson)
                ELSE
                    SalesPurchPerson.GET("Purchaser Code");

                IF "Payment Terms Code" = '' THEN
                    CLEAR(PaymentTerms)
                ELSE
                    PaymentTerms.GET("Payment Terms Code");

                IF "Shipment Method Code" = '' THEN
                    CLEAR(ShipmentMethod)
                ELSE
                    ShipmentMethod.GET("Shipment Method Code");

                "Buy-from Contact" := ''; // Temp Blank the value but don't save to the record so it doesnt show in report
                FormatAddress.PurchHeaderBuyFrom(BuyFromAddress, "Purchase Header");
                FormatAddress.PurchHeaderShipTo(ShipToAddress, "Purchase Header");

                IF NOT CurrReport.PREVIEW THEN BEGIN
                    IF ArchiveDocument THEN
                        ArchiveManagement.StorePurchDocument("Purchase Header", LogInteraction);

                    IF LogInteraction THEN BEGIN
                        CALCFIELDS("No. of Archived Versions");
                        SegManagement.LogDocument(
                          13, "No.", "Doc. No. Occurrence", "No. of Archived Versions", DATABASE::Vendor, "Buy-from Vendor No.",
                          "Purchaser Code", '', "Posting Description", '');
                    END;
                END;

                IF "Posting Date" <> 0D THEN
                    UseDate := "Posting Date"
                ELSE
                    UseDate := WORKDATE;

                if Vendor.Get("Buy-from Vendor No.") then begin
                    VendorFaxNo := Vendor."Fax No.";
                    VendorPhoneNo := Vendor."Phone No.";
                end else begin
                    VendorFaxNo := '';
                    VendorPhoneNo := '';
                end;

                Sym := '';
                CurrencyCode := "Currency Code";
                if CurrencyCode = '' then begin
                    GLSetup.Get;
                    CurrencyCode := GLSetup."LCY Code";
                    Sym := GLSetup.GetCurrencySymbol();
                end;
                if CurrencyCode <> '' then
                    TotalText := StrSubstNo('Total (%1):', CurrencyCode)
                else
                    TotalText := 'Total:';
                if Currency.Get(CurrencyCode) then
                    Sym := Currency.Symbol;
                SumAmountExclInvDisc := 0;
                SumInvDiscountAmt := 0;
                SumLineAmtTaxAmtInvDiscountAmt := 0;

                if "Purchase Header"."BA Requisition Order" then begin
                    TitleCaption := 'REQUISITION';
                    SubtypeCaption := 'RO';
                end else begin
                    TitleCaption := 'PURCHASE';
                    SubtypeCaption := 'PO';
                end;

                if "Purchase Header"."Document Type" = "Purchase Header"."Document Type"::"Return Order" then
                    ReturnText := 'RETURN'
                else
                    ReturnText := '';
            end;
        }
        dataitem(Totals; Integer)
        {
            column(SubTotal; Round(SumAmountExclInvDisc, 0.01)) { }
            column(TotalDiscount; Round(SumInvDiscountAmt, 0.01)) { }
            column(Total; Round(SumLineAmtTaxAmtInvDiscountAmt + BreakdownAmt[1] + BreakdownAmt[2], 0.01)) { }
            column(Tax1; Tax1) { }
            column(Tax2; Tax2) { }
            column(TaxLabel1; BreakdownLabel[1]) { }
            column(TaxLabel2; BreakdownLabel[2]) { }

            trigger OnPreDataItem()
            begin
                SetRange(Number, 1);
            end;

            trigger OnAfterGetRecord()
            begin
                Tax1 := FormatTaxAmount(BreakdownAmt[1], BreakdownLabel[1]);
                Tax2 := FormatTaxAmount(BreakdownAmt[2], BreakdownLabel[2]);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NumberOfCopies; NoCopies)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Number of Copies';
                        ToolTip = 'Specifies the number of copies of each blanket purchase order, in addition to the original, that you want to print.';
                    }
                    field(ArchiveDocument; ArchiveDocument)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Archive Document';
                        Enabled = ArchiveDocumentEnable;
                        ToolTip = 'Specifies if the document is archived when you run the report.';

                        trigger OnValidate()
                        begin
                            IF NOT ArchiveDocument THEN
                                LogInteraction := FALSE;
                        end;
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ToolTip = 'Specifies if the interaction with the vendor is logged when ,you run the report.';

                        trigger OnValidate()
                        begin
                            IF LogInteraction THEN
                                ArchiveDocument := ArchiveDocumentEnable;
                        end;
                    }
                }
            }
        }

        trigger OnInit()
        begin
            LogInteractionEnable := TRUE;
            ArchiveDocumentEnable := TRUE;
        end;

        trigger OnOpenPage()
        begin
            ArchiveDocument := ArchiveManagement.PurchaseDocArchiveGranule;
            LogInteraction := SegManagement.FindInteractTmplCode(13) <> '';

            ArchiveDocumentEnable := ArchiveDocument;
            LogInteractionEnable := LogInteraction;
        end;
    }

    trigger OnPreReport()
    var
        i: Integer;
        NewLine: Text[1];
    begin
        NewLine[1] := 10;
        CompanyInformation.GET;
        CompanyInformation.CalcFields(Picture);
        FormatAddress.Company(CompanyAddress, CompanyInformation);
        SEIFunctions.FormatCompanyAddress(CompanyAddress, CompanyInformation);
        CompanyAddress[1] := '';
        for i := ArrayLen(CompanyAddress) downto 1 do
            if (CompanyAddress[i] <> '') and CompanyAddress[i].Contains('Website') and CompanyAddress[i].Contains('eMail') then begin
                CompanyAddress[i] := CompanyAddress[i].Replace(' e', NewLine + 'e');
                break;
            end;
    end;

    local procedure FormatTaxAmount(TaxAmount: Decimal; var TaxLabel: Text): Text
    var
        NumParts: List of [Text];
        s: Text;
        TaxText: Text;
    begin
        if TaxAmount = 0 then
            TaxLabel := ''
        else begin
            TaxText := Format(Round(TaxAmount, 0.01));
            if not TaxText.Contains('.') then
                TaxText += '.00'
            else begin
                NumParts := TaxText.Split('.');
                NumParts.Get(1, TaxText);
                NumParts.Get(2, s);
                if StrLen(s) < 2 then
                    s += '0';
                TaxText += '.' + s;
            end;
        end;
        exit(TaxText);
    end;

    var
        QuantityText: Text;
        UnitPriceToPrint: Decimal;
        UnitPriceToPrintText: Text;
        AmountExclInvDisc: Decimal;
        AmountExclInvDiscText: Text;
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInformation: Record "Company Information";
        RespCenter: Record "Responsibility Center";
        Language: Record Language;
        TempSalesTaxAmtLine: Record "Sales Tax Amount Line" temporary;
        TaxArea: Record "Tax Area";
        Vend: Record Vendor;
        CompanyAddress: array[8] of Text[100];
        BuyFromAddress: array[8] of Text[100];
        ShipToAddress: array[8] of Text[100];
        CopyTxt: Text[10];
        ItemNumberToPrint: Text;
        PrintFooter: Boolean;
        NoCopies: Integer;
        NoLoops: Integer;
        CopyNo: Integer;
        NumberOfLines: Integer;
        OnLineNumber: Integer;
        PurchasePrinted: Codeunit "Purch.Header-Printed";
        FormatAddress: Codeunit "Format Address";
        SalesTaxCalc: Codeunit "Sales Tax Calculate";
        ArchiveManagement: Codeunit ArchiveManagement;
        SegManagement: Codeunit SegManagement;
        ArchiveDocument: Boolean;
        LogInteraction: Boolean;
        TaxAmount: Decimal;
        TotalTaxLabel: Text[30];
        BreakdownTitle: Text[30];
        BreakdownLabel: array[4] of Text[30];
        BreakdownAmt: array[4] of Decimal;
        BrkIdx: Integer;
        PrevPrintOrder: Integer;
        PrevTaxPercent: Decimal;
        UseDate: Date;
        Text000: Label 'COPY';
        Text003: Label 'Sales Tax Breakdown:';
        Text004: Label 'Other Taxes';
        Text005: Label 'Total Sales Tax:';
        Text006: Label 'Tax Breakdown:';
        Text007: Label 'Total Tax:';
        Text008: Label 'Tax:';
        UseExternalTaxEngine: Boolean;
        [InDataSet]
        ArchiveDocumentEnable: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        ToCaptionLbl: Label 'To:';
        ReceiveByCaptionLbl: Label 'Receive By';
        VendorIDCaptionLbl: Label 'Vendor ID';
        ConfirmToCaptionLbl: Label 'Confirm To';
        BuyerCaptionLbl: Label 'Buyer';
        ShipCaptionLbl: Label 'Ship';
        ToCaption1Lbl: Label 'To:';
        PurchOrderCaptionLbl: Label 'PURCHASE ORDER';
        PurchOrderNumCaptionLbl: Label 'Purchase Order Number:';
        PurchOrderDateCaptionLbl: Label 'Purchase Order Date:';
        PageCaptionLbl: Label 'Page:';
        ShipViaCaptionLbl: Label 'Ship Via';
        TermsCaptionLbl: Label 'Terms';
        PhoneNoCaptionLbl: Label 'Phone No.';
        TaxIdentTypeCaptionLbl: Label 'Tax Ident. Type';
        ItemNoCaptionLbl: Label 'Item No.';
        UnitCaptionLbl: Label 'Unit';
        DescriptionCaptionLbl: Label 'Description';
        QuantityCaptionLbl: Label 'Quantity';
        UnitPriceCaptionLbl: Label 'Unit Price';
        TotalPriceCaptionLbl: Label 'Total Price';
        SubtotalCaptionLbl: Label 'Subtotal:';
        InvDiscCaptionLbl: Label 'Invoice Discount:';
        TotalCaptionLbl: Label 'Total:';
        VendorOrderNoLbl: Label 'Vendor Order No.';
        VendorInvoiceNoLbl: Label 'Vendor Invoice No.';
        Text1000000002: Label '%1, %2';
        SEIFunctions: Codeunit "ENC SEI Functions";
        VendorFaxNo: Text;
        VendorPhoneNo: Text;
        CurrencyCode: Text;
        DescriptionToPrint: Text;
        SumAmountExclInvDisc: Decimal;
        SumInvDiscountAmt: Decimal;
        SumLineAmtTaxAmtInvDiscountAmt: Decimal;
        Tax1: Text;
        Tax2: Text;
        RevNo: Text;
        TotalText: Text;
        Sym: Text;
        TitleCaption: Text;
        SubtypeCaption: Text;
        ReturnText: Text;

    procedure CompanyNameText(): Text
    var
        s: Text;
    begin
        s := CompanyName;
        if StrPos(s, ' ') = 0 then
            exit(s);
        exit(SelectStr(1, ConvertStr(s, ' ', ',')));
    end;


    local procedure AddDecimalText(Input: Text): Text
    var
        NumParts: List of [Text];
        s: Text;
        s2: Text;
    begin
        if not Input.Contains('.') then
            exit(Input + '.00');
        NumParts := Input.Split('.');
        if not NumParts.Get(2, s) then
            exit(Input + '.00');
        if StrLen(s) = 1 then
            s += '0';
        NumParts.Get(1, s2);
        exit(s2 + '.' + s);
    end;
}

