
	
  #  m.reply "Hello, #{m.user.nick}"
require 'prowl'
require 'cinch'

class Hello
  include Cinch::Plugin


  match /purchase(\S+)/, use_prefix: false, method: :item
  match /inventory/, use_prefix: false, method: :inventory   
  match /weather (\S+)/, use_prefix: false, method: :weather
  match /(.+)/, use_prefix: false, method: :prowl
  match /(.+)/, use_prefix: false, method: :polly
  match /Voca/, use_prefix: false, method: :readvoca
 

  def weather(m, s)
	wt = system('curl wttr.in/#{s}')
	m.reply s
  end


  def readvoca(m)
	line = IO.readlines("voca.txt")
	s = line.count
	m.reply	line[rand(s)].chomp.gsub(/\t/, "  ")
  end

  def prowl(m, s)
     Prowl.add(
  :apikey => "api_key_here",
  :application => "::",
  :event => "::",
  :description => "#{s}"
)
  end


  #def polly(m, s)
  #    system "aws polly synthesize-speech --output-format mp3 --voice-id Seoyeon --text '#{s}' hello#{rand(100)}.mp3"
  #end

end

bot = Cinch::Bot.new do
  configure do |c|
    c.server = "irc_address_here"
	
    c.channels = ["#mychannel"]

    c.password = "my_password_here"

    c.user = "User"
    
    c.plugins.plugins = [Hello]    
  end
end

bot.start
