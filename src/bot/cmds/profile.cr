require "../utils/data"

struct ProfileCmd < Bot::CmdBase
  self.name = "profile"
  self.desc = "Shows the user's profile."

  def self.execute(args : Array(String)?, payload : Discord::Message)
    field = Discord::EmbedField

    if args == [""] || args.nil?
      data = Data.user_data(payload.author.id)

      embed = Discord::Embed.new(
        title: "Profile of #{payload.author.username}##{payload.author.discriminator}",
        fields: [
          field.new(
            name: "Games Played:", value: data["stats"]["games_played"].to_s, inline: true
          ),
          field.new(
            name: "Games Won:", value: data["stats"]["games_won"].to_s, inline: true
          ),
          field.new(
            name: "Games Lost:", value: data["stats"]["games_lost"].to_s, inline: true
          )
        ]
      )
    else
      pinged = Discord::Snowflake.new(args[0].delete &.in?('[', '"', '<', '@', '!', '>', ']'))

      if Data.user_exists?(pinged)
        data = Data.user_data(pinged)

        embed = Discord::Embed.new(
          title: "Profile of #{pinged}",
          fields: [
            field.new(
              name: "Games Played:", value: data["stats"]["games_played"].to_s, inline: true
            ),
            field.new(
              name: "Games Won:", value: data["stats"]["games_won"].to_s, inline: true
            ),
            field.new(
              name: "Games Lost:", value: data["stats"]["games_lost"].to_s, inline: true
            )
          ]
        )
      else
        embed = Discord::Embed.new(
          title: "Profile of #{pinged}",
          description: "No data found."
        )
      end
    end

    CLIENT.create_message(payload.channel_id, "", embed)
  end
end