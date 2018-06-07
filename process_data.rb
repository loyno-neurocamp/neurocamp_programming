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

# Here, we use the `foreach` iterator defined in the `CSV`
# module, which lets us define a block of code to apply to each row of the
# file, identified by the block using the name we put within the bars after
# the `do` keyword. In our case, we've used the name `row` to identify each row
# within the block. We use the `.inspect` function to see the contents of the
# row variable.
# To access individual parts of a `row`, we can use the .field function
# on the row with the header of the column we're looking for. To save typing,
# we'll use a short-hand for the .field function: `["column_header"]`
# We also reorganize some of our code so that it's easier to understand.
# We'll do this using functions, which take a piece of the processing code,
# and give it a name.  We can also name the data we use in that processing
# code, so that we can pass the data into the function.
def center_title(table_title, table_width)
  n = table_title.length
  spaces = table_width - n
  left = " " * (spaces / 2.0).ceil
  right = " " * (spaces / 2.0).floor
  "#{left}#{table_title}#{right}"
end
def format_field(fname, t, l, d, suffix)
	"%<#{fname}>#{l}#{"." if t == 'f'}#{d if t == 'f'}#{t}#{suffix}"
end
def format_field_header(fname, l, h)
	"%<#{fname}>#{l+h}s"
end
def format_table_divider(char, table_width)
  char * table_width
end

def distracter_average(hard, easy)
  (hard + easy) / 2.0
end
def distracter_difference(hard, easy)
  (hard - easy).abs
end
def distracter_percent_difference(hard, easy)
  100 * distracter_difference(hard, easy) / hard
end

def compute_stats(row)
	id = row["Subject"]
	group = row["OSPAN_Group"]
	easy = row["Distracter_easy"]
	hard = row["Distracter_hard"]
	{
		subj: id,
		ospan: group,
		avg: distracter_average(hard, easy),
		diff: distracter_difference(hard, easy),
		perc: distracter_percent_difference(hard, easy)
	}
end

def print_table_header(table_title, table_headers, fmt)
	l = fmt[:l]
	f = fmt[:f]
	h = fmt[:h]
	separator = fmt[:separator]
	sep = separator.length
	
  header_format = (0..l.length-1).map { |i| format_field_header(f[i], l[i], h[i]) }.join(separator)
  table_width = l.reduce(0, :+) + h.reduce(0, :+) + sep * (l.length - 1)
	dashes = format_table_divider("-", table_width)
	
  puts ""
  puts center_title(table_title, table_width)
	puts ""
	puts format(header_format, table_headers)
	puts dashes
end

def print_table_row(row, fmt)
	f = fmt[:f]
	t = fmt[:t]
	l = fmt[:l]
  d = fmt[:d]
  suffix = fmt[:suffix]
	separator = fmt[:separator]
	
	data_format = (0..l.length-1).map { |i| format_field(f[i], t[i], l[i], d[i], suffix[i]) }.join(separator)
	data_values = compute_stats(row)
	puts format(data_format, data_values)
end

# In some cases, we may want to operate on only some rows. For example, in this
# dataset, we may want to print data for only those `Subject`s whose
# `OSPAN_Group` is `High`. To do this, we could use a conditional statement.

# In addition, the output we were getting before was not very helpful. It
# listed each value in a row, but not with any format that was readable.
# We can fix that using template strings. To create a template string,
# we write a normal string (anything between double quotes), but add in
# replacement tags `#{}`. Anything between the curly braces in a replacement
# tag will be evaluated and it's value will replace the tag in the string.
# We have also added some computations on the data.  In order to do this,
# note that we've added the CSV option `converters: :all`, which tells the
# CSV module to convert values that it finds that look like numbers into
# numeric data types. Here, we're computing three new columns: the difference
# between the distracter scores, and the percent difference between the
# distracter scores (using the hard task as the base), and their average.
# Finally, we've added some formatting to print this data in tabular format.
# We've done this using the format command/function used both on the
# header line, and within the foreach loop for every row we print.
# Note that we can also repeat a string ("-", in this case) by multiplying
# it by a number.  For our string, we add up the length of each field, and
# add the amount of space the separators take (3 spaces each times 4 separators).
table_title = "Distracter EEG response characteristics"
table_headers = {
	subj: "Subject",
	ospan: "OSPAN Group",
	avg: "Dist. Avg.",
	diff: "Dist. Diff.",
	perc: "Dist. % Diff."
}
format_options = {
	f: ["subj", "ospan", "avg", "diff", "perc"],
	t: ['d','s','f','f','f'],
	l: [7, 11, 10, 11, 13],
	d: [0, 0, 2, 2, 2],
  h: [0, 0, 0, 0, 2],
  suffix: ["", "", "", "", " %%"],
	separator: " | "
}

print_table_header(table_title, table_headers, format_options)
CSV.foreach(datafile, {headers: true, converters: :all}) do |row|
	print_table_row(row, format_options)
end
