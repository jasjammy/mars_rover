#!/bin/ruby
#
# This ruby file contains a class Rover and a script to get inputs

require 'stringio'

# This class encapsulates the details of the position of the Rover.
# It also stores information about the plane the Rover is travelling on.
class Rover

  # This hash stores the value of the coordinates and orientation when the step is 'L' or 'R' or 'M'
  @@dir_hash = Hash.new()

  def initialize(upper_right, start, commands)
    populate_dir_hash
    @upper_right = upper_right
    @start = start
    @commands = commands
  end

  def move_rover
    curr_coord = [@start[0].to_i, @start[1].to_i, @start[2]]

    @commands.each do |step|
      case step
      when 'L'
        curr_coord[2] = @@dir_hash[curr_coord[2]][:L]
      when 'R'
        curr_coord[2] = @@dir_hash[curr_coord[2]][:R]
      when 'M'
        curr_coord = @@dir_hash[curr_coord[2]][:M][curr_coord[0], curr_coord[1], curr_coord[2]]
      else
        puts "Error: Invalid command input #{step}"
        return
      end
      # check that the rover has not gone out of bounds
      if (curr_coord[0] > @upper_right[0] || curr_coord[0] < 0 ) || (curr_coord[1] > @upper_right[1] || curr_coord[1] < 0 )
        puts "Error: Rover is out of bounds. Occured at step #{step} with coordinates #{curr_coord.join(" ")}"
        return
      end
    end

    return curr_coord

  end

  private

  def populate_dir_hash
    @@dir_hash['E'] = {'L':'N', 'R':'S', 'M': lambda {|x,y,o| [x+1,y,o] } }
    @@dir_hash['N'] = {'L':'W', 'R':'E', 'M': lambda {|x,y,o| [x,y+1,o] } }
    @@dir_hash['S'] = {'L':'E', 'R':'W', 'M': lambda {|x,y,o| [x,y-1,o] } }
    @@dir_hash['W'] = {'L':'S', 'R':'N', 'M': lambda {|x,y,o| [x-1,y,o] } }
  end
end


# get input from command line
if ARGV.length < 1
  puts "Too few arguments. Please give a file name as input"
  exit
end

filename = ARGV[0].to_s
if File.zero?(filename) then
  puts "Error: #{filename} is empty. Please provide a file with contents."
  exit
end

fptr = File.open(filename,'r')
# read upper right coordinates from the first line of the file.
upper_right = fptr.readline().rstrip.split(" ").map(&:to_i)

while !fptr.eof?
  first_line = fptr.readline()
  start = first_line.rstrip.split(" ")
  second_line = fptr.readline()
  commands = second_line.rstrip.split("")
  rover = Rover.new(upper_right, start, commands)
  result = rover.move_rover
  puts result.join(" ") unless result.nil?
end