package api.authz.engineering
package api.authz2 #  COMPILE ERROR

allow if { ... }

# 'main' policy can choose how and when to delegate decisions to each policy

package authz.main

allow if {
    input_is_compute
    data.authz.compute.allow
}

allow if {
    input_is_networking
    data.authz.network.allow
} 

