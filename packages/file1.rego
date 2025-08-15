package api.authz.retail

# Each team can write policies for their domain of expertise
package authz.compute
allow if { ... }

allow if user_in_admin
allow if method_is_read


# Packages anable user by multiple clients
# OPA loads all packages simultaneously

# Client chooses which package and document to evaluate

PUT localhost:8181/v1/data/api/authz/retail/allow <input>
=> { "result": true}