module API
	
	#what the data looks like:
	# (username:"faun", term:"wallet", relation:"contents") : definition:"-10"
	
	#USAGE NOTE: plz use transfer instead of _add and _subtract to make sure money is never ever destroyed, even if your code has bugs
	
	class Wallet
		def initialize(username, mem)
			@username = username
			@mem = mem
			#make wallet if it does not already exist
			if ! @mem.exists(@username, "wallet")
				@mem.add(@username, "wallet", "10", "contents")
			end
		end
		
		def _set_contents(amount)
			@mem.replace_by_username_term_relation(@username, "wallet", "contents",  amount.to_s)
		end
		def _subtract(amount)
			_set_contents(contents - amount)
		end
		def _add(amount)
			_set_contents(contents + amount)
		end
		
		private def requireHas(amount)
			raise ArgumentError, "insufficient funds. Consider indebt if indebting is allowed" if amount > content
		end
		private def requirePositive(amount)
			raise ArgumentError, "You cannot transfer a negative amount of xen YoU sNeAkY" if amount < 0
		end
		
		def contents
			return @mem.load_by_username_term_relation(@username, "wallet", "contents")[0].definition.to_i
		end
		
		def house_wallet
			return Wallet.new("nouvion", @mem)
		end
		def self.the_house(mem)
			return Wallet.new("nouvion", mem)
		end
		
		def transfer(amount, to = house_wallet) #to can be a string or a Wallet
			requirePositive amount
			requireHas amount
			if to.kind_of?(String)
				to = Wallet.new(to, @mem)
			end
			self._subtract amount
			to._add amount
		end
		
		def indebt(amount, to = house_wallet) #if user doesn't have amount, will put them into debt. Most operations should not be allowed to do this. Needed for timed wagers.
			requirePositive amount
			otherUser = Wallet.new(to, @mem)
			if to.kind_of?(String)
				to = Wallet.new(to, @mem)
			end
			self._subtract amount
			to._add amount
		end
end