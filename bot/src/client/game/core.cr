require "./terrain"

module Game
  struct Core
    def self.match_new(channel_id : Discord::Snowflake)
      choices = Array(Discord::EmbedField).new

      i = 0

      until i >= TerrainSize.names.size
        choices.push(Discord::EmbedField.new(
          name: TerrainSize.names[i], value: i.to_s, inline: true
        ))

        i = i + 1
      end

      embed = Discord::Embed.new(
        title: "Choose the Terrain Size: (Input the corresponding number.)",
        fields: choices
      )

      CLIENT.create_message(channel_id, "", embed)
    end
  end
end