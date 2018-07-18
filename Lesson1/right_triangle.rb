puts "Прямоугольный ли, треугольник ?"
print "сторона 1я:  a = "
a = gets.chomp.to_i

print "сторона 2я:  b = "
b = gets.chomp.to_i
print "сторона 3я:  c = "
c = gets.chomp.to_i

if a == 0 or b == 0 or c == 0 
	puts " ))  ЭТО НЕ ТРЕУГОЛЬНИК ! "
else
	if (a*a + b*b == c*c) or (a*a == b*b + c*c)  or (a*a + c*c == b*b) 
		puts "ЭТОТ ТРЕУГОЛЬНИК ПРЯМОУГОЛЬНЫЙ !!! "
	else 
		puts "ЭТОТ ТРЕУГОЛЬНИК НЕ ПРЯМОУГОЛЬНЫЙ !!!"
	end
	

end

    