* Task description
  
  A ruby script that receives a log as argument and returns list of webpages with most page views ordered from most pages views to less page views
  
  E.g.
  
  most page views: `/home 90 visits /index 80 visits etc... > list of webpages with most`
  
  most unique page views: `/about/2 8 unique views /index 5 unique views etc...`
  
* How to install section (makefile or bundle install)

  `bundle install`
* How to run app

  `ruby ./parser.rb webserver.log`
  
  the file is already in root folder. You can use the file that you want to make it work.
* How to run specs

  `rspec spec`
* Approach description

  The script is pretty simple. I decided to use only 4 files to do the work.
  
  **ListViews** is responsible for calling a file handler and outputting the result.
  
  **FileHandler** is responsible for reading a file, inserting data from the file to a db and outputting the result of counting.
  
  **DB** is responsible for all database operations.
  
  **Callable** is a module that gives possibility to work with classes as they are services. To make it more convenient to dubug and check where and when something went wrong.
* Possible Improvements (ideas)
  Operations with db also can be checked on errors. Db settings should be added as variables to `.env` file. It really depends on the direction of the script.
  
  Probably db should be changed, but it will be easily done, cause `file_handler` don't know anything about database, it just use methods.
  
  It feels like FileHander does too much, but for such small purposes it files fine at this point. In persptive it should be splitted into few different opearatins.
  
  Logs can be added, validations to follow the output in special instruments like Airbreak or Sentry.
  
  Docker can be added.
