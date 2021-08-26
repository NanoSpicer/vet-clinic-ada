with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with constants; use constants;
with priority_queue; with out_sys;
with d_list; with hash_map;
with registre_visites;
package clinica_veterinaria is

     -- Declaracio dels registres de les visites
    type tipus_visita is (REVISIO, CURA, CIRUGIA, EMERGENCIA);
    type reg_visita is record
        tipus: tipus_visita;
        cicle_inici: Positive;
    end record;
    -- Representacio String d'un registre de visita
    function Image(v: in reg_visita) return String;
    -- L'historial d'una mascota es una pila de registres.
    package historial_mascota is new d_list(reg_visita, Image);
    use historial_mascota;

    -- Declaracio de les mascotes
    subtype id_mascota is Positive range 1..Positive'last;
    -- Variable d'on es recolliran els identificadors
    following_id: id_mascota := id_mascota'first;
    type mascota is record
        nom: Unbounded_String;
        id: id_mascota;
        historial: historial_mascota.list;
    end record;
    type p_mascota is access mascota;

    -- Una visita consta del visitant, el tipus de visita, el temps d'espera i l'inici d'aquesta
    type visita is record
        visitant: mascota;
        tipus: tipus_visita;
        valor_prioritat: Integer;
        cicle_inici: Positive;
    end record;
    type p_visita is access visita;

    function "<"(a,b: in visita) return boolean;
    pragma inline("<");
    function ">"(a,b: in visita) return boolean;
    pragma inline(">");
    function "="(a,b: in visita) return boolean;
    pragma inline("=");
    function Image(a: in visita) return String;
    pragma inline(Image);

    -- Declaracio de les consultes
    subtype id_consulta is Positive range MIN_CONSULTES..MAX_CONSULTES;
    type consulta is record
        id: id_consulta;
        cicles_ocupacio: Natural := 0;
        ocupada: boolean;
        oberta: boolean;
        atenent: p_visita;
    end record;

    package coa_visites is new priority_queue(visita, "<", ">", "=", Image);
    package registre_clinica is new hash_map(item => p_mascota);
    -- El package registre_visites es un BST.
    package registres_visites is new registre_visites(MAX_LENGTH => MAX_NAME_LENGTH);
    use coa_visites; use registre_clinica; use registres_visites;

    type reg_visitants is record
        registres: Integer :=0;
        visitants: bst := new_registre;
    end record;
    type registre_visites is array(tipus_visita) of reg_visitants;

    type array_consultes is array(id_consulta) of consulta;

    type type_clinica is record
        consultes: array_consultes;
        llista_espera: p_coa;
        reg_clinica: registre_clinica.map;
        reg_visites: registre_visites;
    end record;

    function new_clinica return type_clinica;
    function new_mascota(nom: in String) return p_mascota;
    function new_visita(tipo: in tipus_visita; visitant: in p_mascota; inici: in Positive) return visita;
    function count_consultes_obertes(consultes: in array_consultes) return integer;

    procedure obrir_consulta(clinica: in out type_clinica);
    procedure tancar_consulta(clinica: in out type_clinica; posicio: in Natural);

    function entrada_mascota(clinica: in out type_clinica; nom: in String) return p_mascota;
    procedure pasar_mascota_consulta(clinica: in out type_clinica);
    procedure pasar_mascota_sala_espera(clinica: in out type_clinica; vis: in visita);
    procedure fer_passar_mascotes(clinica:in out type_clinica);
    procedure despatxar_mascotes(clinica: in out type_clinica);
    procedure mostrar_clinica(clinica: in type_clinica);

    function mostrar_historial(clinica: in type_clinica; nom_animal: in String) return boolean;
    procedure print_llista_espera(clinica: in type_clinica);
    procedure print_registre_visites(clinica: in type_clinica; tipus: in tipus_visita);
    procedure actualitzar(clinica: in out type_clinica);
end clinica_veterinaria;
