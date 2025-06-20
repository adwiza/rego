# INCORRECT: if the config satisries both conditions, OPA generates error
package main

message := "Unsafe image ngins" if {
	has_unsafe_image_nginx
}

message := "Should not run as root user" if {
	runs_as_root
}

# Want to incrementally ass messages to the collection of errors returned to the user. Think of message as a set.
# assign "Unsafe image nginx" to set message if
# 	has_unsafe_image_nginx
# assing "Should not run as root user" to set message if
# 	runs_as_root
# In practice, use the variable name deny instead of message.

# Recall syntax for checking if an element belongs to a set

# check if "Unsafe image nginx" belongs to set deny
# deny["Unsafe image nginx"]

# Partial set rules ASSIGN  elements to a set using the same syntax as checking whether an element belongs to the
# set.
deny["Unsafe image nginx"] if { # "Unsafe image nginx belongs" to deny IF}
	has_unsafe_image_nginx # has_unsafe_image_nginx is true
}

deny["Should not run as root user"] if {
	runs_as_root
}

# variable 'deny' is a set
# deny evaluates to
# { "Unsafe image nginx", "Should not run as root user" }

# Can user variables to construct set elements

deny[msg] if {
	has_unsafe_image_nginx
	msg := sprintf(
		"%v has unsafe image nginx",
		[input.request.object.metadata.name],
	)
}

# Every resource myst hav an owner label
deny["Owner label nyst exists"] if {
	# Check if the owner label is missing
	not input.request.object.metadata.lables.owner # true
}

# The costcenter label (if it exists) must start with `cccode-`

deny[ms] if {
	# Lookup the value of the costcenter label value
	value := input.request.object.metadata.lables.costcenter # "cccode-123"

	# Check if the label value is formatted correctly
	not staartswith(value, "cccode-")

	# Construct an error message to return to the user
	msg := sprintf("Costcenter code %v must start with `cccode-` ", [value])
}

# Example outcomes for evaluating deny
# {} # Neither rule succeeds
# {"Owner label must exist"} # First rule succeeds
# {"Costcenter code foor123 must start with `cccode-` "} # Second rule succeeds
