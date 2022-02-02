module Bot
  struct CmdRegistry
    macro finished
      class_getter cmds : Array(Bot::CmdBase.class) = {% if Bot::CmdBase.subclasses.size > 0 %}{{Bot::CmdBase.subclasses}} {% else %} [] {% end %} of Bot::CmdBase.class
    end

    def self.to_s : String
      String.build do |str|
        str.puts "Registered Commands:"

        @@cmds.each do |cmd|
          str.puts "    #{cmd.name} - #{cmd.desc}"
        end
      end
    end

    def self.find(name : String) : (Bot::CmdBase.class | Nil)
      cmd_class = @@cmds.find { |cmd| cmd.name == name }

      if cmd_class.nil?
        return nil
      end

      cmd_class
    end
  end
end