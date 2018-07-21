# . Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).
#alphabet = "abcdefghijklmnohqrstuvwxyz"

vowels = ["a", "e" , "i", "o", "u" ]
alphabet = ("a".."z").to_a
hash_vowels = Hash.new
vowels.each { |letter|   hash_vowels[letter]  = alphabet.index(letter)+1 }
puts hash_vowels
