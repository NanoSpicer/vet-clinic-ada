with Ada.Text_IO;
package body d_list is

    procedure new_list(p: out list) is
    begin
        p.TOS:=null;
    end new_list;

    procedure push(p: in out list; x: in item) is
        nou_node: PNode;
    begin
        nou_node := new Node'(x, p.TOS);
        p.TOS:=nou_node;
    end push;

    procedure show_list(p: in list) is
        aux: PNode := p.TOS;
    begin
        if aux=null then
            Ada.Text_IO.Put_Line("Buid");
        else
            while aux/=null loop
                Ada.Text_IO.Put_Line(Image(aux.content));
                aux:=aux.prev;
            end loop;
        end if;
    end show_list;


end d_list;
