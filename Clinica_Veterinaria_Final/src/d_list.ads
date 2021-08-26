generic
    type item is private;
    with function Image(i: in item) return String;
package d_list is

    type list is private;

    procedure new_list(p: out list);
    procedure push(p: in out list; x: in item);
    procedure show_list(p: in list);

private

    type Node;
    type PNode is access Node;
    type Node is record
        content: item;
        prev: PNode;
    end record;
    -- Nomes ens fa falta la operacio de insercio i es comportarà com una pila.
    type list is record
        TOS: PNode;
    end record;

end d_list;
