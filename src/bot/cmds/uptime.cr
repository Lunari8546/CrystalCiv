struct UptimeCmd < Bot::CmdBase
  self.name = "uptime"
  self.desc = "Display the bot's uptime."

  def self.execute(args : Array(String)?, payload : Discord::Message)
    uptime = Time.monotonic - START_TIME

    embed = Discord::Embed.new(
      title: "Bot Uptime:",
      description: "#{uptime.days} Days, #{uptime.hours} Hours and #{uptime.minutes} Minutes #{uptime.seconds} Seconds."
    )

    CLIENT.create_message(payload.channel_id, "", embed)
  end
end