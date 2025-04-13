-- CUBE

-- Zapytanie agreguje przychody z wypozyczen wedlug producenta, modelu, koloru oraz typu napedu.
SPOOL wynik1.txt

SELECT 
    NVL(pr.NAZWA, 'RAZEM - PRODUCENT') AS PRODUCENT,
    NVL(m.NAZWA, 'RAZEM - MODEL') AS MODEL,
    NVL(k.NAZWA, 'RAZEM - KOLOR') AS KOLOR,
    NVL(tn.NAZWA, 'RAZEM - TYP NAPEDU') AS TYP_NAPEDU,
    agg.LACZNY_PRZYCHOD
FROM (
    SELECT 
        pr.id AS PRODUCENT_ID,
        m.id AS MODEL_ID, 
        k.id AS KOLOR_ID,
        tn.id AS TYP_NAPEDU_ID, 
        SUM(wyp.CENA) AS LACZNY_PRZYCHOD
    FROM WYPOZYCZENIA wyp
        JOIN SKUTER s ON wyp.ID_SKUTER = s.ID
        JOIN PRODUCENT pr ON s.ID_MODEL = pr.ID
        JOIN MODEL m ON s.ID_MODEL = m.ID
        JOIN KOLOR k ON s.ID_KOLOR = k.ID
        JOIN TYP_NAPEDU tn ON s.ID_TYP_NAPEDU = tn.ID
    GROUP BY CUBE (pr.id, m.id, k.id, tn.id)  
) agg
LEFT JOIN PRODUCENT pr ON agg.PRODUCENT_ID = pr.ID
LEFT JOIN MODEL m ON agg.MODEL_ID = m.ID
LEFT JOIN KOLOR k ON agg.KOLOR_ID = k.ID
LEFT JOIN TYP_NAPEDU tn ON agg.TYP_NAPEDU_ID = tn.ID
ORDER BY agg.LACZNY_PRZYCHOD;

SPOOL OFF;

----------------------------------------------------------------------------------------------
-- Zapytanie agreguje liczbe skuterow wedlug modelu, koloru oraz pakietu wyposazenia.
SPOOL wyniki2.txt

SELECT 
    NVL(m.NAZWA, 'RAZEM - MODEL') AS MODEL,
    NVL(k.NAZWA, 'RAZEM - KOLOR') AS KOLOR,
    NVL(pw.NAZWA, 'RAZEM - PAKIET WYPOSAZENIA') AS PAKIET_WYPOSAZENIA,
    agg.LICZBA_SKUTEROW
FROM (
    SELECT 
        m.id AS MODEL_ID,
        k.id AS KOLOR_ID, 
        pw.id AS PAKIET_WYPOSAZENIA_ID, 
        COUNT(s.ID) AS LICZBA_SKUTEROW
    FROM SKUTER s
        JOIN MODEL m ON s.ID_MODEL = m.ID
        JOIN KOLOR k ON s.ID_KOLOR = k.ID
        JOIN PAKIET_WYPOSAZENIA pw ON s.ID_PAKIET_WYPOSAZENIA = pw.ID
    GROUP BY CUBE (m.id, k.id, pw.id)
) agg
LEFT JOIN MODEL m ON agg.MODEL_ID = m.ID
LEFT JOIN KOLOR k ON agg.KOLOR_ID = k.ID
LEFT JOIN PAKIET_WYPOSAZENIA pw ON agg.PAKIET_WYPOSAZENIA_ID = pw.ID
WHERE agg.liczba_skuterow > 1
ORDER BY agg.LICZBA_SKUTEROW;

SPOOL OFF;

----------------------------------------------------------------------------------------------
--Zapytanie agreguje liczbe unikalnych klientow wedlug wojewodztwa, miasta i wypozyczalni.
SPOOL wyniki3.txt

SELECT 
    NVL(w.NAZWA, 'RAZEM - WOJEWODZTWO') AS WOJEWODZTWO,
    NVL(m.NAZWA, 'RAZEM - MIASTO') AS MIASTO,
    NVL(wy.NAZWA, 'RAZEM - WYPOSYCZALNIA') AS WYPOSYCZALNIA,
    agg.LICZBA_KLIENTOW
FROM (
    SELECT 
        w.id AS WOJEWODZTWO_ID,
        m.id AS MIASTO_ID,
        wy.id AS WYPOSYCZALNIA_ID,
        COUNT(DISTINCT k.ID) AS LICZBA_KLIENTOW
    FROM WYPOZYCZENIA wyp
        JOIN KLIENT k ON wyp.ID_KLIENT = k.ID
        JOIN ULICA u ON k.ID_ULICA = u.ID
        JOIN MIASTO m ON u.ID_MIASTO = m.ID
        JOIN WOJEWODZTWO w ON m.ID_WOJEWODZTWO = w.ID
        JOIN PRACOWNIK pr ON wyp.ID_PRACOWNIK = pr.ID 
        JOIN WYPOZYCZALNIA wy ON pr.ID_WYPOZYCZALNIA = wy.ID 
    GROUP BY CUBE (w.id, m.id, wy.id)
) agg
LEFT JOIN WOJEWODZTWO w ON agg.WOJEWODZTWO_ID = w.ID
LEFT JOIN MIASTO m ON agg.MIASTO_ID = m.ID
LEFT JOIN WYPOZYCZALNIA wy ON agg.WYPOSYCZALNIA_ID = wy.ID
ORDER BY agg.LICZBA_KLIENTOW;

SPOOL OFF;