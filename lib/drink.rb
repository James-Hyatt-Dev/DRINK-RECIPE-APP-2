class Drink 

    attr_accessor :name, :id, :liquor

    @@all_drinks = []

    def initialize(hash)
        hash.each do |k,v|
            self.send("#{k}=", v) if self. respond_to?("#{k}=")
        end

        @@all_drinks << self
    end

    def self.all_drinks
        @@all_drinks
    end
end
