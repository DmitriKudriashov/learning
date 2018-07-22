 # 1. Сделать хеш, содеращий месяцы и количество дней в месяце. В цикле выводить те месяцы, у которых количество дней ровно 30
 #monthes = {"January" => 31, "February" => 28, "March" => 31, "April" => 30, "May" => 31, "June" => 30, "July" => 31, "August" => 31,
 # "September" => 30 , "October" => 31, "November" => 30, "December" => 31 }

monthes = {
  january: 31,
  february: 28,
  march: 31,
  april: 30,
  may: 31,
  june: 30,
	july: 31,
	august: 31,
  september: 30,
  october: 31,
  november: 30,
  december: 31
}
monthes.each { |month , days| puts month if days == 30 }
