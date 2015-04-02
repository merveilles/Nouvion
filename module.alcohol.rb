class RandomAlc
	def alc
		return Hash["text" => "Recommend Alcohol"]
	end 

	def alcChoice
		alcChoice = [
		"Any Beer", "Any Ale", "Barelywine",
		"Bitter Ale", "Brown Ale", "Mild Ale",
		"Old Ale", "Pale Ale", "Pale Ale", "Any scotch",
		"Any Vodka", "Any Wiskey", "Any Lager", "Pale lager",
		"Bock Lager", "Pilsener Lager", "Schwarzbier Lager", 
		"holy shit Japan is awesome Im 19 and can walk into a store and buy all the alcohol I want",
		"I was really fucking drunk while coding this",
		"Cider beer", "Icariine Liquor", "Mead", "Palm Wine",
		"Sake", "Definitely Sake", "You should find sake and drink it."
		"Wine... gross", "Fruit wine", "Table Wine", "Sparking Wine", "Champagne"
		"Any cocktail", "Force aliceffekt to brew his own beer and send it to you."
		]

		return Hash["text" => facts.shuffle[0]]
	end 
end 