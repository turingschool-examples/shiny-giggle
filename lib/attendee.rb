class Attendee
    attr_reader :name, :budget, :items
    
    def initialize(info)
        @name = info[:name]
        @budget = info[:budget].gsub(/\D/,'').to_i
    end
end