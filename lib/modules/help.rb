class Answer
    def help
        'I am bot created in *Ruby* by the Merveilles community, in the <#the-artificial-lounge>. You can ask me for <help> or improve my responses by creating pull requests on Github: https://github.com/merveilles/nouvion'
    end

    def channels
        "<#the-studio> Audio Channel\n<#the-observatory> Visual Channel\n<#the-atheneum> Code Channel\n<#the-workshop> Project Channel"
    end

    def modules
        visible_modules = ''

        Dir.entries('lib/modules').each do |name, _v|
            unless name.include?('.rb') then next end

            visible_modules += '`' + name.sub('module.', '').sub('.rb', '') + '` '
        end

        "My current active modules are:\n#{visible_modules.rstrip}."
    end

    def version
        sha1 = `git rev-parse HEAD`.gsub("\n", '')

        return "https://github.com/merveilles/nouvion/commit/#{sha1}"
    end
end
