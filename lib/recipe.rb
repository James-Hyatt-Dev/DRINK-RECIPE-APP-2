class Recipe

    attr_accessor :glass, :instructions, :ingredients, :amounts, :name

    @@all_recipes = []

    def initialize(hash)
        hash.each do |k,v|
            self.send("#{k}=", "#{v}") if self.respond_to?("#{k}=")
        end
        @@all_recipes << self
    end

    def self.all_recipes
        @@all_recipes
    end
end
