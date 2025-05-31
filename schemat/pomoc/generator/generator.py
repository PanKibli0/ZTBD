import random
import datetime

def generate_records(file_name, num_records):
    start_date = datetime.date(2003, 1, 1)
    with open(file_name, "w") as file:
        for _ in range(num_records):
            num1 = random.randint(1, 200)
            num2 = random.randint(1, 10)
            num3 = random.randint(1, 600)
            num4 = random.randint(1, 100)
            price = round(random.uniform(30, 700), 2)
            date1 = start_date + datetime.timedelta(days=random.randint(0, 365 * 20))
            date2 = date1 + datetime.timedelta(days=7)
            
            record = f"{num1}|{num2}|{num3}|{num4}|{price}|{date1}|{date2}"
            file.write(record + "\n")
    print(f"Wygenerowano {num_records} rekordów do pliku {file_name}")

if __name__ == "__main__":
    num_records = int(input("Podaj liczbę rekordów do wygenerowania: "))
    generate_records("output.txt", num_records)
