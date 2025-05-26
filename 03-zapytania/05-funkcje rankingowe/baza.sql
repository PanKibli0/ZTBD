-- FUNKCJE RANKINGOWE

-- 1. Sprawdzenie, ktore modele skuterow i typy napedu ciesza sie najwiekszym zainteresowaniem w poszczegolnych wypozyczalniach, z rankingiem wedlug liczby wypozyczen.

SELECT
    wy.NAZWA AS WYPOZYCZALNIA,
    m.NAZWA AS MODEL,
    t.NAZWA AS TYP_NAPEDU,
    agg.LICZBA_WYPOZYCZEN,
    agg.RANKING
FROM (
    SELECT 
        s.ID_WYPOZYCZALNIA,
        s.ID_MODEL,
        s.ID_TYP_NAPEDU,
        COUNT(wyp.ID_SKUTER) AS LICZBA_WYPOZYCZEN,
        RANK() OVER (PARTITION BY s.ID_WYPOZYCZALNIA ORDER BY COUNT(wyp.ID_SKUTER) DESC) AS RANKING
    FROM WYPOZYCZENIA wyp
    JOIN SKUTER s ON wyp.ID_SKUTER = s.ID
    GROUP BY s.ID_WYPOZYCZALNIA, s.ID_MODEL, s.ID_TYP_NAPEDU
) agg
JOIN WYPOZYCZALNIA wy ON agg.ID_WYPOZYCZALNIA = wy.ID
JOIN MODEL m ON agg.ID_MODEL = m.ID
JOIN TYP_NAPEDU t ON agg.ID_TYP_NAPEDU = t.ID
ORDER BY wy.NAZWA, agg.RANKING;


-------------------------------------------------------------------------------------
-- 2. Sprawdzenie, ktore kombinacje producenta, typu napedu i pakietu wyposazenia oferuja skutery o najwyzszej sredniej pojemnosci.

SELECT 
    p.NAZWA AS PRODUCENT,
    tn.NAZWA AS TYP_NAPEDU,
    pw.NAZWA AS PAKIET_WYPOSAZENIA,
    agg.SREDNIA_POJEMNOSC,
    agg.RANKING
FROM (
    SELECT 
        m.ID_PRODUCENT,
        s.ID_TYP_NAPEDU,
        s.ID_PAKIET_WYPOSAZENIA,
        AVG(s.POJEMNOSC) AS SREDNIA_POJEMNOSC,
        DENSE_RANK() OVER (ORDER BY AVG(s.POJEMNOSC) DESC) AS RANKING
    FROM WYPOZYCZENIA wyp
    JOIN SKUTER s ON wyp.ID_SKUTER = s.ID
    JOIN MODEL m ON s.ID_MODEL = m.ID
    GROUP BY m.ID_PRODUCENT, s.ID_TYP_NAPEDU, s.ID_PAKIET_WYPOSAZENIA
) agg
JOIN PRODUCENT p ON agg.ID_PRODUCENT = p.ID
JOIN TYP_NAPEDU tn ON agg.ID_TYP_NAPEDU = tn.ID
JOIN PAKIET_WYPOSAZENIA pw ON agg.ID_PAKIET_WYPOSAZENIA = pw.ID
ORDER BY agg.RANKING;



-------------------------------------------------------------------------------------
-- 3. Sprawdzenie, ktory pracownik najczesciej obsluguje wypozyczenia skuterow danego producenta w danej wypozyczalni.

SELECT 
    w.NAZWA AS NAZWA_WYPOZYCZALNI,
    prod.NAZWA AS NAZWA_PRODUCENTA,
    p.IMIE || ' ' || p.NAZWISKO AS PRACOWNIK,
    agg.LICZBA_OBSLUZONYCH_WYPOZYCZEN,
    agg.RANKING
FROM (
    SELECT 
        prac.ID AS ID_PRACOWNIK,
        w.ID AS ID_WYPOZYCZALNIA,
        prod.ID AS ID_PRODUCENT,
        COUNT(*) AS LICZBA_OBSLUZONYCH_WYPOZYCZEN,
        DENSE_RANK() OVER (
            PARTITION BY w.ID 
            ORDER BY COUNT(*) DESC
        ) AS RANKING
    FROM WYPOZYCZENIA wyp
    JOIN PRACOWNIK prac ON wyp.ID_PRACOWNIK = prac.ID
    JOIN WYPOZYCZALNIA w ON prac.ID_WYPOZYCZALNIA = w.ID
    JOIN SKUTER s ON wyp.ID_SKUTER = s.ID
    JOIN MODEL m ON s.ID_MODEL = m.ID
    JOIN PRODUCENT prod ON m.ID_PRODUCENT = prod.ID
    GROUP BY prac.ID, w.ID, prod.ID
) agg
JOIN PRACOWNIK p ON agg.ID_PRACOWNIK = p.ID
JOIN WYPOZYCZALNIA w ON agg.ID_WYPOZYCZALNIA = w.ID
JOIN PRODUCENT prod ON agg.ID_PRODUCENT = prod.ID;


