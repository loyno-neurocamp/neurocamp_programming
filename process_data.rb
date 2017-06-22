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

# Reading the data into a string of text is great, but the value assigned to
# `filedata` doesn't help us that much. It's probably better for us to use
# something that lets us look at each row of the data file. For that, we need
# to use an iterator. Here, we use the `foreach` iterator defined in the `CSV`
# module, which lets us define a block of code to apply to each row of the
# file, identified by the block using the name we put within the bars after
# the `do` keyword. In our case, we've used the name `row` to identify each row
# within the block. We use the `.inspect` function to see the contents of the
# row variable.
# To access individual parts of a `row`, we can use the .field function
# on the row with the header of the column we're looking for. To save typing,
# we'll use a short-hand for the .field function: `["column_header"]`
CSV.foreach(datafile, headers: true) do |row|
  puts row.inspect
  puts "Printing Subject ID and OSPAN Group..."
  puts row["Subject"], row["OSPAN_Group"]
end

# In some cases, we may want to operate on only some rows. For example, in this
# dataset, we may want to print data for only those `Subject`s whose
# `OSPAN_Group` is `High`. To do this, we use a conditional statement.
# In addition, the output we were getting before was not very helpful. It
# listed each value in a row, but not with any format that was readable.
# We can fix that using template strings. To create a template string,
# we write a normal string (anything between double quotes), but add in
# replacement tags `#{}`. Anything between the curly braces in a replacement
# tag will be evaluated and its value will replace the tag in the string.
puts "Data for subjects with OSPAN_Group 'High'"
CSV.foreach(datafile, {headers: true, converters: :all}) do |row|
  if (row["OSPAN_Group"] == "High")
    puts "#{row["Subject"]}, #{row["OSPAN_Score"]}, #{row["Distracter_hard"]}, #{row["Distracter_easy"]}"
  end
end
