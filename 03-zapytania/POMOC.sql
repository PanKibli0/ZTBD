SELECT 
        p.id_wypozyczalnia,
        w.id_pracownik AS PRACOWNIK_ID,
        SUM(w.CENA) AS PRZYCHOD
    FROM WYPOZYCZENIA w
join pracownik p ON p.id = w.id_pracownik
    GROUP BY ROLLUP( id_pracownik, p.id_wypozyczalnia)
order by p.id_wypozyczalnia, w.id_pracownik;
