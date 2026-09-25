#include "\x\cba\addons\main\script_macros_common.hpp"
#include "\x\cba\addons\xeh\script_xeh.hpp"
#include "\z\ace\addons\main\script_macros.hpp"

// --- ACE reference macros (this mod's PREFIX is avo, so EFUNC/EGVAR would resolve to avo_*) ---
#define ACE_PREFIX ace

#define ACEGVAR(component,var) TRIPLES(ACE_PREFIX,component,var)
#define QACEGVAR(component,var) QUOTE(ACEGVAR(component,var))

#define ACEFUNC(component,function) TRIPLES(DOUBLES(ACE_PREFIX,component),fnc,function)
#define QACEFUNC(component,function) QUOTE(ACEFUNC(component,function))

#define ACEPATHTOF(component,path) \z\ace\addons\component\path
#define QACEPATHTOF(component,path) QUOTE(ACEPATHTOF(component,path))

// --- ACRE reference macros ---
#define ACRE_PREFIX acre

#define ACREGVAR(component,var) TRIPLES(ACRE_PREFIX,component,var)
#define QACREGVAR(component,var) QUOTE(ACREGVAR(component,var))

#define ACREFUNC(component,function) TRIPLES(DOUBLES(ACRE_PREFIX,component),fnc,function)
#define QACREFUNC(component,function) QUOTE(ACREFUNC(component,function))

#define ACREPATHTOF(component,path) \idi\acre\addons\component\path
#define QACREPATHTOF(component,path) QUOTE(ACREPATHTOF(component,path))
