package iteration

### Psevdo code
admins := ["alice", "bob", "charlie"]
# # Imperative thinking

# # check if input.user is equal to admins[i]
# input["user"] == admins[i]

# # iterate over array and return if found
# for i in admins:
#     if input["user"] == admins[i]
#         return true
# return false

# Declarative thinking in Rego
# check if input.user is equal to admins[i]
# input.user == admins[i]

# # there is some array element equal to input.user

# some i 
#     input.user == admins[i]

## Iterations with arrays

# input
user: alice
groups:
- engineering
- operations

admins := [
    "alice",
    "bob",
    "charlie"
]

admins2 := [
    {"user": "charlie", "level": 1},
    {"user": "alice", "level": 1},
    {"user": "bob", "level": 2}

]

# SOME iterates iver array indexes
is_admin {
    some i # in admins
        admins[i] == input.user
}

# Variables declared with SOME can be userd repeatedly
is_super_admin {
    some i # in admins2
        admins2[i].user == input.user
        admins2[i].level == 1
}

# No need for iteration if object's key is identical to input.user
is_admin {
    admins[input.user] == true
}

# SOME iterates over jbject keys and key/value pairs
is_admin {
    some name
        details := admins2[name] # admins2 has a value for key `name`
        lower(name) == lower(input.user)
}