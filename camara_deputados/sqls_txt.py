import glob

with open("data/camara_dados.txt", "w", encoding="utf-8") as txtfile:
	for filename in glob.glob('data/*.sql'):
		f = open(filename, "r", encoding="utf-8")
		for line in f:
			txtfile.write(line);
txtfile.close()