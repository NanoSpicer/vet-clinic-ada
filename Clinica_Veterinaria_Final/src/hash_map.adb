package body hash_map is

    -- Funcio de hash map
    function f_hash(key: in String) return index is
        sum: Integer :=0;
    begin
        for i in key'first..key'last loop
            sum:= sum + Character'Pos(key(i));
        end loop;
        return index(sum mod real_max);
    end f_hash;

    procedure new_hash(h: out map) is
    begin
        for i in h.hash'first..h.hash'last loop
            h.hash(i).key:=To_Unbounded_String("");
            h.hash(i).free:=true;
        end loop;
    end new_hash;

    procedure insert(h: in out map; key: in String; x: in item) is
        meva_taula: taula_dispersio renames h.hash;
        pos: index := f_hash(key);
        original: index:=pos;
    begin
	if NOT meva_taula(pos).free then

	    if to_string(meva_taula(pos).key) = key then
		raise already_exists;
	    end if;

            -- Saltam una casella.
            pos:=pos+1;
            while NOT meva_taula(pos).free and pos/=original loop
                -- Cercam una posicio buida de manera circular
                pos:=(pos+1) mod taula_dispersio'last;
            end loop;

            if pos=original then
                raise out_of_space;
            end if;
        end if;
        meva_taula(pos).key:=To_Unbounded_String(key);
        meva_taula(pos).content:=x;
        meva_taula(pos).free:=false;
    end insert;


    function read(h: in map; key: in String) return item is
        meva_taula: taula_dispersio renames h.hash;
        pos: index := f_hash(key);
        original: index:=pos;
    begin
	if meva_taula(pos).free then
	    raise no_such_item;
	else
	    if to_string(meva_taula(pos).key) /= key then
		-- Saltam una casella.
		pos:=pos+1;
		-- Cercam l'item en les caselles seguents de manera circular
		while to_string(meva_taula(pos).key) /= key and pos/=original loop
		    pos:=(pos+1) mod taula_dispersio'last;
		end loop;

		-- error fatal
		if pos=original then
		    raise Constraint_Error; --raise no_such_item;
		end if;
	    end if;
	end if;
        return meva_taula(pos).content;
    end read;

end hash_map;
