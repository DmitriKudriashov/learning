# 2. Заполнить массив числами от 10 до 100 с шагом 5
numbers = []
(10..100).step(5).each { |x| numbers << x }
puts numbers
