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
    return true if File.exists?("src/data/users/#{user_id}.json")
  end

  def self.faction_data_all
    factions = Dir.children("src/data/factions/")

    return factions
  end
end