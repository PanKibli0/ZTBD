-- Sprawdzenie, które modele skuterów i typy napêdu ciesz¹ siê najwiêkszym zainteresowaniem w poszczególnych wypo¿yczalniach, z rankingiem wed³ug liczby wypo¿yczeñ.


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