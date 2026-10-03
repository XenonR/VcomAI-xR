# Inactive legacy experiments

This directory preserves the unregistered prototypes, old alternatives, and
copied scripts from the original function directory. It is not included by
CfgFunctions, CBA registration, or mission startup.

These files are references, not supported runtime entry points. To revive an
experiment, move the required implementation into its owning feature module,
remove assumptions about demo objects, document its interface/locality, and
register and validate it explicitly. Do not load this directory automatically.
