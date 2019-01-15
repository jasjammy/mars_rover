#Mars Rover Project

This project helps determine the position of a mars rover given coordinates of a plane and the commands to move it.
It is written in ruby.

#Prequistes
You will need Ruby version 2.0 and above to run this program. Please refer to this guide : [how to install ruby](https://www.phusionpassenger.com/library/walkthroughs/deploy/ruby/ownserver/nginx/oss/install_language_runtime.html) to download ruby.

#Install
To install the code for this program, you will need to clone the repository from git.
Using ssh
```
git clone git@github.com:jasjammy/mars_rover.git
```
or using https:
```
https://github.com/jasjammy/mars_rover.git
```

Now you can change directory to the mars_rover directory to run the code.

```
ruby mars_rover.rb input.txt
```
In the repository, there are text files, those are sample input files.
They follow the following format:
```
5 5           # This is the upper right coordinates that determine the size of the plane from (0,0)
1 2 N         # This is the x,y position of the rover on the plane with its orientation of either North, South, East or West
LMLMLMLMLM    # This is the commands to move the rover 'L' - left or 'R'- right 
```

Design Decisions:
1. I did not need to use any framework to help me with this project and it would be redundant.
2. Instead of making an if statement block to determine the coordinates after the step/command given, I chose to fill a hash.
    * I filled the hash with the results of the current step applied on the directional coordinates
    * The hash called dir_hash had the orientation of the rover and it contained another hash. The hash consisted of the step and the value is the result applied to the coordinates.
3. I tested this using fail_inputs.txt, input.txt and small_inputs.txt. To take care of edge cases and base cases.