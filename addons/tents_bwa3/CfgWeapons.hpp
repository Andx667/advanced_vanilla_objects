// Config only: the tents addon finds this item through its avo_tents_object property
class CfgWeapons {
    class EGVAR(tents,base);

    class GVAR(smallFleck): EGVAR(tents,base) {
        scope = 2;
        displayName = CSTRING(smallFleck);
        EGVAR(tents,object) = "BWA3_Tent_small_Fleck";
    };
};
