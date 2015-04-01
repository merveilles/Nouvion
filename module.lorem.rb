#!/bin/env ruby
# encoding: utf-8

class Answer

  def lorem
    return gibson
  end

  def gibson

    words = ['concrete', 'face forwards', 'hotdog', 'futurity', 'motion', 'bridge', 'drugs', 'realism', 'dome', 'sign', 'A.I.', 'warehouse', 'bomb', 'receding', 'fluidity', 'franchise', 'towards', 'neon', 'rifle', 'kanji', 'saturation point', 'ablative', 'skyscraper', 'car', 'pen', 'soul-delay', 'tower', '-space', '-ware', 'digital', 'wristwatch', 'advert', 'boat', 'jeans', 'physical', 'DIY', 'sentient', 'render-farm', 'city', 'corporation', 'table', 'free-market', 'Chiba', 'smart-', 'Shibuya', 'silent', 'numinous', 'semiotics', 'girl', 'assault', 'drone', 'refrigerator', 'euro-pop', 'savant', 'uplink', 'j-pop', 'grenade', 'computer', 'youtube', 'knife', 'artisanal', 'RAF', 'rebar', 'apophenia', 'tube', 'sensory', 'San Francisco', 'garage', 'market', 'vinyl', 'cartel', 'meta-', 'katana', 'rain', 'corrupted', 'range-rover', 'hacker', 'narrative', 'shanty town', 'Legba', 'faded', 'systema', 'nano-', 'bicycle', 'nodal point', 'monofilament', 'order-flow', 'footage', 'long-chain hydrocarbons', 'papier-mache', 'nodality', 'crypto-', 'engine', 'stimulate', 'lights', 'carbon', 'singularity', 'modem', 'denim', 'math-', 'plastic', 'fetishism', 'urban', 'sub-orbital', 'dead', 'Kowloon', 'paranoid', 'sunglasses', 'voodoo god', 'pre-', 'pistol', 'gang', '3D-printed', 'courier', 'construct', 'vehicle', 'sprawl', 'marketing', 'augmented reality', 'Tokyo', 'tanto', 'dolphin', 'chrome', 'office', 'neural', '8-bit', 'film', 'shrine', 'network', 'beef noodles', 'post-', 'woman', 'military-grade', 'tattoo', 'into', 'cyber-', 'man', 'disposable', 'spook', 'wonton soup', 'tiger-team', 'decay', 'weathered', 'tank-traps', 'media', 'assassin', 'industrial grade', 'systemic', 'BASE jump', 'convenience store', 'camera', 'cardboard', 'alcohol', 'claymore mine', 'shoes', 'boy', 'otaku', 'human', 'geodesic', 'dissident']

    sentenceCount = @message.split(" ")[3].to_i.abs

    if sentenceCount > 4
      return Hash["text" => "Use loremgibson.com instead."]
    end

    words.shuffle!
    sentence = words.pop(rand(10 - 7) + 7).join(" ").concat(".")
    sentenceCount = sentenceCount - 1

    if sentenceCount > 0
      sentenceCount.times { sentence << words.pop(rand(10 - 7) + 7).join(" ").insert(0, " ").concat(".") }
    end

    return Hash["text" => sentence]

  end

end
