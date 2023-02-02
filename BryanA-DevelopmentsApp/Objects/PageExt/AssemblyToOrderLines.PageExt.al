pageextension 80004 "BA AssemblyToOrder Lines" extends "Assemble-to-Order Lines"
{
    layout
    {
        addafter(Description)
        {
            field("BA Optional"; "BA Optional")
            {
                ApplicationArea = all;
            }
        }
    }
}