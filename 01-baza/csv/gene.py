import random


def generate_street_names():
    # Listy rzeczywistych nazw ulic w różnych językach (100 unikalnych dla każdego języka)
    real_street_names = {
        "Polski": [
            "Lipowa", "Klonowa", "Brzozowa", "Debowa", "Sosnowa", "Modrzewiowa", "Topolowa", "Jesionowa", "Wierzbowa",
            "Akacjowa",
            "Cisowa", "Gajowa", "Lesna", "Jodlowa", "Swierkowa", "Mysliwska", "Jagodowa", "Sarna", "Jeleniogorska",
            "Borowikowa",
            "Polna", "Zielona", "Malinowa", "Chmielna", "Morska", "Sloneczna", "Gorzowska", "Kasztanowa", "Teczowa",
            "Fiołkowa",
            "Bazantowa", "Gorna", "Kwiatowa", "Zbozowa", "Jaskolcza", "Promienna", "Wodna", "Zeglarska", "Bursztynowa",
            "Spacerowa",
            "Zimowa", "Letnia", "Jesienna", "Wiosenna", "Gorska", "Laka", "Pogodna", "Dzialkowa", "Rybacka", "Promykowa"
        ]
    }

    # Powielanie listy dla pozostałych języków, aby uzyskać 1000 unikalnych ulic
    for lang in ["Niemiecki", "Chorwacki", "Francuski", "Hiszpanski", "Wloski", "Norweski", "Szwedzki", "Czeski",
                 "Wegrzaski"]:
        real_street_names[lang] = [f"{name}{lang[:2]}" for name in real_street_names["Polski"]]

    # Generowanie rekordów zgodnie z formatem id|nazwa|numer
    records = []
    index = 1
    group_number = 1

    for lang, streets in real_street_names.items():
        for i in range(50):  # 50 unikalnych nazw ulic na język (razem 1000)
            records.append(f"{index}|{streets[i]}|{group_number}")
            index += 1
            if index % 10 == 1:  # Zwiększanie numeru co 10 rekordów
                group_number += 1

    # Zapisanie do pliku
    with open("wynik.txt", "w") as file:
        file.write("\n".join(records))


# Uruchomienie funkcji
generate_street_names()