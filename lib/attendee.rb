class Attendee
    attr_reader :name, :budget, :items
    
    def initialize(info)
        @name = info[:name]
        @budget = info[:budget].delete('$').to_i #need to take off momey symbol and needs to be a integer
    end
end