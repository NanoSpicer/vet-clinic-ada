with Ada.Numerics.Discrete_Random;
package d_dau is

    type type_dau is limited private;

    -- Funcio que ens crea un dau nou.
    procedure new_dau(dau: out type_dau; seed: in Integer);
    -- Llansa un dau amb la probabilitat indicada sobre 100. Diu si ha tocat o no.
    -- I sí, també em provoca cancer ocular escriure llansa amb s
    function llansar_dau_binari(dau: in type_dau; prob: in Natural) return boolean;
    pragma inline(llansar_dau_binari);

    -- Llansa un dau, i retorna un nombre de l'1 al 100
    function llansar_dau(dau: in type_dau) return Integer;
    pragma inline(llansar_dau);

private
    subtype rang_dau is Positive range 1..100;
    package Random_Int is new Ada.Numerics.Discrete_Random(rang_dau);

    type type_dau is record
        gen: Random_Int.Generator;
        llavor: Integer;
    end record;
end d_dau;
