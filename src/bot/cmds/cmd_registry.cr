module Bot
  struct CmdRegistry
    macro finished
      class_getter cmds : Array(Bot::CmdBase.class) = {% if Bot::CmdBase.subclasses.size > 0 %}{{Bot::CmdBase.subclasses}} {% else %} [] {% end %} of Bot::CmdBase.class
    end

    def self.to_s : String
      String.build do |str|
        str.puts "Available Commands:"

        @@cmds.each do |c|
          str.puts "    #{c.name} - #{c.desc}"
        end
      end
    end

    def self.find(name : String) : (Bot::CmdBase.class | Nil)
      cmd_class = @@cmds.find { |c| c.name == name }

      if cmd_class.nil?
        p "No command with the name '#{name}' has been registered."

        return nil
      end

      cmd_class
    end
  end
end