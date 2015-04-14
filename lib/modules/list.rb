require 'api'

class Answer
    def list
        definition = @message.gsub('list', '').strip
        if definition.empty? then
            return "List does a reverse query on my memory with the format :\n`ludivine list single malt`\nYou may also query which topics can be listed with `list all`."
        end

		remember = API::Remember.new(@username)
        terms = remember.recall_by_definition(topic).map { |x| x[1] }.uniq

        if matches.size == 1 then
            return "The only *#{definition}* I know is _#{terms[0]}_."
        elsif matches.size > 1 then
            return "I know #{terms.size} kinds of *#{definition}* : _#{terms.join("_, _")}_."
        end

        return "I don't know any *#{definition}*."
    end

    def all
        remember = API::Remember.new(@username)
        all_terms = remember.load_similar('')

        # todo: this could be greatly optimized with a custom SQL query in the Recommend API
        matches = all_terms.select.with_index { |x,i| all_terms.index.with_index { |y,j| y[2] == x[2] && j != i } != nil }.map { |x| x[2] }.uniq

        if matches.size > 0 then
            return "There are #{matches.size} listable topics : _#{matches.join("_, _")}_."
        end

        return "There are no listable topics."
    end
end
