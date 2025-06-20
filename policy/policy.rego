package policy

import future.keywords.if

default allow := false

allow if {
	input.method == "GET"
	input.path == ["cars"]
	input.user == "alice"
}

test_car_read_positive if {
	inp = {
		"method": "GET",
		"path": ["cars"],
		"user": "alice",
	}
	allow == true with input as inp
}

test_car_read_negative if {
	inp = {
		"method": "GET",
		"path": ["nonexistent"],
		"user": "alice",
	}
	allow == false with input as inp
}
