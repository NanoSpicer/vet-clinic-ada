package constants is

    nom_massa_llarg: exception;
    -- Constants sobre les consultes
    MIN_CONSULTES: constant Positive := 1;
    MAX_CONSULTES: constant Positive := 5;

    -- Constants sobre les probabilitats
    PROB_OC_CONSULTA: constant Positive := 10;
    PROB_ENT_MASCOTA: constant Positive := 75;

    -- Constants sobre els cicles d'espera.
    CESPERA_REVISIO: constant Positive := 3;
    CESPERA_CURA: constant Positive := 5;
    CESPERA_CIRUGIA: constant Positive := 8;
    CESPERA_EMERGENCIA: constant Positive := 4;

    -- Constants de les prioritats
--    PR_REVISIO: constant Positive := 0; no es necessari. simplement ho ignorarem
    PR_CURA: constant Positive := 1;
    PR_CIRUGIA: constant Positive := 2;
    PR_EMERGENCIA: constant Positive := 3;

    -- Cada fila del fitxer de mascotes tendra:
    --    x lletres = nom
    --    y epais  = on x+y = 20
    MAX_NAME_LENGTH: constant Integer := 20;
    END_OF_NAME: constant Character := '.';
end constants;
