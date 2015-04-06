# Require the main class
require './answer'
require './test/memory'
# Require any modules you might need
require('./module.flip')

# Set up the payload
answer = Answer.new("module_name", "method_name", "username", "message", "channel_name")

# Output the result
puts answer.flip()
