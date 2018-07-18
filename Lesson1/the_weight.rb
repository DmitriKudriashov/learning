puts "Идеальный вес."
you_height = 0 

print "ваше имя : " 
you_name = gets.chomp.downcase.capitalize

if you_name != ""
	print "Ваш рост: "
	you_height = gets.chomp.to_i
end

if you_name != "" and you_height != 0 
	ideal_weigth = you_height -  110 # получается для роста 111 - идеальный вес должен быть 1 кг !!! БРЕД !!! )))
	print "#{you_name}"+ " ! "
 if ideal_weigth <= 0 
 	puts " Ваш вес " + "#{ideal_weigth}"+ " уже оптимальный !!!"
 else
    puts " Ваш идеальный вес = " + "#{ideal_weigth}" + " !!! "
 end

else
	puts " НЕ КОРРЕКТНО ВВЕЛИ ДАННЫЕ !!! "
end

