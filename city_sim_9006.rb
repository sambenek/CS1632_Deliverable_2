#Samuel Benek
#Deliverable 2
#CS 1632
#City Simulator 9006

#location class

class Location
	@name = nil
	@neighbors = nil
	
	def initialize(name, neighbors)
		@name = name
		@neighbors = neighbors
	end	
	
	#simple getter methods
	
	def get_neighbors
		return @neighbors
	end
end

#driver class

class Driver 
	@number = 0
	@place = nil
	
	def initialize(number, place)
		@number = number
		@place = place
		@dinos = 0
		@classes = 0
		@books = 0
	end
	
	def drive
		options = @place.get_neighbors
		num = options.count
		prng = rand num
		new_place = options[prng]
		return new_place
	end
	
	#simple getter methods
	
	def update_place(new_place)
		@place = new_place
	end
	
	def get_place
		return @place
	end
	
	def get_books
		return @books
	end
	
	def get_dinos
		return @dinos
	end
	
	def get_classes
		return @classes
	end
	
	#methods that increment Driver's data members
	
	def inc_books
		@books += 1
	end
	
	def inc_dinos
		@dinos += 1
	end
	
	def inc_classes
		@classes += 2
	end
end

#prints statements with grammar according to how many objects there are
def print_books(num, driver_count)
	raise "Cannot have fewer than 0 books" if num < 0
	if num == 1
		puts "Driver #{driver_count} obtained 1 book!"
	else
		puts "Driver #{driver_count} obtained #{num} books!"
	end
end

def print_dinos(num, driver_count)
	raise "Cannot have fewer than 0 dinosaur toys" if num < 0
	if num == 1
		puts "Driver #{driver_count} obtained 1 dinosaur toy!"
	else
		puts "Driver #{driver_count} obtained #{num} dinosaur toys!"
	end
end

def print_classes(num, driver_count)
	raise "Cannot have fewer than 0 classes" if num < 0
	if num == 1
		puts "Driver #{driver_count} attended 1 class!"
	else
		puts "Driver #{driver_count} attended #{num} classes!"
	end
end

#EXECUTION STARTS HERE

raise "Enter a seed and only a seed." unless ARGV.count == 1
begin
	seed = ARGV[0].to_i
rescue
	seed = 0
end

#create available locations

loc_hill = Location::new("Hillman", ["Downtown", "Hospital"])
loc_hosp = Location::new("Hospital", ["Hillman", "Cathedral"])
loc_cath = Location::new("Cathedral", ["Monroeville", "Museum"])
loc_muse = Location::new("Museum", ["Hillman", "Cathedral"])
loc_monr = Location::new("Monroeville", [])
loc_down = Location::new("Downtown", [])

#an array of the locations its possible to start at

all_locations = [loc_hill, loc_hosp, loc_cath, loc_muse]

count = 1

#seed prng

srand seed

#for each of the 5 drivers

while count < 6

	#choose a random starting location
	random_start = rand 4
	start = all_locations[random_start]
	curr_loc = start
	
	curr_driver = Driver::new(count, curr_loc)
	#until we either hit monroeville or downtown
	until curr_driver.get_place == loc_monr || curr_driver.get_place == loc_down
		next_string = curr_driver.drive
			
		#set the new location of the driver
		if next_string == "Hillman"
			next_loc = loc_hill
		elsif next_string == "Hospital"
			next_loc = loc_hosp
		elsif next_string == "Cathedral"
			next_loc = loc_cath
		elsif next_string == "Museum"
			next_loc = loc_muse
		elsif next_string == "Downtown"
			next_loc = loc_down
		elsif next_string == "Monroeville"
			next_loc = loc_monr
		end
		
		#choosing what to print
		if curr_loc == loc_cath
			curr_driver.inc_classes
			if next_loc == loc_muse
				puts "Driver #{count} heads from Cathedral to Museum via Bar St."
			elsif next_loc == loc_monr
				puts "Driver #{count} heads from Cathedral to Monroeville via Fourth Ave."
			else
				puts "heck"
			end
		elsif curr_loc == loc_muse
			curr_driver.inc_dinos
			if next_loc == loc_cath
				puts "Driver #{count} heads from Museum to Cathedral via Bar St."
			elsif next_loc == loc_hill
				puts "Driver #{count} heads from Museum to Hillman via Fifth Ave."
			else
				puts "heck"
			end
		elsif curr_loc == loc_hill
			curr_driver.inc_books
			if next_loc == loc_hosp
				puts "Driver #{count} heads from Hillman to Hospital via Foo St."
			elsif next_loc == loc_down
				puts "Driver #{count} heads from Hillman to Downtown via Fifth Ave."
			else
				puts "heck"
			end
		elsif curr_loc == loc_hosp
			if next_loc == loc_cath
				puts "Driver #{count} heads from Hospital to Cathedral via Fourth Ave."
			elsif next_loc == loc_hill
				puts "Driver #{count} heads from Hospital to Hillman via Foo St."
			else
				puts "heck"
			end
		end
		
		curr_driver.update_place(next_loc)
		curr_loc = next_loc
		
	end
	
	#print how many objects were picked up
	print_books(curr_driver.get_books, count)
	print_dinos(curr_driver.get_dinos, count)
	print_classes(curr_driver.get_classes, count)
	
	count += 1
end




