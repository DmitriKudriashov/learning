#3. Заполнить массив числами фибоначчи до 100
	fibbonacci = [ 0, 1, 1 ]
  element = 2
	while element < 100
	  fibbonacci << element
  	element = fibbonacci[-1] + fibbonacci[-2]
	end
	puts fibbonacci
