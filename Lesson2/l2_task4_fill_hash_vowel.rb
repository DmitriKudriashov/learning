# . Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).
#alphabet = "abcdefghijklmnohqrstuvwxyz"

  vowels = [ "a", "e" , "i", "o", "u" ]
  alphabet = ("a".."z").to_a
  vowel_positions = {}
  vowels.each { |letter| vowel_positions[letter] = alphabet.index(letter) + 1 }
  puts vowel_positions
