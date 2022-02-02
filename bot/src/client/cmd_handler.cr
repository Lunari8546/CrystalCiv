require "colorize"

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
      return
    end

    infomsg = "Running '#{found_cmd.name}' from #{payload.author.username}##{payload.author.discriminator}."

    puts infomsg.colorize.fore(:green)

    begin
      found_cmd.execute(args, payload)
    rescue exception
      errmsg = "Failed handling #{found_cmd.name}. #{exception.message}"

      puts errmsg.colorize.fore(:red).back(:black)
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