with Ada.Text_IO; use Ada.Text_IO;
generic
    type item is private;
    with function "<"(a,b: in item) return boolean;
    with function ">"(a,b: in item) return boolean;
    with function "="(a,b: in item) return boolean;
    with function Image(a: in item) return String;
    max: Natural := 1000;
package priority_queue is

    type p_coa is private;
    bad_use: exception;
    space_overflow: exception;

    -- Retorna una nova coa de prioritats buida
    function new_p_coa return p_coa;

    procedure insert(q: in out p_coa; element: in item);
    function rem_first(q: in out p_coa) return item;

    function size(q: in p_coa) return Natural;
    pragma inline(size);
    function empty(q: in p_coa) return boolean;
    pragma inline(empty);

    procedure print_p_coa(q: in p_coa);
private
    subtype index is Integer range 1..max;
    type memoria is array(index) of item;

    type p_coa is record
        contingut: memoria;
        elements: Natural;
    end record;

end priority_queue;
