#Samuel Benek
#Deliverable 2
#CS 1632
#Test Code

require 'minitest/autorun'
require_relative 'city_sim_9006'

class CitySimTest < Minitest::Test

	#UNIT TESTS FOR LOCATION CONSTRUCTOR
	#Equivalence classes:
	#loc is constructed with two parameters -> loc is a location
	#loc is not constructed with two parameters -> ArgumentError is raised

	def test_location_is_location
		loc = Location::new("Location", ["Place"])
		assert loc.is_a?(Location)
	end
	
	#UNIT TESTS FOR DRIVER CONSTRUCTOR
	#Equivalence classes:
	#driv is constructed with two parameters -> driv is a driver
	#driv is not constructed with two parameters -> ArgumentError is raised
	
	def test_driver_is_driver
		loc = Location::new("Location", ["Place"])
		driv = Driver::new(1, loc)
		assert driv.is_a?(Driver)
	end
	
	#UNIT TESTS FOR get_neighbors method in Location class
	#No arguments, so no equivalence classes
	#returns a Location's 'neighbors' data member
	
	def test_location_get_neighbors
		neighbors_1 = ["Hogwarts"]
		loc = Location::new("Location", neighbors_1)
		assert_equal neighbors_1, loc.get_neighbors
	end
	
	#UNIT TESTS FOR get_place method in Driver class
	#No arguments, so no equivalence classes
	#returns a Driver's 'place' data member
	
	def test_driver_get_place
		loc = Location::new("Location", ["Place"])
		driv = Driver::new(1, loc)
		assert_equal loc, driv.get_place
	end
	
	#UNIT TESTS FOR get_books method in Driver class
	#No arguments, so no equivalence classes
	#returns a Driver's 'book' data member, always 0 in a newly constructed Driver
	
	def test_drivers_get_books
		loc = Location::new("Location", ["Place"])
		driv = Driver::new(1, loc)
		assert_equal 0, driv.get_books
	end
	
	#UNIT TESTS FOR get_dinos method in Driver class
	#No arguments, so no equivalence classes
	#returns a Driver's 'dinos' data member, always 0 in a newly constructed Driver
	
	def test_drivers_get_dinos
		loc = Location::new("Location", ["Place"])
		driv = Driver::new(1, loc)
		assert_equal 0, driv.get_dinos
	end
	
	#UNIT TESTS FOR get_classes method in Driver class
	#No arguments, so no equivalence classes
	#returns a Driver's 'classes' data member, always 0 in a newly constructed Driver
	
	def test_drivers_get_classes
		loc = Location::new("Location", ["Place"])
		driv = Driver::new(1, loc)
		assert_equal 0, driv.get_classes
	end
	
	#UNIT TESTS FOR inc_books method in Driver class
	#No arguments, so no equivalence classes
	#will return the number equal to however many times this method is called
	
	def test_driver_inc_books
		loc = Location::new("Location", ["Place"])
		driv = Driver::new(1, loc)
		driv.inc_books
		assert_equal 1, driv.get_books
	end
	
	#UNIT TESTS FOR inc_dinos method in Driver class
	#No arguments, so no equivalence classes
	#will return the number equal to however many times this method is called
		
	def test_driver_inc_dinos
		loc = Location::new("Location", ["Place"])
		driv = Driver::new(1, loc)
		driv.inc_dinos
		assert_equal 1, driv.get_dinos
	end
	
	#UNIT TESTS FOR inc_books method in Driver class
	#No arguments, so no equivalence classes
	#will return the number equal to twice however many times this method is called 
	
	def test_driver_inc_classes
		loc = Location::new("Location", ["Place"])
		driv = Driver::new(1, loc)
		driv.inc_classes
		assert_equal 2, driv.get_classes
	end
	
	#UNIT TESTS FOR update_place method in the Driver class
	#Equivalence classes:
	#For any x, driv.update_place(x) will set driv's 'place' data member to x

	def test_driver_update_place
		loc1 = Location::new("Location", ["Place"])
		driv = Driver::new(1, loc1)
		loc2 = Location::new("Hogwarts", ["Place"])
		driv.update_place(loc2)
		refute_equal loc1, driv.get_place
	end
	
	#UNIT TESTS FOR drive method in the Driver class
	#Equivalence classes:
	#driv's 'place' data member is a Location with one neighbor -> returns that neighbor
	#driv's 'place' data member is a Location with more than one neighbor -> returns a random one of those neighbors
	#driv's 'place' data member is a Location with no neighbors -> returns nil
	#IN ALL CASES: returns a value that is not equal to driv's current 'place' data member
	
	#returns a value not equal to driv's 'place'
	def test_driver_drive_change_place
		loc1 = Location::new("Location", ["Place"])
		driv = Driver::new(1, loc1)
		refute_equal loc1, driv.drive
	end
	
	#returns the only neighbor available to drive to
	def test_driver_drive_once_choice
		loc1 = Location::new("Location", ["Place"])
		driv = Driver::new(1, loc1)
		assert_equal "Place", driv.drive
	end
	
	#returns one of the available members to drive to
	def test_driver_drive_many_choices
		loc1 = Location::new("Location", ["Hogwarts","Narnia","Middle Earth"])
		driv = Driver::new(1, loc1)
		assert_includes driv.get_place.get_neighbors, driv.drive
	end
	
	#EDGE CASE
	#returns nil if there are no available neighbors
	def test_driver_no_choices
		loc1 = Location::new("Location", [])
		driv = Driver::new(1, loc1)
		assert_nil driv.drive
	end
	
	#UNIT TESTS FOR PRINT METHODS
	#Equivalence classes:
	#x = 1 -> outputs print statement with singular grammar
	#x > 1 OR x = 0 -> outputs print statement with plural grammar
	#x < 0 -> raises error
	
	#If 1 is given for first argument, then the last word will be "book!"
	def test_print_books_singular
		assert_output("Driver 1 obtained 1 book!\n") { print_books(1,1) }
	end
	
	#EDGE CASE
	#if a negative value is given for the first argument, an exception is raised
	def test_print_books_negative
		assert_raises("Cannot have fewer than 0 books") { print_books(-1,-1) }
	end
	
	#If x = 0 or x > 1, print_books(x,y) will print a statement with the last word "books!"
	def test_print_books_plural
		assert_output("Driver 1 obtained 3 books!\n") { print_books(3,1) }
	end
	
	#If 1 is given for first argument, then the last word will be "toy!"
	def test_print_dinos_singular
		assert_output("Driver 1 obtained 1 dinosaur toy!\n") { print_dinos(1,1) }
	end
	
	#If x = 0 or x > 1, print_dinos(x,y) will print a statement with the last word "toys!"
	def test_print_dinos_plural
		assert_output("Driver 1 obtained 3 dinosaur toys!\n") { print_dinos(3,1) }
	end
	
	#EDGE CASE
	#if a negative value is given for the first argument, an exception is raised
	def test_print_dinos_negative
		assert_raises("Cannot have fewer than 0 dinosaur toys") { print_dinos(-1,-1) }
	end
	
	#If x = 0 or x > 1, print_classes(x,y) will print a statement with the last word "classes!"
	def test_print_classes_plural
		assert_output("Driver 1 attended 4 classes!\n") { print_classes(4,1) }
	end
	
	#EDGE CASE
	#if a negative value is given for the first argument, an exception is raised
	def test_print_classes_negative
		assert_raises("Cannot have fewer than 0 classes") { print_classes(-1,-1) }
	end
end