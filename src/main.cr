require "dotenv"
require "discordcr"

require "./utils/*"

ENVHASH = Dotenv.load

prefix = "cc"

client = Discord::Client.new(
  token: "Bot #{ENVHASH["TOKEN"]}",
  client_id: ENVHASH["CLIENT_ID"].to_u64
)

client.on_message_create do |msg|
  if msg.content.starts_with?(prefix)
    args = msg.content.delete_at(0..1).split(/ +/)

    i = 0

    until i >= args.size
      if args[i].empty?
        args.delete_at(i)
      end

      i = i + 1
    end

    puts args
  end
end

client.run