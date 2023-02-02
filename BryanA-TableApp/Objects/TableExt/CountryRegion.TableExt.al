tableextension 80035 "BA Country/Region" extends "Country/Region"
{
    fields
    {
        field(80000; "BA Region"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Region';
            TableRelation = "BA Region".Name;
        }
    }

    trigger OnDelete()
    begin
        CheckIfCanMakeChanges();
    end;

    trigger OnInsert()
    begin
        CheckIfCanMakeChanges();
    end;

    trigger OnRename()
    begin
        CheckIfCanMakeChanges();
    end;

    trigger OnModify()
    begin
        CheckIfCanMakeChanges();
    end;

    procedure CheckIfCanMakeChanges()
    var
        UserSetup: Record "User Setup";
    begin
        if not UserSetup.Get(UserId()) or not UserSetup."BA Allow Changing Countries" then
            Error(InvalidPermissionError);
    end;

    var
        InvalidPermissionError: Label 'You do not have permission to make this change.';
}