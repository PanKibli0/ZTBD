Select s.*, p.nazwa, m.nazwa,tp.nazwa from skuter s
join model m on s.id_model = m.id
join producent p on m.id_producent = p.id 
join typ_napedu tp on s.id_typ_napedu = tp.id
join kolor k on s.id_kolor = k.id
where k.nazwa = 'Czerwony'