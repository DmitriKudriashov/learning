=begin
	
6. Сумма покупок. Пользователь вводит поочередно название товара, цену за единицу и кол-во купленного товара (может быть нецелым числом). 
Пользователь может ввести произвольное кол-во товаров до тех пор, пока не введет "стоп" в качестве названия товара. 
На основе введенных данных требуетеся:
Заполнить и вывести на экран хеш, ключами которого являются названия товаров, а значением - вложенный хеш, 
содержащий цену за единицу товара и кол-во купленного товара. Также вывести итоговую сумму за каждый товар.
Вычислить и вывести на экран итоговую сумму всех покупок в "корзине".

=end
	
  card = Hash.new
 	loop do
		 print "Название товара или 'СТОП' для прекращения ввода: "
		 product = gets.chomp.capitalize!
		 break if product.upcase == "СТОП" || product.empty?

		 details = Hash.new

		 print "кол-во товара: "
		 details[:quantity] = gets.to_f
     print "цена за единицу: "
		 details[:price] = gets.to_f

		 card[product] = details
	end


  grand_total = 0
 	card.keys.each do |product|	
 		p_quantity   = card[product][:quantity]
 		p_price      = card[product][:price] 
 		total_price  = p_price * p_quantity

		puts product  + " : колличество: #{p_quantity}  цена за единицу: #{p_price} сумма: #{total_price}"
 
    grand_total += total_price

  end
  puts " ИТОГО:  #{grand_total} "
