require "../utils/data"

struct FactionCmd < Bot::CmdBase
  self.name = "faction"
  self.desc = "Displays info about all available factions."

  def self.execute(args : Array(String)?, payload : Discord::Message)
    if args == [""] || args.nil?
      field = Discord::EmbedField

      embed = Discord::Embed.new(
        title: "Available Factions:"
      )
    end

    CLIENT.create_message(payload.channel_id, "", embed)
  end
end