require "json"

struct Data
  def self.user_add(user_id : Discord::Snowflake)
    json = File.new("src/data/users/#{user_id}.json", "w")

    obj = JSON.build do |json|
      json.object do
        json.field "stats" do
          json.object do
            json.field "games_played", 0
            json.field "games_won", 0
            json.field "games_lost", 0
          end
        end
      end
    end

    File.write(json.path, obj)

    json.close
  end

  def self.user_data(user_id : Discord::Snowflake)
    parsed_json = File.open("src/data/users/#{user_id}.json") do |file|
      JSON.parse(file)
    end

    return parsed_json
  end

  def self.user_exists?(user_id : Discord::Snowflake)
    return File.exists?("src/data/users/#{user_id}.json")
  end

  def self.faction_data(name : String = "")
    data = Array(Hash(String, String)).new

    if name.blank?
      files = Dir.children("src/data/factions/")
    
      i = 0

      until i >= files.size
        path = "src/data/factions/#{files[i]}"

        if !File.file?(path) || File.extname(path) != ".json"
          files.delete_at(i)
        else
          parsed = File.open(path) do |file|
            JSON.parse(file)
          end

          data.push(
            {"name" => parsed["name"].to_s, "desc" => parsed["desc"].to_s}
          )

          i = i + 1
        end
      end
    else
      name = name.downcase

      if File.exists?("src/data/factions/#{name}.json")
        parsed = File.open("src/data/factions/#{name}.json") do |file|
          JSON.parse(file)
        end

        data.push(
          {"name" => parsed["name"].to_s, "desc" => parsed["desc"].to_s}
        )
      end
    end

    return data
  end
end