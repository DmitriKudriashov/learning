# user.rb
class User < Gamer
 include GlobalValues

  validate :name, :presence
  validate :name, :format, NAME_FORMAT

  def initialize(options = {})
    super(name: options[:name], type: USER)
  end

  # not using . reserved!
  # def input_name
  #   puts 'YOU NAME:'
  #   name_user = gets_whith_esc.chomp.strip
  # end

end
