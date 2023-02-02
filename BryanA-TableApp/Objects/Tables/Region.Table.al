table 75011 "BA Region"
{
    DataClassification = CustomerContent;
    Caption = 'Region';

    fields
    {
        field(1; Name; Text[30])
        {
            NotBlank = true;
        }
    }

    keys
    {
        key(K1; Name)
        {
            Clustered = true;
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
        if not UserSetup.Get(UserId()) or not UserSetup."BA Allow Changing Regions" then
            Error(InvalidPermissionError);
    end;

    var
        InvalidPermissionError: Label 'You do not have permission to make this change.';
}