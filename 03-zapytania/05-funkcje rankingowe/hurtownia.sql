-- FUNKCJE RANKINGOWE

-- 1. Sprawdzenie, ktore modele skuterow i typy napedu ciesza sie najwiekszym zainteresowaniem w poszczegolnych wypozyczalniach, z rankingiem wedlug liczby wypozyczen.

SELECT 
    wyp.NAZWA AS WYPOZYCZALNIA,
    mo.NAZWA AS MODEL,
    tn.NAZWA AS TYP_NAPEDU,
    agg.LICZBA_WYPOZYCZEN,
    RANK() OVER (PARTITION BY agg.ID_WYPOZYCZALNIA ORDER BY agg.LICZBA_WYPOZYCZEN DESC) AS RANKING
FROM (
    SELECT 
        ID_WYPOZYCZALNIA_SKUTER AS ID_WYPOZYCZALNIA,
        ID_MODEL,
        ID_TYP_NAPEDU,
        COUNT(*) AS LICZBA_WYPOZYCZEN
    FROM H_WYPOZYCZENIA
    GROUP BY ID_WYPOZYCZALNIA_SKUTER, ID_MODEL, ID_TYP_NAPEDU
) agg
JOIN H_WYPOZYCZALNIA wyp ON agg.ID_WYPOZYCZALNIA = wyp.ID
JOIN H_MODEL mo ON agg.ID_MODEL = mo.ID
JOIN H_TYP_NAPEDU tn ON agg.ID_TYP_NAPEDU = tn.ID;



-------------------------------------------------------------------------------------
-- 2. Sprawdzenie, ktore kombinacje producenta, typu napedu i pakietu wyposazenia oferuja skutery o najwyzszej sredniej pojemnosci.

SELECT 
    p.NAZWA AS PRODUCENT,
    tn.NAZWA AS TYP_NAPEDU,
    pw.NAZWA AS PAKIET_WYPOSAZENIA,
    agg.SREDNIA_POJEMNOSC,
    DENSE_RANK() OVER (ORDER BY agg.SREDNIA_POJEMNOSC DESC) AS RANKING
FROM (
    SELECT 
        w.ID_PRODUCENT,
        w.ID_TYP_NAPEDU,
        w.ID_PAKIET_WYPOSAZENIA,
        AVG(w.POJEMNOSC) AS SREDNIA_POJEMNOSC
    FROM H_WYPOZYCZENIA w
    GROUP BY w.ID_PRODUCENT, w.ID_TYP_NAPEDU, w.ID_PAKIET_WYPOSAZENIA
) agg
JOIN H_PRODUCENT p ON agg.ID_PRODUCENT = p.ID
JOIN H_TYP_NAPEDU tn ON agg.ID_TYP_NAPEDU = tn.ID
JOIN H_PAKIET_WYPOSAZENIA pw ON agg.ID_PAKIET_WYPOSAZENIA = pw.ID;


-------------------------------------------------------------------------------------
-- 3. Sprawdzenie, ktory pracownik najczesciej obsluguje wypozyczenia skuterow danego producenta w danej wypozyczalni.

SELECT 
    w.NAZWA AS NAZWA_WYPOZYCZALNI,
    prod.NAZWA AS NAZWA_PRODUCENTA,
    p.IMIE || ' ' || p.NAZWISKO AS PRACOWNIK,
    agg.LICZBA_OBSLUZONYCH_WYPOZYCZEN,
    DENSE_RANK() OVER (PARTITION BY agg.ID_WYPOZYCZALNIA_PRACOWNIK ORDER BY agg.LICZBA_OBSLUZONYCH_WYPOZYCZEN DESC) AS RANKING
FROM (
    SELECT 
        f.ID_PRACOWNIK,
        f.ID_WYPOZYCZALNIA_PRACOWNIK,
        f.ID_PRODUCENT,
        COUNT(*) AS LICZBA_OBSLUZONYCH_WYPOZYCZEN
    FROM H_WYPOZYCZENIA f
    GROUP BY f.ID_PRACOWNIK, f.ID_WYPOZYCZALNIA_PRACOWNIK, f.ID_PRODUCENT
) agg
JOIN H_PRACOWNIK p ON agg.ID_PRACOWNIK = p.ID
JOIN H_WYPOZYCZALNIA w ON agg.ID_WYPOZYCZALNIA_PRACOWNIK = w.ID
JOIN H_PRODUCENT prod ON agg.ID_PRODUCENT = prod.ID;


