class Attendee
    attr_reader :name, :budget, :items
    
    def initialize(info)
        @name = info[:name]
        @budget = info[:budget].split("$")[1].to_i
    end

    def spend(cost)
        @budget -= cost
    end
end