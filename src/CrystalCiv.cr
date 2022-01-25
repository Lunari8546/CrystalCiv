require "discordcr"

require "./bot/**"

Config.load

CLIENT = Discord::Client.new(
  "Bot #{ENV["TOKEN"]}",
  ENV["CLIENT_ID"].to_u64
)

START_TIME = Time.monotonic

cmdHandler = CmdHandler.new

CLIENT.on_message_create do |payload|
  if payload.content.starts_with? ENV["PREFIX"]
    if !Data.user_exists?(payload.author.id)
      Data.user_add(payload.author.id)
    end

    cmdHandler.call(payload)
  end
end

CLIENT.run