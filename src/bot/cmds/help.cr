struct HelpCmd < Bot::CmdBase
  self.name = "help"
  self.desc = "Display all commands and its details."

  def self.execute(args : Array(String)?, payload : Discord::Message)
    if args == [""] || args.nil?
      help_block = String.build do |str|
        Bot::CmdRegistry.cmds.each do |c|
          str.puts "#{c.name} - #{c.desc}"
        end
      end

      embed = Discord::Embed.new(title: "Available Commands", description: help_block)
    else
      found_cmd = Bot::CmdRegistry.find(args[0])

      if found_cmd.nil?
        Discord::Embed.new(description: "Help for '#{args[0]}' command not found")
      else
        help_block = String.build do |str|
          str.puts "#{found_cmd.desc}"
        end

        embed = Discord::Embed.new(
          title: "#{found_cmd.name.capitalize} Command",
          description: help_block
        )
      end
    end

    CLIENT.create_message(payload.channel_id, "", embed)
  end
end