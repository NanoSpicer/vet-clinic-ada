with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
generic
    type item is private;
    max: Positive := 1000;
package hash_map is

    out_of_space: exception;
    already_exists: exception;
    no_such_item: exception;
    type map is private;

    procedure new_hash(h: out map);
    procedure insert(h: in out map; key: in String; x: in item);

    function read(h: in map; key: in String) return item;

private

    optimal_range:Float := Float(max)*0.8;
    real_max: Positive := Integer(Float'Truncation(optimal_range));

    type index is new Integer range 0..real_max;
    type Node is record
        key: unbounded_string;
        content: item;
        free: boolean;
    end record;

    type taula_dispersio is array(index) of Node;

    type map is record
        hash: taula_dispersio;
    end record;

end hash_map;
