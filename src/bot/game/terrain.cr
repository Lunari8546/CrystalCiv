enum TerrainSize
  Small
  Medium
  Large
end

module Game
  struct Terrain
    def initialize(size : TerrainSize)
      puts size
    end
  end
end