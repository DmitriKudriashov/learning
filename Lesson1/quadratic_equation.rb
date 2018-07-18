puts " Квадратное уравнение !!!"
puts " Вы должны ввести 3 коэффициента: a, b и с "
print 'a = '
a = gets.chomp.to_i
     
print 'b = '
b = gets.chomp.to_i

print 'c = '
c = gets.chomp.to_i
if a == 0 and b !=0 
	puts "это случай ЛИНЕЙНОГО УРАВНЕНИЯ !!!"
     x = -c*1.0/b
    puts "1 корень !  x = "+"#{x}"
else 

	d = b**2 - 4*a*c
	puts "Дискриминант d = " + "#{d}" 
	if d<0 
		puts "Корней нет"	
	elsif d == 0  
    	x = - b/2.0/a 
    	puts "случай d  = 0 :   корень = "+"#{x}"
	else
		sqrt_d = Math.sqrt(d)
    	x1 = (-b- sqrt_d)/2.0/a 
    	x2 = (-b+ sqrt_d)/2.0/a 
    	puts "2 корня: x1 =  " +"#{x1}" " ; x2 = "+"#{x2}" 	
    end	
end



		
