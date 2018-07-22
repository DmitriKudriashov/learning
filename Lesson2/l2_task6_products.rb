=begin

6. Сумма покупок. Пользователь вводит поочередно название товара, цену за единицу и кол-во купленного товара (может быть нецелым числом).
Пользователь может ввести произвольное кол-во товаров до тех пор, пока не введет "стоп" в качестве названия товара.
На основе введенных данных требуетеся:
Заполнить и вывести на экран хеш, ключами которого являются названия товаров, а значением - вложенный хеш,
содержащий цену за единицу товара и кол-во купленного товара. Также вывести итоговую сумму за каждый товар.
Вычислить и вывести на экран итоговую сумму всех покупок в "корзине".

=end

  card = {}
 	loop do
		 print "Название товара или 'СТОП' для прекращения ввода: "
		 product = gets.chomp.capitalize!
		 break if product.nil? || product.upcase == "СТОП"
		 details = {}
		 print "кол-во товара: "
		 details[:quantity] = gets.to_f
     print "цена за единицу: "
		 details[:price] = gets.to_f
		 card[product] = details
	end
  total = 0
 	card.keys.each do |product|
 		quantity = card[product][:quantity]
 		price = card[product][:price]
 		cost = price * quantity
		puts " #{product}:  колличество: #{quantity}  цена за единицу: #{price} сумма: #{cost}"
    total += cost
  end
  puts " ИТОГО:  #{total} "
