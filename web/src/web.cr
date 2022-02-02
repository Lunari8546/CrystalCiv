require "kemal"

get "/" do
  render "src/views/landing.ecr"
end

Kemal.run