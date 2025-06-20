package rules

default allow := false

# allow if {
# 	user_is_manager
# }

allow if {
	# only employees can GET /cars/{carid}
	user_is_employee
	input.method == "GET"
	input.path = ["cars", carid]
}

users := {
	"alice": {"manager": "charlie", "title": "salesperson"},
	"bob": {"manager": "charlie", "title": "salesperson"},
	"charlie": {"manager": "dave", "title": "manager"},
	"dave": {"manager": null, "title": "ceo"},
}

user_is_employee if {
	users[input.user]
}

user_is_manager if {
	users[input.user].title != "salesperson"
}

user_is_manager if {
	u := users[input.user]
	not u.title == "salesperson"
}

user_is_manager if {
	u := users[input.user]
	u.title != "salesperson"
}

user_is_manager if {
users[input.user].title == "ceo"
}

test_car_read_negative if {
	inp = {
		"method": "POST",
		"path": ["nonexistent"],
		"user": "alice",
	}
	allow == false with input as inp
}

test_car_read_positive if {
	inp = {
		"method": "POST",
		"path": ["cars"],
		"user": "charlie",
	}
	allow == true with input as inp
}
