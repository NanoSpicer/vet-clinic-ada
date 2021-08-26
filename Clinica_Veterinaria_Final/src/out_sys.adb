with Ada.Text_IO; use Ada.Text_IO;
package body out_sys is
    package raf is new Ada.Direct_IO(Character);

    function get_linia_filtrada(line: In integer) return String is
    begin
        return get_linia(line MOD n_files);
    end get_linia_filtrada;

    function get_linia(line: in Integer) return String is

        function read_line(f: in raf.File_Type; ptr: in Integer) return Unbounded_String is
            idx: Integer := ptr;
            str: Unbounded_String := to_unbounded_string("");
            aux: Character := ' ';
        begin
            raf.Read(f, aux, raf.Count(idx));
            while NOT raf.End_Of_File(f) and then aux/=Standard.ASCII.LF and then aux/=' ' loop
                Append(str, aux);
                idx:=idx+1;
                raf.Read(f, aux, raf.Count(idx));
            end loop;
            return str;
        end read_line;

        var: Unbounded_String;
        idx: Integer;
        f: raf.File_Type;
    begin
        --Obrim el fitxer
        raf.Open(f, raf.In_File, nom_reg_mascotes);
        -- Botam caracters fins arribar a la linia que volem llegir.
        idx := 1 + ((line*constants.MAX_NAME_LENGTH));
        -- Llegim fins trobar el bot de linia
        var:=read_line(f, idx);
        -- Tancam el fitxer
        raf.Close(f);
        --Retornam la linia llegida
        return to_string(var);
    end get_linia;


    procedure init(nom_fitxer: in String) is
        function exists(name: in String) return boolean is
        begin
            Open(fitx, Out_File, name);
            Close(fitx);
            return true;
        exception
            when Name_Error=>
                return false;
        end exists;
    begin
        nom_fitx := to_unbounded_string(nom_fitxer);
        if NOT exists(nom_fitxer) and then length(nom_fitx)>0 then
            Create(fitx, Out_File, nom_fitxer);
            Close(fitx);
        end if;
    end init;

    procedure init is
    begin
        nom_fitx := to_unbounded_string("");
    end init;


    procedure print(msg: in String) is
    begin
        if Length(nom_fitx) = 0 then
            mostra(msg);
        else
            grava(msg);
        end if;
    end print;


    procedure mostra(msg: in String) is
    begin
        Put_Line(msg);
    end mostra;

    procedure grava(msg: in String) is
    begin
        Ada.Text_IO.Open(fitx, Append_File, to_string(nom_fitx));
        Ada.Text_IO.Put_line(fitx, msg);
        Ada.Text_IO.Close(fitx);
    end grava;

    --Determinam cuantes files te el fitxer d'animals.
begin
    n_files:=0;

    -- Determinam cuantes files te el fitxer
    declare
        idx: Integer := 1;
        aux_Char: Character;
        reg_masc: raf.File_Type;
    begin
        raf.Open(reg_masc, raf.In_File, nom_reg_mascotes);
        while NOT raf.End_Of_File(reg_masc) loop
            raf.Read(reg_masc, aux_Char, raf.Count(idx));
	    if aux_char=Standard.ASCII.LF OR raf.End_Of_File(reg_masc) then
                n_files:=n_files+1;
	    end if;
	    idx:=idx+1;
        end loop;
        raf.Close(reg_masc);
    end;

end out_sys;
