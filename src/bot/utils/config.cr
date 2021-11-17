require "dotenv"

struct Config
  def self.load
    Dotenv.load
    
    raise "Error: No Prefix found." if ENV["PREFIX"].nil?
    raise "Error: No Token found." if ENV["TOKEN"].nil?
    raise "Error: No Client ID found." if ENV["CLIENT_ID"].nil?
  end
end