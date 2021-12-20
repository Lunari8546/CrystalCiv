require "./*"
require "./utils/data"

class CmdHandler
  def initialize
    puts Bot::CmdRegistry.to_s
  end

  def call(payload : Discord::Message)
    cmd_name, args = parse_cmd(payload.content)
    return if cmd_name.nil?

    found_cmd = Bot::CmdRegistry.find(cmd_name)

    if found_cmd.nil?
      puts "'#{cmd_name}' command not found."
      
      return
    end

    puts "Running '#{found_cmd.name}' from #{payload.author.username}##{payload.author.discriminator}."

    begin
      found_cmd.execute(args, payload)
    rescue exception
      puts "Failed handling #{found_cmd.name}. #{exception.message}"
    end
  end

  private def parse_cmd(msg_content : String)
    match = /^.([\w+]+)(.*)/.match(msg_content)

    if match
      cmd_name = match[1].downcase

      if match[2]?
        args = match[2].strip.downcase.split(' ')
      else
        args = nil
      end
      
      return cmd_name, args
    else
      return nil, nil
    end
  end
end