AddPrefabPostInitAny(function(inst)
    if not inst or inst.prefab ~= "fish_box" then
        return
    end
    local old_fn = GLOBAL.rawget(inst.components.container, "_").itemtestfn[1]
    local new_fn = function(container, item, slot)
        return old_fn(container, item, slot) or (item and item.prefab == "barnacle")
    end
    GLOBAL.rawget(inst.components.container, "_").itemtestfn[1] = new_fn
    GLOBAL.rawget(inst.replica, "_").container.itemtestfn = new_fn
end)
