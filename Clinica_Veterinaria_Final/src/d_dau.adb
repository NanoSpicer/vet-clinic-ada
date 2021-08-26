package body d_dau is

    procedure new_dau(dau: out type_dau; seed: in Integer) is
    begin
        dau.llavor:=seed;
        Random_Int.Reset(dau.gen, dau.llavor);
    end new_dau;


    function llansar_dau_binari(dau: in type_dau; prob: in Natural) return boolean is
        resultat: Positive := Random_Int.Random(dau.gen);
    begin
        -- Si el resultat esta dins el rang establert, ha tocat.
        return resultat in 1..prob;
    end llansar_dau_binari;

    function llansar_dau(dau: in type_dau) return Integer is
    begin
        return Random_Int.Random(dau.gen);
    end llansar_dau;


end d_dau;
