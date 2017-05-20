#!/usr/bin/ruby

# This sets a variable named `datafile` to have the value `data/data.csv`.
# Variables allow us to save values once for later use. You can think of
# a variable as a named container. When you assign a value to the variable,
# you're putting that value in the container. When you use the variable later,
# you're taking the value out temporarily. Values can be anything: numbers,
# character strings, file objects, lists, and more.
datafile = "data/data.csv"

# Here, we're using the `datafile` variable we just created.
# The `CSV` module has several functions that help us read and write data from
# files in the CSV (Comma-Separated Values) format. More on the module is
# available in the Ruby documentation at:
# http://ruby-doc.org/stdlib-2.3.0/libdoc/csv/rdoc/CSV.html
require('csv') # This loads the `CSV` module into memory as `CSV`

# We're saving that data to another variable called `filedata`, then printing
# the contents of that variable to the screen
filedata = CSV.read(datafile, headers: true)
puts filedata
