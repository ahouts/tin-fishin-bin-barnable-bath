AddPrefabPostInitAny(function(inst)
    if not inst or inst.prefab ~= "fish_box" then
        return
    end
    local util = require("dst-util/util")(GLOBAL)

    local old_test_fn = util.access(inst, "components", "container", util.get_class, "itemtestfn")
    local old_fn = util.access(old_test_fn, 1)
    local container_replica = util.access(inst, "replica", util.get_class, "container")
    if util.any_nil(old_fn, container_replica) then
        util.error("implementation of Tin Fishin' Bin changed, contact mod author!")
        return
    end
    local new_fn = function(container, item, slot)
        return old_fn(container, item, slot) or (util.access(item, "prefab") == "barnacle")
    end

    old_test_fn[1] = new_fn
    container_replica.itemtestfn = new_fn
end)
