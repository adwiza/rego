package rules

# Function rules let you extend the set of byilt-in functions.

# Given a string like "hooli.com/nginx:1.3",
# return the array [["hooli.com", "nginx"], "1.3"]

split_image(str) := parts if {
	image_version := split(str, ":")
	path := split(image_version[0], "/")
	parts := [path, image_version[1]]
}

# Call custom functions the same way you call a built-in function

allow if {
	pieces := split_image(input.image)
	pieces[0][0] == "hooli.com"
}

# Multiple rules handle conditions within functions. Recommendation is for
# function bodies to be mutually exclusive when possible.

safe_repo(name) if name == "hooli.com"
safe_repo(name) if name == "initech.org"

# By default, the return value is TRUE
# these 2 are equivalent
# safe_repo(p) = true { ... }
# safe_repo(p) {...}

# Rule body is optional
# these 2 are equivalent
safe_repo("hooli.com")
safe_repo(r) if r == "hooli.com"
