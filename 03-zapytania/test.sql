SELECT 
        w.ID_wypozyczalni as wypo_id,
        w.ID_PRACOWNIK AS PRACOWNIK_ID,
        SUM(w.CENA) AS PRZYCHOD
    FROM H_WYPOZYCZENIA w
    GROUP BY ROLLUP(w.ID_PRACOWNIK,  w.ID_wypozyczalnia)

order by w.ID_PRACOWNIK;