# Rush Hour
#### Project contributors: [Nicholas Dorans](https://github.com/nickyBobby) and [Erinna Chen](https://github.com/erinnachen)

### Overview
This project was a one week project spanning the second week of Module 2 at the Turing School. This project utilizes Ruby, Sinatra, ActiveRecord and PostgreSQL to build a web traffic tracking and analysis tool. The original specification for this project can be found [here.](https://github.com/turingschool/curriculum/blob/master/source/projects/rush_hour.md)

### Iteration summaries
* Iteration 0: Set up use of ActiveRecord and a PostgreSQL database to handle Payload Requests. In a payload request, parameters by default is an empty array. This is not a normalized database.

After check-in with Rachel on Tuesday, it was suggested that we move to a more Rails-like look to the database, and to build out a parser for the payload. RequestedAt currently is a string, but will be swapped to a DateTime object for educational value.

* Iteration 1:
