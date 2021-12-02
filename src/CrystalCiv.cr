require "discordcr"

require "./bot/**"

Config.load

client = Discord::Client.new(
  "Bot #{ENV["TOKEN"]}",
  ENV["CLIENT_ID"].to_u64
)

cmdHandler = CmdHandler.new

client.on_message_create do |payload|
  if payload.content.starts_with? ENV["PREFIX"]
    cmdHandler.call(payload, client)

    if !Data.user_exists?(payload.author.id)
      Data.user_add(payload.author.id)
    end
  end
end

client.run