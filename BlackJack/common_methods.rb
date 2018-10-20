# common_methods.rb
require 'io/console'

module CommonMethods

  def listing_block(objects)
    indx = 0
    objects.each do |t|
      indx += 1
      yield(indx, t)
    end
  end

  def msg_return
    "( <ESC> - Return )"
  end

  def gets_whith_esc
    name = ''
    char = ''
    while 1 do
      char = STDIN.getch
      return ''  if char.ord == 27
      return name if char.ord == 13
      print char
      name = name + char
    end
  end
end
