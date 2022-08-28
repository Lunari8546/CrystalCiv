struct AboutCmd < Bot::CmdBase
  self.name = "about"
  self.desc = "Displays info about the bot."

  def self.execute(args : Array(String)?, payload : Discord::Message)
    if args == [""] || args.nil?
      field = Discord::EmbedField
      
      uptime = Time.monotonic - START_TIME
      uptime_str = "#{uptime.days} Days, #{uptime.hours} Hours and #{uptime.minutes} Minutes #{uptime.seconds} Seconds."

      embed = Discord::Embed.new(
        title: "About the Bot:",
        description: "A civilization-building strategy game with fantasy aspects in Discord.",
        fields: [
          field.new(name: "Version", value: "[Offical] Infdev", inline: true),
          field.new(name: "Uptime", value: uptime_str, inline: true),
          field.new(name: "Developer(s)", value: "Lunari8546 (Ariz)")
        ]
      )
    end

    CLIENT.create_message(payload.channel_id, "", embed)
  end
end