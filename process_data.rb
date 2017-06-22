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

# We don't need this cluttering the output at this point, so we'll comment
# these lines out
# filedata = CSV.read(datafile, headers: true)
# puts filedata

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

# We don't need this cluttering the output at this point, so we'll comment
# these lines out.
# CSV.foreach(datafile, headers: true) do |row|
#   puts row.inspect
#   puts "Printing Subject ID and OSPAN Group..."
#   puts row["Subject"], row["OSPAN_Group"]
# end


# Now, we'll reorganize some of our code so that it's easier to understand.
# We'll do this using functions, which take a piece of the processing code,
# and give it a name.  We can also name the data we use in that processing
# code, so that we can pass the data into the function.
def format_header(subj, ospan, diff, perc)
  format("%<subj>7s  |  %<ospan>11s  |  %<diff>21s  |  %<perc>23s",
          {subj: subj, ospan: ospan, diff: diff, perc: perc})
end

def format_data_row(subj, ospan, diff, perc)
  format("%<subj>7d  |  %<ospan>11d  |  %<diff> 21.2f  |  %<perc> 21.4f %%",
          {subj: subj, ospan: ospan, diff: diff, perc: perc})
end

def table_divider(char, length)
  char * length
end

def distracter_difference(hard, easy)
  hard - easy
end

def distracter_percent_difference(hard, easy)
  100 * distracter_difference(hard, easy) / hard
end

# In some cases, we may want to operate on only some rows. For example, in this
# dataset, we may want to print data for only those `Subject`s whose
# `OSPAN_Group` is `High`. To do this, we use a conditional statement.
# In addition, the output we were getting before was not very helpful. It
# listed each value in a row, but not with any format that was readable.
# We can fix that using template strings. To create a template string,
# we write a normal string (anything between double quotes), but add in
# replacement tags `#{}`. Anything between the curly braces in a replacement
# tag will be evaluated and it's value will replace the tag in the string.
# We have also added some computations on the data.  In order to do this,
# note that we've added the CSV option "converters: :all", which tells the
# CSV module to convert values that it finds that look like numbers into
# numeric data types.  Here, we're computing two new columns: the difference
# between the distracter scores, and the percent difference between the
# distracter scores (using the hard task as the base).
# Finally, we've added some formatting to print this data in tabular format.
# We've done this using the format command/function used both on the
# header line, and within the foreach loop for every row we print.
# Note that we can also repeat a string ("-", in this case) by multiplying
# it by a number.  For our string, we add up the length of each field, and
# add the amount of space the dividers take (5 spaces each times 3 dividers).
puts "Distracter score differences for subjects with OSPAN_Group 'High'"
puts ""
puts format_header("Subject", "OSPAN Score", "Distracter Difference",
                   "Distracter % Difference")
puts table_divider("-", 7 + 11 + 21 + 23 + 15)
CSV.foreach(datafile, {headers: true, converters: :all}) do |row|
  if (row["OSPAN_Group"] == "High")
    diff = distracter_difference(row["Distracter_hard"],
                                 row["Distracter_easy"])
    perc = distracter_percent_difference(row["Distracter_hard"],
                                         row["Distracter_easy"])
    puts format_data_row(row["Subject"], row["OSPAN_Score"], diff, perc)
  end
end
