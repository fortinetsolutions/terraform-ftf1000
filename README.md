**Summary**
Terraform Base with FG in AWS.

**Version**
Terraform v0.12.24 
https://releases.hashicorp.com/terraform/0.12.24/

**Topology**
This is a base network with a single FG, two upstream ports, and one LAN.

```
+-------------------------------------------------------------------+
|                              VPC                                  |
|                                                                   |
|                                                                   |
|           +-------------+              +-------------+            |
|           |10.0.101.0/24|              |10.0.102.0/24|            |
|           |             |              |             |            |
|           |   Subnet1   |              |   Subnet2   |            |
|           +------+------+              +-------+-----+            |
|                  |                             |                  |
|                  |                             |                  |
|                  |                             |                  |
|                  |      +--------------+       |                  |
|                  | Port1|              |Port2  |                  |
|                  +-----+|   FortiGate  |+------+                  |
|                         |              |                          |
|                         +------+-------+                          |
|                                |Port3                             |
|                                |                                  |
|                                |                                  |
|                         +------+------+                           |
|                         |10.0.200.0/24|                           |
|                         |             |                           |
|                         |   Subnet3   |                           |
|                         +-------------+                           |
|                                                                   |
|                                                                   |
|                                                                   |
|                                                                   |
+-------------------------------------------------------------------+
```

**Setup Instructions**
1) In AWS create your Key-Pair.
2) In AWS create an API user.
3) Run:
   ./terraform plan
   ./terraform apply
