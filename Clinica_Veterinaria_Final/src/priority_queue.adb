with Ada.Text_IO; use Ada.Text_IO;
package body priority_queue is
    maxim: index := index(max); --per evitar constraint errors

    procedure insert(q: in out p_coa; element: in item) is
        function ">="(a,b: in item) return boolean is
        begin
            return a>b OR a=b;
        end ">=";
        idx: Integer;
        pi: Integer;
    begin
        if q.elements=max then
            raise space_overflow;
        end if;
        -- No exception was risen
        -- Es cercarà la posicio mentre que l'element sigui menor o igual
        q.elements:=q.elements+1; idx:=q.elements; pi := idx/2;
        while pi>0 and then q.contingut(pi) > element loop
            q.contingut(idx):=q.contingut(pi);
            idx:=pi;
            pi:=idx/2;
        end loop;
        q.contingut(idx):=element;
    end insert;

    -- Retorna una nova coa de prioritats buida
    function new_p_coa return p_coa is
        coa: p_coa;
    begin
        coa.elements :=0;
        return coa;
    end new_p_coa;

    function rem_first(q: in out p_coa) return item is
        var: item;
        aux: item;
        idx: Integer;
        ci: Integer;
    begin
        if q.elements = 0 then
            raise bad_use;
        end if;
        -- Obtenim l'element a retornar
        var := q.contingut(1);
        aux := q.contingut(q.elements);
        q.elements := q.elements-1;


        idx:=1; ci:=idx*2;
        if ci<q.elements and then q.contingut(ci+1)<q.contingut(ci) then
            ci:=ci+1;
        end if;

        while ci<=q.elements and then q.contingut(ci)<aux loop
            q.contingut(idx):=q.contingut(ci); idx := ci; ci := idx*2;
            if ci<q.elements and then q.contingut(ci+1)<q.contingut(ci) then
                ci:=ci+1;
            end if;
        end loop;
        q.contingut(idx):=aux;
        return var;
    end rem_first;

    function empty(q: in p_coa) return boolean is
    begin
        return q.elements=0;
    end empty;

    function size(q: in p_coa) return Natural is
    begin
        return q.elements;
    end size;

    procedure print_p_coa(q: in p_coa) is
        idx: index := index'first;
    begin
	if q.elements = 0 then
	    Put_line("La coa esta buida");
	else
            while idx<=q.elements loop
                Put_Line(">"&Image(q.contingut(idx)));
                idx :=idx +1;
            end loop;
	end if;
    end print_p_coa;

    function max_index(q: in p_coa) return Integer is
    begin
        return maxim;
    end max_index;

end priority_queue;
