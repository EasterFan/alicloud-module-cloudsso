output "motd" {
    value   = module.vpc.motd
}
output "vpc" {
    value   = module.vpc.vpc
}
output "vswitch" {
    value   = module.vpc.vswitch
}
output "sg" {
    value   = module.vpc.sg
}
output "sg_rules" {
    value   = module.vpc.sg_rules
}