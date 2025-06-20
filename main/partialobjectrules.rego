package rules

# Objects are sometimes challenging to define in a single rule

authz := {
	"allowed": allow, # If either allow or code are undefined, so is authz.
	"code": code,
}

# To simplify upper claim if allow is undefined or code is undefined whole authz variable is undefined

# Partial object syntax lets you assign 1 key at a time

# authz["allowed"] := allow # authz defaults to the empty object, so is always defined
# authz["code"] := code

# Partial objects are defined with rules

admin["allowed"] := allow
authz["code"] := 200 if allow
authz["code"] := 403 if not allow
