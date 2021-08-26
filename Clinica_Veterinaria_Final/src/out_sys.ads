with Ada.Text_IO; use Ada.Text_IO;
with Ada.Direct_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with constants; use constants;
package out_sys is


    -- Nom del fitxer,
    nom_fitx: Unbounded_String;
    -- Fitxer on es gravara tot l'output en cas del mode Automatic
    fitx: File_Type;


    -- Agafa la linia especificada MOD n_files del fitxer.
    function get_linia_filtrada(line: in integer) return String;
    -- Agafa la linia especificada del fitxer "mascotes"
    function get_linia(line: in Integer) return String;


    procedure init(nom_fitxer: in String);
    procedure init;

    -- Procediment de crida general.
    --     Aqui es decideix si es mostra per pantalla o si es grava a memoria secundaria.
    procedure print(msg: in String);
private
    procedure mostra(msg: in String);
    procedure grava(msg: in String);
    n_files: Integer;
    nom_reg_mascotes: String := "mascotes";
end out_sys;
