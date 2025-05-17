-- ROLLUP

-- 1. Zapytanie agreguje przychody z wypozyczen wedlug kraju, wojewodztwa, miasta oraz metody platnosci.

SELECT 
    NVL(hp.NAZWA, 'RAZEM - PANSTWO') AS PANSTWO,
    NVL(hw.NAZWA, 'RAZEM - WOJEWODZTWO') AS WOJEWODZTWO,
    NVL(hm.NAZWA, 'RAZEM - MIASTO') AS MIASTO,
    NVL(hrp.NAZWA, 'RAZEM - PLATNOSC') AS RODZAJ_PLATNOSCI,
    agg.LACZNY_PRZYCHOD
FROM (
    SELECT 
        hwyp.ID_PANSTWO_KLIENT,
        hwyp.ID_WOJEWODZTWO_KLIENT,
        hwyp.ID_MIASTO_KLIENT,
        hwyp.ID_RODZAJ_PLATNOSCI,
        SUM(hwyp.CENA) LACZNY_PRZYCHOD
    FROM H_WYPOZYCZENIA hwyp
    GROUP BY ROLLUP (
        hwyp.ID_PANSTWO_KLIENT,
        hwyp.ID_WOJEWODZTWO_KLIENT,
        hwyp.ID_MIASTO_KLIENT,
        hwyp.ID_RODZAJ_PLATNOSCI
    )
) agg
LEFT JOIN H_PANSTWO hp ON agg.ID_PANSTWO_KLIENT = hp.ID
LEFT JOIN H_WOJEWODZTWO hw ON agg.ID_WOJEWODZTWO_KLIENT = hw.ID
LEFT JOIN H_MIASTO hm ON agg.ID_MIASTO_KLIENT = hm.ID
LEFT JOIN H_RODZAJ_PLATNOSCI hrp ON agg.ID_RODZAJ_PLATNOSCI = hrp.ID
ORDER BY agg.LACZNY_PRZYCHOD;

-- 2. Zapytanie agreguje przychody z wypozyczen wedlug wypozyczalni, pracownika i metody platnosci.



-- 3. Zapytanie agreguje przychody z wypozyczen wedlug producenta, modelu i pakietu wyposazenia skuterow.

SELECT 
    NVL(hprod.NAZWA, 'RAZEM - PRODUCENT') AS PRODUCENT,
    NVL(hmod.NAZWA, 'RAZEM - MODEL') AS MODEL,
    NVL(hpak.NAZWA, 'RAZEM - PAKIET') AS PAKIET_WYPOSAZENIA,
    agg.LACZNY_PRZYCHOD
FROM (
    SELECT 
        hwyp.ID_PRODUCENT,
        hwyp.ID_MODEL,
        hwyp.ID_PAKIET_WYPOSAZENIA,
        SUM(hwyp.CENA) AS LACZNY_PRZYCHOD
    FROM H_WYPOZYCZENIA hwyp
    GROUP BY 
        ROLLUP(hwyp.ID_PRODUCENT, hwyp.ID_MODEL, hwyp.ID_PAKIET_WYPOSAZENIA)
) agg
LEFT JOIN H_PRODUCENT hprod ON agg.ID_PRODUCENT = hprod.ID
LEFT JOIN H_MODEL hmod ON agg.ID_MODEL = hmod.ID
LEFT JOIN H_PAKIET_WYPOSAZENIA hpak ON agg.ID_PAKIET_WYPOSAZENIA = hpak.ID
ORDER BY LACZNY_PRZYCHOD;
