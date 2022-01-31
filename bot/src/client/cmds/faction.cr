require "../utils/data"

struct FactionCmd < Bot::CmdBase
  self.name = "faction"
  self.desc = "Displays info about all available factions."

  def self.execute(args : Array(String)?, payload : Discord::Message)
    if args == [""] || args.nil?     
      factions = Array(Discord::EmbedField).new
      data = Data.faction_data_all

      i = 0

      until i >= data.size
        factions.push(Discord::EmbedField.new(
          name: data[i], value: data[i]
        ))

        i = i + 1
      end

      embed = Discord::Embed.new(
        title: "Available Factions:",
        fields: factions
      )
    end

    CLIENT.create_message(payload.channel_id, "", embed)
  end
end