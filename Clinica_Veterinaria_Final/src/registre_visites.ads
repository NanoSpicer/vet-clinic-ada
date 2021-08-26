with Ada.Text_IO; use Ada.Text_IO;
generic
    MAX_LENGTH: Integer := 100;
package registre_visites is

    already_exists:exception;
    type bst is private;

    function new_registre return bst;
    -- Per emmagatzemar només les String
    procedure put(reg: in out bst; elem: in String);
    procedure print_bst(reg: in bst);

private

    type Node;
    type PNode is access Node;

    type Node is record
        key: String(1..MAX_LENGTH);
        left, right: PNode;
    end record;
    type bst is record
        root: PNode;
    end record;

end registre_visites;
