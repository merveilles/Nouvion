class Answer
    def lorem
        "My lorem module requires a method, and optionally the # of sentences, from this list:\n`gibson` `stephenson` `mkx` | `gibson 3` `stephenson 4`."
    end

    def gibson
        words = ['concrete', 'face forwards', 'hotdog', 'futurity', 'motion', 'bridge', 'drugs', 'realism', 'dome', 'sign', 'A.I.', 'warehouse', 'bomb', 'receding', 'fluidity', 'franchise', 'towards', 'neon', 'rifle', 'kanji', 'saturation point', 'ablative', 'skyscraper', 'car', 'pen', 'soul-delay', 'tower', '-space', '-ware', 'digital', 'wristwatch', 'advert', 'boat', 'jeans', 'physical', 'DIY', 'sentient', 'render-farm', 'city', 'corporation', 'table', 'free-market', 'Chiba', 'smart-', 'Shibuya', 'silent', 'numinous', 'semiotics', 'girl', 'assault', 'drone', 'refrigerator', 'euro-pop', 'savant', 'uplink', 'j-pop', 'grenade', 'computer', 'youtube', 'knife', 'artisanal', 'RAF', 'rebar', 'apophenia', 'tube', 'sensory', 'San Francisco', 'garage', 'market', 'vinyl', 'cartel', 'meta-', 'katana', 'rain', 'corrupted', 'range-rover', 'hacker', 'narrative', 'shanty town', 'Legba', 'faded', 'systema', 'nano-', 'bicycle', 'nodal point', 'monofilament', 'order-flow', 'footage', 'long-chain hydrocarbons', 'papier-mache', 'nodality', 'crypto-', 'engine', 'stimulate', 'lights', 'carbon', 'singularity', 'modem', 'denim', 'math-', 'plastic', 'fetishism', 'urban', 'sub-orbital', 'dead', 'Kowloon', 'paranoid', 'sunglasses', 'voodoo god', 'pre-', 'pistol', 'gang', '3D-printed', 'courier', 'construct', 'vehicle', 'sprawl', 'marketing', 'augmented reality', 'Tokyo', 'tanto', 'dolphin', 'chrome', 'office', 'neural', '8-bit', 'film', 'shrine', 'network', 'beef noodles', 'post-', 'woman', 'military-grade', 'tattoo', 'into', 'cyber-', 'man', 'disposable', 'spook', 'wonton soup', 'tiger-team', 'decay', 'weathered', 'tank-traps', 'media', 'assassin', 'industrial grade', 'systemic', 'BASE jump', 'convenience store', 'camera', 'cardboard', 'alcohol', 'claymore mine', 'shoes', 'boy', 'otaku', 'human', 'geodesic', 'dissident']

        sentenceCount = @message.split(' ')[2].to_i.abs
        sentence = text(sentenceCount, words)

        return sentence
    end

    def stephenson
        words = ['pizza', 'metaverse', 'shadowy', 'virtual', 'smartwheel', 'reason', 'rat thing', 'drug lord', 'corporation', 'entrepreneur', 'oreo', 'vapor of nuance', 'sintered armorgel', 'katana', 'dentata', 'mafia ethic', 'metacop', 'post-modern', 'caucasians with guns', 'nipponese', 'warrior prince', 'substance', 'unauthorized', 'viruses', 'infected', 'software', 'mass hysteria', 'techno-shit', 'xerox', 'business plan', 'arachnofiber weave', 'loogie gun', 'u-stor-it', 'magnapoon', 'hypercard', 'avatar', 'airbag jacket', 'virtual earth']

        sentenceCount = @message.split(' ')[2].to_i.abs
        sentence = text(sentenceCount, words)

        return sentence
    end

    def mkx
        words = ["spec ops", "hollywood", "brawler", "brood mother", "swarm queen", "venomous", "spectral", "mystic", "master of souls", "marksman", "gunslinger", "outlaw", "ruthless", "vicious", "lackey", "tigrar fury", "kuatan warrior", "dragon fangs", "shotgun", "full auto", "high tech", "stalker", "undead", "uber", "pumped up", "heavy weapons", "wrestler", "a-list", "fisticuffs", "stunt double", "commando", "cutthroat", "cybernetic", "possessed", "balanced", "kenjutsu", "mournful", "royal storm", "assassin", "sun god", "blood god", "war god", "ancestral", "bojutsu", "shaolin", "hat trick", "tempest", "buzz saw", "flame fist", "dragon's fire", "dualist", "ethereal", "piercing", "ravenous", "hunter", "trophy collector", "extraterrestrial", "summoner", "sorcerer", "warlock", "master of storms", "thunder god", "displacer", "noxious", "deceptive", "nimble", "inferno", "ninjutsu", "hellfire", "impostor", "bone shaper", "necromancer", "covert ops", "demolition", "special forces", "grandmaster", "cryomancer", "unbreakable", "shirai ryu", "lasher", "ronin", "deceiver", "edenian guard", "manipulator", "copycat", "elemental", "fugitive"]

        sentenceCount = @message.split(' ')[2].to_i.abs
        sentence = text(sentenceCount, words)

        return sentence
    end

  protected

    def text(sentenceCount, words)
        words.shuffle!

        sentence = words.pop(rand(10 - 7) + 7).join(' ').concat('.')
        sentenceCount = sentenceCount > 4 ? 4 : sentenceCount - 1

        if sentenceCount > 0
            sentenceCount.times { sentence << words.pop(rand(10 - 7) + 7).join(' ').insert(0, ' ').concat('.') }
        end

        return sentence
    end
end
