# Packages can contain common code
package util.user_in_admin
is_authenticated { ... }
us_admin { ... }


# Use DATA to reference rules in other packages
package api.retail

allow {
    method_is_read
    data.util.user.is_authenticated
}

# Alias long package paths with IMPORTS
package api.retailimport data.util.user # as u
allow {
    method_is_read
    user.is_authenticated
}

