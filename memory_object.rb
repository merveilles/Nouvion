class MemoryObject
    
    attr_reader :name
    
    # public instance methods

    def initialize(name, memory)
        @name = name
        @memory = memory
        
        @memory.connect()
    end
    
    def load_from_memory(attribute, default_value = nil)
        thoughts = @memory.load("#{attribute} ")

        thoughts.each do |known|
            if known[0] != "ludivine" then next end # ludivine hosts all attributes
            if known[1] != "#{attribute} #{@name}" then next end

            return known[2]
        end
        
        @memory.save("ludivine", "#{@name} #{@attribute}", default_value.to_s) # add missing attributes
        return default_value.to_s
    end

    def save_to_memory(attribute, value)
        @memory.save("ludivine","#{attribute} #{@name}",value.to_s)
    end

    # public class methods

    def self.get_all_of_type(attribute)
        listMemories= []
        @memory.connect
        thoughts = @memory.load("#{attribute}" + " ")
        thoughts.each do |known|
            if known[0] != "ludivine" then next end
            if known[1].split(" ")[0] != "#{attribute}" then next end
            listMemories.push(MemoryObject.new(known[1].split(" ")[1],@memory))
        end
        return(listMemories)
    end    

    def self.get_all_values_of_type(attribute)
        listValues= []
        @memory.connect
        thoughts = @memory.load("#{attribute}" + " ")
        thoughts.each do |known|
            if known[0] != "ludivine" then next end
            if known[1].split(" ")[0] != "#{attribute}" then next end
            listValues.push([known[1].split(" ")[1],known[2].to_s])
        end
        return(listValues)
    end    

end
