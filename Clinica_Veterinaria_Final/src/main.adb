with Ada.Text_IO; use Ada.Text_IO;
with Ada.Command_Line; use Ada.Command_Line;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with d_dau; use d_dau;
with out_sys;
with clinica_veterinaria; use clinica_veterinaria;
with constants; use constants;

pragma Warnings(off);
procedure Main is

    bad_arguments: exception;

    dau: type_dau;
    acabar: boolean := false;

    procedure attend_queries(clinica: in type_clinica) is

        function llegir_consulta return unbounded_string is
        begin
            Ada.Text_IO.Put("insert_query>> ");
            return to_unbounded_string(Ada.Text_IO.Get_Line);
        end llegir_consulta;

        procedure parse_query(query: in String) is
            tipus_keyword: String := "tipus";
            nom_animal: String := query;
            correcte: boolean := false;
        begin
            correcte:=mostrar_historial(clinica, nom_animal);
            if NOT correcte then
		-- Aplicar l'altra query.
                if tipus_keyword = query(query'first..tipus_keyword'last) then
                    -- analitzar el segon argument
		    declare
			-- +2 = tipu[s 'espai'] TIPUS_REAL
			tipus_str: String := query(tipus_keyword'last+2..query'last);
		    begin
			if tipus_str = "revisio" then
			    out_sys.print(clinica.reg_visites(REVISIO).registres'image&" revisions");
			    print_registre_visites(clinica, REVISIO);
			elsif tipus_str = "cura" then
			    out_sys.print(clinica.reg_visites(CURA).registres'image&" cures");
			    print_registre_visites(clinica, CURA);
			elsif tipus_str = "cirugia" then
			    out_sys.print(clinica.reg_visites(CIRUGIA).registres'image&" cirugies");
			    print_registre_visites(clinica, CIRUGIA);
			elsif tipus_str = "emergencia" then
			    out_sys.print(clinica.reg_visites(EMERGENCIA).registres'image&" emergencies");
			    print_registre_visites(clinica, EMERGENCIA);
			else
			    raise constraint_error;
			end if;
		    end;

                else
                    raise constraint_error;
                end if;
            end if;
        exception
            when constraint_error =>
		out_sys.print("No es reconeix '"&query&"' com a una comanda valida");
		out_sys.print("Empri");
		out_sys.print("    >ls espera  [mostra la llista d'espera]");
		out_sys.print("    >nom_animal [mostra l'historial clinic de la mascota]");
		out_sys.print("    >tipus visi [mostra la quantitat de registres hi ha d'aquell tipus de visita i a qui pertanyen]");
        end parse_query;


	query: Unbounded_String := to_unbounded_string("");
	end_q: boolean := false;
    begin
        -- Mentres que la consulta no sigui la de continuar
        while NOT end_q loop
	    query := llegir_consulta;
            -- processar consulta
            if to_string(query) = "c" then
		end_q:=true; -- no fer res.
	    elsif to_string(query) = "exit" then
		end_q:=true;
		acabar:=true;
            elsif to_string(query) = "ls espera" then
                print_llista_espera(clinica);
            else
                -- mirar si es el llistar historial o be donat un tipus de visita # insercions.
                parse_query(to_string(query));
            end if;

        end loop;
        out_sys.print(""&Standard.ASCII.LF&Standard.ASCII.LF);
    end attend_queries;


    procedure obrir_tancar_consultes(clinica: in out type_clinica) is
        consulta_aux: consulta;
        consultes_obertes: Integer := count_consultes_obertes(clinica.consultes);
        probabilitat: Integer := constants.PROB_OC_CONSULTA;
    begin

        if consultes_obertes > MIN_CONSULTES then
            -- provar a tancar-ne una
            for i in 1..consultes_obertes loop
                -- Per cada consulta NO ocupada llançar un dau.
                consulta_aux:= clinica.consultes(id_consulta(i));
                if NOT consulta_aux.ocupada then
                    --llançar un dau i actuar en consecuencia
                    if llansar_dau_binari(dau, probabilitat) then
                        tancar_consulta(clinica, i);
                    end if;
                end if;
            end loop;
	end if;

	if consultes_obertes < MAX_CONSULTES then
            -- provar d'obrirne una
            if llansar_dau_binari(dau, probabilitat) then
                obrir_consulta(clinica);
            end if;
        end if;
    end obrir_tancar_consultes;

    procedure entrada_mascota(clinica: in out type_clinica; cicle_inici: in Positive) is
        probabilitat: Integer := constants.PROB_ENT_MASCOTA;

	random: Integer:=llansar_dau(dau);
	nom_masc: String := out_sys.get_linia_filtrada(random);

	tip_vis: tipus_visita;

	p_masc : p_mascota;
	my_vis: visita;
    begin

	if llansar_dau_binari(dau, probabilitat) then

	    -- Si la mascota no esteia enregistrada; l'enregistra.
	    p_masc := entrada_mascota(clinica, nom_masc);

            -- Llançam un dau per saber quin tipus de visita sera
            random := llansar_dau(dau);
            if random in 1..25 then
                tip_vis:=REVISIO;
            elsif random in 26..50 then
                tip_vis:=CURA;
            elsif random in 51..75 then
                tip_vis:=CIRUGIA;
            elsif random in 76..100 then
                tip_vis:=EMERGENCIA;
	    end if;

	    my_vis := new_visita(tip_vis,p_masc,cicle_inici);
	    -- Ficam la mascota a la sala d'espera.
	    pasar_mascota_sala_espera(clinica,my_vis);
        end if;

    end entrada_mascota;

    type mode_execucio is (AUTO, MAN);

    cicles: Integer := 200;
    i: integer:=1;
    seed: Integer;
    clinica: type_clinica;
    mode: mode_execucio;
    fitx_simulacio: String := "simulacio.output";
begin

    seed:=Integer'Value(Argument(1));

    if Argument_Count = 1 then
	mode:= MAN;
	out_sys.init("");
    elsif Argument_Count = 2 then
	mode := AUTO;
	cicles:= Integer'Value(Argument(2));
	out_sys.init(fitx_simulacio);
    else
	raise bad_arguments;
    end if;


    -- Si cap excepcio ha estat aixecada, procedim a executar el programa.
    out_sys.print("<inicialitzant>"&Standard.ASCII.lf);
    -- inicialitzam la clinica
    clinica  := new_clinica;
    -- Inicialitzam el dau
    new_dau(dau, seed);

    out_sys.print("</inicialitzant>"&Standard.ASCII.LF&Standard.ASCII.LF&Standard.ASCII.LF);
    while NOT acabar loop

	out_sys.print("<Cicle"&i'image&">"&Standard.ASCII.lf);
        -- Contemplam la possibilitat de obrir o tancar consultes segons el 10% de posibilitats
	obrir_tancar_consultes(clinica);

        -- Contemplam la possibilitat de que entri algú. 75% de probs.
	entrada_mascota(clinica, i);

        -- Feim passar als seguents pacients.
	fer_passar_mascotes(clinica);

        -- S'actualitza la clinica. Es sumen els cicles d'espera corresponents a la coa de espera
	actualitzar(clinica);

        -- Si al final del cicle; alguna mascota ha complert amb els cicles, aquesta es despatxa.
        despatxar_mascotes(clinica);

        mostrar_clinica(clinica);
	out_sys.print(Standard.ASCII.lf&"</Cicle"&i'image&">"&Standard.ASCII.LF&""&Standard.ASCII.LF);
        -- Despatxar queries
        if mode=MAN then
            attend_queries(clinica);
	else
	    -- MODE = AUTO
	    if i=cicles then
		-- hem complert els cicles indicats
		acabar:=true;
	    end if;
	end if;
	i:=i+1;
    end loop;

exception
    when bad_arguments =>
        Put_Line("Arguments Invalids.");
        Put_Line("Assegura't de que els arguments siguin nombres");
        Put_Line("Exemple: (Contingut entre claudators es per al mode Auto)");
	Put_Line("./programa llavor_generador [ nombre_de_cicles] ");
   -- when constraint_error =>
	--Put_Line("Assegura't de que els arguments siguin nombres");
end Main;
