# Require the main class
require './answer'
# Require any modules you might need
require './test/memory'
require('./module.define')

# Set up the payload
answer = Answer.new("define", "define", "renaudbedard", "test", "theartificiallounge")

# Output the result
puts answer.define()
