require "./terrain"

module Game
  struct Core
    def self.match_new(channel_id : Discord::Snowflake)
      fields = Array(Discord::EmbedField).new

      i = 0

      until i >= TerrainSize.names.size
        fields.push(Discord::EmbedField.new(
          name: i.to_s, value: TerrainSize.names[i], inline: true
        ))

        i = i + 1
      end

      embed = Discord::Embed.new(
        title: "Choose a Terrain Size:",
        fields: fields
      )

      CLIENT.create_message(channel_id, "", embed)
    end
  end
end