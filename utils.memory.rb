class Memory

    def transformData(data)
        data.map { |row|
            {
                transformed = {
                    "owner" => row[0],
                    "relation" => row[1].scan(/\{([^\)]+)\}/).to_s,
                    "value" => row[2]
                }
                transformed.key = row[1].sub("{"+transformed.relation+"}","")
                return transformed
            }
        }
    end

    def loadRelated(key, relation, owner = nil)
        data = load("{#{relation}}#{key}")

        unless owner.nil?
            data = data.select { |row| row[0] == owner }
        end        

        data = transformData(data)

        if data.size() == 0 then return nil end
        return data
    end

    def loadAllRelated(relation, owner = nil)
        loadRelated('', relation, owner)
    end

    def loadAttribute(key, attribute)
        loadRelated(key, attribute, 'ludivine')
    end        

    def loadAllAttributes(attribute)
        loadAllRelated(attribute, 'ludivine')
    end    

    def loadRelatedValue(key, relation, owner = nil)
        data = loadRelated(key, relation, owner)

        unless data.nil? then return data.value end
        return nil
    end

    def saveRelated(owner, key, relation, value)
        save(owner, "{#{relation}}#{key}", value)
    end

    def saveAttribute(key, attribute, value)
        saveRelated("ludivine", key, attribute, value)
    end

    def loadOrCreate(owner, key, defaultValue)
        data = load(key).select { |row| row[0] == owner && row[1] == key }

        if data.size() == 0 
            data = [owner, key, defaultValue]
            save(data.flatten)
        end

        return transformData(data)
    end

    def loadOrCreateAttribute(key, defaultValue)
        loadOrCreate("ludivine", key, defaultValue)
    end    
end
