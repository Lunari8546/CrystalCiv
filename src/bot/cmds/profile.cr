require "../utils/data"

struct ProfileCmd < Bot::CmdBase
  self.name = "profile"
  self.desc = "Shows the user's profile."

  def self.execute(args : Array(String)?, payload : Discord::Message)
    if args == [""] || args.nil?
      embed = Discord::Embed.new(
        title: "Profile of #{payload.author.username}##{payload.author.discriminator}",
        description: Data.user_data(payload.author.id).to_s
      )
    else
      pinged = Discord::Snowflake.new(args[0].delete &.in?('[', '"', '<', '@', '!', '>', ']'))

      embed = Discord::Embed.new(
        title: "Profile of #{pinged}",
        description: Data.user_data(pinged).to_s
      )
    end

    CLIENT.create_message(payload.channel_id, "", embed)
  end
end