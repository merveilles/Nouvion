class Thought

    attr_accessor :owner
    attr_accessor :key
    attr_accessor :relation
    attr_accessor :value

end

class Memory

    def collectThoughts(data)
        thoughts = []
        relationExtractor = /\{([^\)]+)\}/

        data.each do |row|
            thought = Thought.new 

            thought.owner = row[0]
            thought.relation = row[1].scan(relationExtractor).to_s
            thought.value = row[2]
            thought.key = row[1].sub("{"+thought.relation+"}","")

            thoughts.push(thought)
        end

        return thoughts
    end

    def loadRelated(key, relation, owner = nil)
        data = load("{#{relation}}#{key}")

        unless owner.nil?
            data = data.select { |row| row[0] == owner }
        end        

        data = collectThoughts(data)

        if data.size() == 0 then return nil end
        return data
    end

    def loadAllRelated(relation, owner = nil)
        return loadRelated('', relation, owner)
    end

    def loadAttribute(key, attribute)
        return loadRelated(key, attribute, 'ludivine')
    end        

    def loadAllAttributes(attribute)
        return loadAllRelated(attribute, 'ludivine')
    end    

    def loadRelatedValue(key, relation, owner = nil)
        data = loadRelated(key, relation, owner)

        unless data.nil? then return data.value end
        return nil
    end

    def loadAttributeValue(key, attribute)
        return loadRelatedValue(key, attribute, 'ludivine')
    end    

    def saveRelated(owner, key, relation, value)
        return save(owner, "{#{relation}}#{key}", value)
    end

    def saveAttribute(key, attribute, value)
        return saveRelated("ludivine", key, attribute, value)
    end

    def loadOrCreate(owner, key, defaultValue)
        data = load(key).select { |row| row[0] == owner && row[1] == key }

        if data.size() == 0 
            data = [owner, key, defaultValue]
            save(data.flatten)
        end

        return collectThoughts(data)
    end

end
