puts "Идеальный вес."
your_height = 0 
print "Ваше имя : " 
your_name = gets.chomp.downcase.capitalize

unless your_name.empty?   ##  а чем же лучше эта запись, а не эта: if you_name != ""  ? по колличеству символов новый вариант длиннее .
	print "Ваш рост: "
	your_height = gets.to_f
end

if your_name.empty? || your_height <= 0 ## да.. так и для дебилов пойдет.. 
	puts " НЕ КОРРЕКТНО ВВЕЛИ ДАННЫЕ !!! "
	abort
end

	ideal_weigth = your_height -  110 # получается для роста 111 - идеальный вес должен быть 1 кг !!! БРЕД !!! ))) или мумия карлика 
	print "#{your_name} "
if ideal_weigth <= 0 
 	puts " Ваш вес #{ideal_weigth} уже оптимальный !!! "
else
  puts " Ваш идеальный вес = #{ideal_weigth} !!! "
end
