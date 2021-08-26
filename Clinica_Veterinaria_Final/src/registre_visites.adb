package body registre_visites is

    marca_final: constant character:='.';

    function valor(x: in String) return Integer is
        sum: Integer :=0;
        i: Integer := x'first;
    begin
        while x(i)/=marca_final loop
            sum := sum + Character'Pos(x(i));
            i:=i+1;
        end loop;
        return sum;
    end valor;

    function filtrar_string(x: in String) return String is
        new_Str: String(1..MAX_LENGTH);
        i: Integer := x'first;
    begin
        if x'last > MAX_LENGTH then
            put_line("error.registre_visites: nom massa llarg");
            raise constraint_error;
        end if;

        while i<=x'last loop
            new_str(i):=x(i);
            i:=i+1;
        end loop;
        -- marcam el final
        new_str(i):=marca_final;
        return new_str;
    end filtrar_string;

    procedure mostra(str_filt: In String) is
        i: integer := str_filt'first;
    begin
        put("[");
        while i<str_filt'last and then str_filt(i)/=marca_final loop
	    put(str_filt(i));
	    i:=i+1;
        end loop;
        put("] ");
    end mostra;




    function new_registre return bst is
        reg: bst;
    begin
        reg.root:=null;
        return reg;
    end new_registre;

    -- Per emmagatzemar només les String
    procedure put(reg: in out bst; elem: in String) is
	procedure recursive_put(actual: in out PNode; elem: in String) is
	    valor_aux: Integer;
	    valor_key: Integer := valor(elem);
	begin
	    if actual = null then
		actual := new Node'(elem, null, null);
	    else
		valor_aux := valor(actual.key);

		if valor_aux = valor_key then
		    raise already_exists;
		elsif valor_key < valor_aux then
		    recursive_put(actual.left, elem);
		elsif valor_key > valor_aux then
		    recursive_put(actual.right, elem);
		end if;
	    end if;

	end recursive_put;

        str_filtrada: String := filtrar_string(elem);
    begin
	recursive_put(reg.root, str_filtrada);
    exception
        when already_exists =>
            null; -- No fer res.
    end put;

    procedure print_bst(reg: in bst) is
        procedure inordre(p:in pnode) is
        begin
            if p/=null then
                inordre(p.left);
                mostra(p.key);
                inordre(p.right);
            end if;
        end inordre;
    begin

	if reg.root = null then
	    put_line("Cap registre!!!!");
	end if;
	inordre(reg.root);
	New_Line;New_Line;
    end print_bst;

end registre_visites;
