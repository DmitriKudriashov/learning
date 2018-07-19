puts "Прямоугольный ли, треугольник ?"
print "сторона 1я:  a = "
a = gets.to_f

print "сторона 2я:  b = "
b = gets.to_f
print "сторона 3я:  c = "
c = gets.to_f

if a * b * c == 0 
  puts " ))  ЭТО НЕ ТРЕУГОЛЬНИК ! "
  abort
end


sides = [a, b, c].sort!
if sides[0]**2 + sides[1]**2 == sides[2]**2 
  puts "ЭТОТ ТРЕУГОЛЬНИК ПРЯМОУГОЛЬНЫЙ !!! "
else 
  puts "ЭТОТ ТРЕУГОЛЬНИК НЕ ПРЯМОУГОЛЬНЫЙ !!!"
end
