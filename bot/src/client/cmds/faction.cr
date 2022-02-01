require "../utils/data"

struct FactionCmd < Bot::CmdBase
  self.name = "faction"
  self.desc = "Displays info about all available factions."

  def self.execute(args : Array(String)?, payload : Discord::Message)
    if args == [""] || args.nil?     
      factions = Array(Discord::EmbedField).new
      data = Data.faction_data

      i = 0

      until i >= data.size
        factions.push(Discord::EmbedField.new(
          name: data[i]["name"], value: data[i]["desc"]
        ))

        i = i + 1
      end

      embed = Discord::Embed.new(
        title: "Available Factions:",
        fields: factions
      )
    else
      data = Data.faction_data(args[0])

      embed = Discord::Embed.new(
        title: "Available Factions:",
        fields: [Discord::EmbedField.new(
          name: data[0]["name"], value: data[0]["desc"]
        )]
      )
    end

    CLIENT.create_message(payload.channel_id, "", embed)
  end
end