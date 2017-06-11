import unicodecsv as csv
import json

with open('../dados/senador.json', encoding="utf8") as data_file:
    senadores = json.load(data_file)
    with open('../dados/senador.csv', 'wb') as csvfile:
        fieldnames = ["id","nomeParlamentar","nomeCompleto","cargo","partido","mandato","sexo","uf","telefone","email","nascimento","fotoURL","gastoTotal","gastoPorDia",]
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()
        for senador in senadores:
                i = {}
                i["id"] = senador["id"]
                i["nomeParlamentar"] = senador["nomeParlamentar"]
                i["nomeCompleto"] = senador["nomeCompleto"]
                i["cargo"] = senador["cargo"]
                i["partido"] = senador["partido"]
                i["mandato"] = senador["mandato"]
                i["sexo"] = senador["sexo"]
                i["uf"] = senador["uf"]
                i["telefone"] = senador["telefone"]
                i["email"] = senador["email"]
                i["nascimento"] = senador["nascimento"]
                i["fotoURL"] = senador["fotoURL"]
                i["gastoTotal"] = senador["gastoTotal"]
                i["gastoPorDia"] = senador["gastoPorDia"]
                writer.writerow(i)
