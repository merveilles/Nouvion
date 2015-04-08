class Memory
    
    def loadRelated key, relation
        
        data = load("{#{relation}}#{key}")

        returnArray = []
        data.each do |row|
            newHash = {}
            newHash["username"] = row[0]
            newHash["relation"] = row[1].scan(/\{([^\)]+)\}/).to_s
            newHash["key"] = row[1].sub("{"+newHash["relation"]+"}","")
            newHash["value"] = row[2]
            returnArray.push(newHash)
        end

        return returnArray

    end

    def saveRelated username,key,relation,value
        
        return save(username,"{#{relation}}#{key}",value)

    end

end
