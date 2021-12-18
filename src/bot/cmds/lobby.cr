require "json"

require "../utils/data"

struct LobbyCmd < Bot::CmdBase
  self.name = "lobby"
  self.desc = "Creates a lobby for a new match."

  def self.execute(args : Array(String)?, payload : Discord::Message)
    if args == [""] || args.nil?
      channel_name = "Lobby"

      CLIENT.create_guild_channel(
        guild_id: Discord::Snowflake.new(channel_name),
        name: channel_name,
        type: Discord::ChannelType.new(0_u8),
        topic: nil,
        bitrate: nil,
        user_limit: nil,
        rate_limit_per_user: nil,
        position: nil,
        parent_id: nil,
        nsfw: false
      )
    end
  end
end