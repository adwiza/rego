package api.authz.engineering

# Each team  can write policies for their domain of expertise

package authz.network
allow if { ... }

allow if { user_is_admin }
allow if { method_is_read; user_is_authenticated }

packager authz.constants

pi := 3.1415
e  := 2.718
golden := 1.618