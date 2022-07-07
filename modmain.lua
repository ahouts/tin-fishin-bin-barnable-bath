AddPrefabPostInitAny(function(inst)
    if not inst or inst.prefab ~= "fish_box" then
        return
    end
    local util = require("dst-util/util")(GLOBAL)

    local old_fn = util.access(inst, "components", "container", util.get_class, "itemtestfn", 1)
    if old_fn == nil then
        util.error("implementation of Tin Fishin' Bin changed, contact mod author!")
        return
    end
    local new_fn = function(container, item, slot)
        return old_fn(container, item, slot) or (util.access(item, "prefab") == "barnacle")
    end

    util.access(inst, "components", "container", util.get_class, "itemtestfn")[1] = new_fn

    local container_replica = util.access(inst, "replica", util.get_class, "container")
    if container_replica == nil then
        util.error("implementation of Tin Fishin' Bin replica changed, contact mod author!")
        return
    end
    container_replica.itemtestfn = new_fn
end)
