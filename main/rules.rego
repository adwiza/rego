package main

import data.policy.role
import future.keywords.if

allow_review if { # allow a customer with reputation >=0 to review
	input.role == "customer"
	input.reputation >= 0
}

allow_delete if { # allow a moderator to delete
	role.is_moderator == true
}

## TEST CASES ##

# Typical form

# test_NAME if {
# 	EXPECTATION_CONDITION with input as TESTING_INPUT
# }

test_allow_review if {
	allow_review == true with input as {"role": "customer", "reputation": 0}
}

test_disallow_review_non_customer if {
	not allow_review with input as {"role": "foo", "reputation": 0}
}

test_allow_delete if {
	allow_delete with role.is_moderator as true
}

