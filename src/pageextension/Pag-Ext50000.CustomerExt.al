pageextension 50000 CustomerExt extends "Customer List"
{
    layout
    {

    }


    actions
    {
        addfirst(Category_Category12)
        {
            group("Ref-Actions")
            {
                // actionref("test actions"; "test action")
                // {

                // }
            }


            // action("test action")
            // {
            //     // PromotedIsBig = true;
            //     // Promoted = true; // app.json won't allow you write promoted = true. you've to use action-ref-only
            //     // PromotedCategory = Category10;

            //     trigger OnAction()

            //     begin
            //         Message('test action');
            //     end;
            // }
        }

    }



    views
    {
        addfirst
        {
            view("First filter")
            {
                Caption = 'Naqvi filter';
                Filters = where("No." = filter('10000'));
                SharedLayout = true;
            }
        }
    }



    trigger OnOpenPage()
    begin
        Message('hop in');
    end;


    var
        Test1Var: Code[20];
        Testvar2: Code[20];
}
