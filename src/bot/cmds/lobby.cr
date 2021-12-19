require "json"

require "../utils/data"

struct LobbyCmd < Bot::CmdBase # WIP
  self.name = "lobby"
  self.desc = "Creates a lobby for a new match."

  def self.execute(args : Array(String)?, payload : Discord::Message)
    if args == [""] || args.nil?
      guild_id = payload.guild_id

      if guild_id
        CLIENT.create_guild_channel(
          guild_id: guild_id,
          name: "Lobby",
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
end