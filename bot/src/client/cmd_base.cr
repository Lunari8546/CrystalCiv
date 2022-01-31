module Bot
  abstract struct CmdBase
    class_property name : String = ""
    class_property desc : String = ""

    macro inherited
      macro finished
        \{% begin %}
          \{% raise "#{@type.name} must implement a `self.execute` method." unless @type.class.methods.any? { |m| m.name.stringify == "execute"} %}
          \{% for method in @type.class.methods %}
            \{% if method.name.stringify == "execute" %}
  
              def self.to_s : String
                String.build do |str|
                  str.puts "Command"
                  str.puts "\t#{@@name} - #{@@desc}"
                end
              end

            \{% end %}
          \{% end %}
        \{% end %}
      end
    end
  end
end