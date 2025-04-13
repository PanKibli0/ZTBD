-- FUNKCJE RANKINGOWE

-- Sprawdzenie, kt�re modele skuter�w i typy nap�du ciesz� si� najwi�kszym zainteresowaniem w poszczeg�lnych wypo�yczalniach, z rankingiem wed�ug liczby wypo�ycze�.

SPOOL wynik1.txt

SELECT 
    wy.NAZWA AS WYPOZYCZALNIA,
    m.NAZWA AS MODEL,
    t.NAZWA AS TYP_NAPEDU,
    COUNT(wyp.ID_SKUTER) AS LICZBA_WYPOZYCZEN,
    RANK() OVER (PARTITION BY wy.NAZWA ORDER BY COUNT(wyp.ID_SKUTER) DESC) AS RANKING
FROM WYPOZYCZENIA wyp
JOIN SKUTER s ON wyp.ID_SKUTER = s.ID
JOIN MODEL m ON s.ID_MODEL = m.ID
JOIN TYP_NAPEDU t ON s.ID_TYP_NAPEDU = t.ID
JOIN WYPOZYCZALNIA wy ON s.ID_WYPOZYCZALNIA = wy.ID
GROUP BY wy.NAZWA, m.NAZWA, t.NAZWA
ORDER BY wy.NAZWA, RANKING;

SPOOL OFF;