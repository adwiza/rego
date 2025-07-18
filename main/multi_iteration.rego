package multi_iteration

# input
user: alice
groups:
- engineering
- operations

# WARNING Avoid hard-coding usr-names in policies. Use groups/roles/attributes.
admin_groups := [
    "admin",
    "superuser",
    "root"

]

# Check if user is in the "root" group
is_admin {
    some i
        input.groups[i] == "root"
}

# Minimize hard-coding group-names using an array
is_admin {                                 # is_admin is true IF
    some i, j                              # there is some i and  some j such that ...
        input.groups[i] == admin_groups[j]
}

# SOME declared intent, not computation. Ordering of SOME is irrelevant.

is_admin {                                # is_admin is true IF
    some j                                # there is some j AND
    some i                                # there is some i such that
        input.groups[i] == admin_groups[j]
}

# Multi-iteratin can be userd with nested composites too

has_read_only_mount {
    some i, j
        input.request.object.spec.containers[i].volumeMounts[j].readonly == true
        }

# Configuraion authorization: all images must come from hooli.com

deny[msg] {
    input.request.kind.kind == "Pod"
    some i
        image := input.request.object.spec.containers[i].image
        not startswith(image, "hooli.com/")
        msg := sprintf("Image %v comes from unsafe repository", [image])
}

#If there is nothing finite to iterate over, OPA calls the variable "unsafe"
foo[x] {
    some x
        x > 14 # COMPILE ERROR: unsafe expression
}