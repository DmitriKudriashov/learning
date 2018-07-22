=begin
5. Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя).
	Найти порядковый номер даты, начиная отсчет с начала года. Учесть, что год может быть високосным.

Год високосный, если он делится на четыре без остатка, но если он делится на 100 без остатка, это не високосный год.
Однако, если он делится без остатка на 400, это високосный год.
Таким образом, 2000 г. является особым високосным годом, который бывает лишь раз в 400 лет.
=end
print "Введите день месяца: "
day = gets.to_i
print "Введите номер месяца: "
month = gets.to_i
print "Введите год: "
year = gets.to_i
days_by_monthes = [ 31, 28, 31, 30, 31, 30, 31, 31, 30 , 31, 30, 31 ]
days_by_monthes[1] = 29 if ( year % 4 == 0 && year % 100 != 0 ) || year % 400 == 0
(1...month).each { |month_number| day += days_by_monthes[month_number] }
puts "Ваша дата в году #{year} имеет порядковый номер #{day} "
