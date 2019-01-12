#!/bin/ruby
#
#
# This script will read a text file and output the final position of each rover


require 'stringio'

def move_rover(upper_right= [5,5], start, commands)

  dir_hash = Hash.new()
  dir_hash['E'] = {'L':'N', 'R':'S', 'M': lambda {|x,y,o| [x+1,y,o] } }
  dir_hash['N'] = {'L':'W', 'R':'E', 'M': lambda {|x,y,o| [x,y+1,o] } }
  dir_hash['S'] = {'L':'E', 'R':'W', 'M': lambda {|x,y,o| [x,y-1,o] } }
  dir_hash['W'] = {'L':'S', 'R':'N', 'M': lambda {|x,y,o| [x-1,y,o] } }

  curr_coord = start

  commands.each do |step|
    puts "before step : #{curr_coord}"
    puts "step : #{step}"
    case step
    when 'L'
      curr_coord[2] = dir_hash[curr_coord[2]][:L]
    when 'R'
      curr_coord[2] = dir_hash[curr_coord[2]][:R]
    when 'M'
      curr_coord = dir_hash[curr_coord[2]][:M][curr_coord[0], curr_coord[1], curr_coord[2]]
    else
      puts "Error: Invalid command input #{step}"
      exit
    end

    puts "after step :#{curr_coord}"
    # See that the coordinates are valid
    if (curr_coord[0] > upper_right[0] || curr_coord[0] < 0 ) || (curr_coord[1] > upper_right[1] || curr_coord[1] < 0 )
      puts "Error: Rover is out of bounds"
      exit
    end
  end

  puts curr_coord

end

move_rover([5,5,'N'], ['L','M','L','M','L','M','L','M','M'])

# # take the input from command line
#
# if ARGV.length < 1
#   puts "Too few arguments. Please give a file name as input"
#   exit
# end
#
# fptr = File.open($ARGV[0])
#
# while !fptr.eof?
#   first_line = fptr.readline()
#   upper_right = first_line.rstrip.split(" ")
#   second_line = fptr.readline()
#   commands = second_line.rstrip.split()
#   move_rover(upper_right, commands)
# end