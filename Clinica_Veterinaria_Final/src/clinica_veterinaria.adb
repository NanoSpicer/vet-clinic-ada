package body clinica_veterinaria is

    function Image(v: in reg_visita) return String is
        var: Unbounded_String := to_unbounded_string("");
    begin
        Append(var, "Tipus de visita: "&v.tipus'Image);
        Append(var,  ""&Standard.ASCII.LF);
        Append(var, "Hora: "&v.cicle_inici'Image);
        Append(var,  ""&Standard.ASCII.LF);
        return to_string(var);
    end Image;
    function "<"(a,b: in visita) return boolean is
    begin
        return a.valor_prioritat<b.valor_prioritat;
    end "<";
    function ">"(a,b: in visita) return boolean is
    begin
        return a.valor_prioritat>b.valor_prioritat;
    end ">";
    function "="(a,b: in visita) return boolean is
    begin
	return a.valor_prioritat=b.valor_prioritat;
    end "=";

    function new_clinica return type_clinica is
        c: type_clinica;
    begin
	out_sys.print("S'ha obert la clinica veterinaria!");
        -- Inicialitzam el hash del registre de clients.
        new_hash(c.reg_clinica);
        -- Init consultes
        for i in array_consultes'first..array_consultes'last loop
            c.consultes(i).id:=i;
            c.consultes(i).atenent:=null;
            c.consultes(i).cicles_ocupacio:=0;
            c.consultes(i).ocupada:=false;
            c.consultes(i).oberta:=false;
        end loop;
        -- N'obrim una
        obrir_consulta(c);
        c.llista_espera := new_p_coa;
        return c;
    end new_clinica;

    function new_mascota(nom: in String) return p_mascota is
        masc: p_mascota := new mascota;
    begin
        -- Copiam el nom
        masc.nom:=To_Unbounded_String(nom);
        -- Assignam un id
        masc.id := clinica_veterinaria.following_id;
        -- Actualitzam el seguent id.
        clinica_veterinaria.following_id := clinica_veterinaria.following_id +1;
        -- Inicialitzam l'historial
        new_list(masc.historial);
        return masc;
    end new_mascota;


    function new_visita(tipo: in tipus_visita; visitant: in p_mascota; inici: in Positive) return visita is
        valor_prioritat: Integer:=inici;
    begin
        case tipo is
            when REVISIO=>
                null; -- No fer res
            when CURA=>
                valor_prioritat:=valor_prioritat - constants.PR_CURA;
            when CIRUGIA=>
                valor_prioritat:=valor_prioritat - constants.PR_CIRUGIA;
            when EMERGENCIA=>
                valor_prioritat:=valor_prioritat - constants.PR_EMERGENCIA;
        end case;

        return visita'(mascota'(visitant.all),tipo, valor_prioritat,inici);
    end new_visita;

    function count_consultes_obertes(consultes: in array_consultes) return integer is
        count: integer :=0;
    begin
        for i in consultes'first..consultes'last loop
            if consultes(i).oberta then
                count := count +1;
            end if;
        end loop;
        return count;
    end count_consultes_obertes;

    -- troba la primera consulta tancada i l'obri
    procedure obrir_consulta(clinica: in out type_clinica) is
        i: Integer:= clinica.consultes'first;
    begin

        while i<=array_consultes'last AND THEN clinica.consultes(i).oberta loop
            i:=i+1;
        end loop;

        clinica.consultes(i).oberta:=true;
        out_sys.print("S'ha obert la consulta "&clinica.consultes(i).id'image);
    end obrir_consulta;

    procedure tancar_consulta(clinica: in out type_clinica; posicio: in Natural) is
    begin
        clinica.consultes(posicio).oberta:=false;
        out_sys.print("S'ha tancat la consulta "&clinica.consultes(posicio).id'image);
    end tancar_consulta;



    function entrada_mascota(clinica: in out type_clinica; nom: in String) return p_mascota is
	p_masc: p_mascota;
    begin
	p_masc := new_mascota(nom);
        insert(clinica.reg_clinica, to_string(p_masc.nom), p_masc);
        out_sys.print("Ha entrat i ENREGISTRAT la mascota "&to_string(p_masc.nom));
	return p_masc;
    exception
	when registre_clinica.already_exists =>
            clinica_veterinaria.following_id:=clinica_veterinaria.following_id-1;
            p_masc:= read(clinica.reg_clinica, to_string(p_masc.nom));
            out_sys.print("Ha entrat la mascota JA ENREGISTRADA "&to_string(p_masc.nom));
	    return p_masc;
    end entrada_mascota;


    procedure pasar_mascota_consulta(clinica: in out type_clinica) is
        i: integer := array_consultes'first;
        espera: Integer;
        p_vis: p_visita;
    begin
	p_vis := new visita'(rem_first(clinica.llista_espera));
        while i<=array_consultes'last AND THEN clinica.consultes(i).ocupada loop
            i:=i+1;
        end loop;

        case p_vis.tipus is
            when REVISIO =>
                espera:=constants.CESPERA_REVISIO;
            when CURA =>
                espera:=constants.CESPERA_CURA;
            when CIRUGIA =>
                espera:=constants.CESPERA_CIRUGIA;
            when EMERGENCIA =>
                espera:=constants.CESPERA_EMERGENCIA;
        end case;

        clinica.consultes(i).atenent:=p_vis;
        clinica.consultes(i).ocupada:=true;
        clinica.consultes(i).cicles_ocupacio:=espera;
        out_sys.print("La mascota "&to_string(p_vis.visitant.nom)&" passa a consulta "&clinica.consultes(i).id'Image);
    end pasar_mascota_consulta;

    procedure pasar_mascota_sala_espera(clinica: in out type_clinica; vis: in visita) is
    begin
        insert(clinica.llista_espera, vis);
	out_sys.print(to_string(vis.visitant.nom)&" passa a la sala d'espera per una "&vis.tipus'Image);
    end pasar_mascota_sala_espera;


    procedure fer_passar_mascotes(clinica: in out type_clinica) is
        cicles: Positive := 1;
        vis_aux: visita;
    begin

        --Per cada consulta oberta i NO ocupada, llevam una mascota de la llista d'espera
        for i in clinica.consultes'first..clinica.consultes'last loop
            if clinica.consultes(i).oberta AND THEN NOT clinica.consultes(i).ocupada then
		vis_aux:= rem_first(clinica.llista_espera);
		out_sys.print("La mascota "&to_string(vis_aux.visitant.nom)&" pot passar a consulta");
                case vis_aux.tipus is
                    when REVISIO =>
                        cicles:=constants.CESPERA_REVISIO;
                    when CURA =>
                        cicles:=constants.CESPERA_CURA;
                    when CIRUGIA =>
                        cicles:=constants.CESPERA_CIRUGIA;
                    when EMERGENCIA =>
                        cicles:=constants.CESPERA_EMERGENCIA;
                end case;
                clinica.consultes(i).cicles_ocupacio:=cicles;
                clinica.consultes(i).ocupada:=true;
		clinica.consultes(i).atenent:= new visita'(vis_aux);
                out_sys.print("La mascota "&to_string(vis_aux.visitant.nom)&" passa a consulta "&clinica.consultes(i).id'Image);
            end if;

        end loop;

    exception
        -- S'aixecara un bad use quan la llista d'espera estigui buida i hi hagi consultes obertes
        when bad_use =>
            out_sys.print("Hem feta neta la llista d'espera");

    end fer_passar_mascotes;


    -- PUSH registre into the mascotes.
    procedure despatxar_mascotes(clinica: in out type_clinica) is
	my_reg: reg_visita;
	p_masc: p_mascota;
    begin
	for i in clinica.consultes'first..clinica.consultes'last loop
	    -- si la clinica esteia ocupada i ha acabat...
	    if clinica.consultes(i).ocupada AND THEN clinica.consultes(i).cicles_ocupacio=0 then

		if clinica.consultes(i).atenent = null then
		    out_sys.print("HENLO U STINKY BIRB. ATENENT WAS NULL");
		    out_sys.print(clinica.consultes(i).ocupada'image&"  -  "&clinica.consultes(i).cicles_ocupacio'image);
		end if;

		my_reg:= reg_visita'(clinica.consultes(i).atenent.tipus, clinica.consultes(i).atenent.cicle_inici);
		-- Historial mascota
		p_masc := read(clinica.reg_clinica, to_string(clinica.consultes(i).atenent.visitant.nom));
		push(p_masc.historial, my_reg);

		-- Actualitzar registre de visites
		-- ficar el nom de la mascota
		registres_visites.put(clinica.reg_visites(my_reg.tipus).visitants, to_string(p_masc.nom));
		-- Afegir 1 registre més
		clinica.reg_visites(my_reg.tipus).registres := clinica.reg_visites(my_reg.tipus).registres + 1;

                clinica.consultes(i).atenent:=null;
                clinica.consultes(i).ocupada:=false;
                out_sys.print(to_string(p_masc.nom)&" ha sortit de la consulta "&clinica.consultes(i).id'Image);
            end if;
        end loop;
    end despatxar_mascotes;

    procedure actualitzar(clinica: in out type_clinica) is
    begin

        for i in clinica.consultes'first..clinica.consultes'last loop
            if clinica.consultes(i).ocupada then
                clinica.consultes(i).cicles_ocupacio:=clinica.consultes(i).cicles_ocupacio-1;
            end if;
        end loop;

    end actualitzar;

    -- Ens diu si la funcio s'ha executat be
    function mostrar_historial(clinica: in type_clinica; nom_animal: in String) return boolean is
        p_masc: p_mascota;
    begin
        p_masc := read(clinica.reg_clinica, nom_animal);
        out_sys.print("L'historial de "&to_string(p_masc.nom)&" es el seguent: "&Standard.ASCII.LF);
        show_list(p_masc.historial);
        return true;
    exception
        when no_such_item =>
            return false;
    end mostrar_historial;

    procedure print_llista_espera(clinica: in type_clinica) is
    begin
        out_sys.print("La llista d'espera es la seguent: "&Standard.ASCII.LF);
        print_p_coa(clinica.llista_espera);
    end print_llista_espera;

    function Image(a: in visita) return String is
    begin
        return "["&to_string(a.visitant.nom)&", "&a.tipus'image&", hora_arribada:"&
          a.cicle_inici'image&" prioritat: "&a.valor_prioritat'image&"] ";
    end Image;

    procedure mostrar_clinica(clinica: in type_clinica) is
        cliniques: unbounded_String := to_unbounded_string("Cliniques > ");
        indexos: unbounded_String := to_unbounded_string("            ");
    begin

        for i in clinica.consultes'first..clinica.consultes'last loop
            Append(cliniques, "[");
            if NOT clinica.consultes(i).oberta then
                Append(cliniques, "X");
            elsif  clinica.consultes(i).ocupada then
                Append(cliniques, "O");
            else
                Append(cliniques, "F");
            end if;
            Append(cliniques, "]");
            Append(indexos, ""&i'image&" ");
        end loop;

        out_sys.print(""&Standard.ASCII.LF);
        out_sys.print(to_string(cliniques));
        out_sys.print(to_String(indexos));
        out_sys.print("X=clinica tancada; O = clinica ocupada; F = clinica lliure;");
        out_sys.print("");
    end mostrar_clinica;

    procedure print_registre_visites(clinica: in type_clinica; tipus: in tipus_visita) is
    begin
	print_bst(clinica.reg_visites(tipus).visitants);
    end print_registre_visites;


end clinica_veterinaria;
