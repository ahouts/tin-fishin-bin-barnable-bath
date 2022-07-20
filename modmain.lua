AddPrefabPostInitAny(function(inst)
    if not inst or inst.prefab ~= "fish_box" then
        return
    end
    local util = require("dst-util/util")(GLOBAL)
    local type = require("dst-util/type")(util)

    local container_instance_type = type.Table({
        components = type.Table({
            container = type.Class("Container", {
                itemtestfn = type.Table({
                    type.Function(),
                }),
            }),
        }),
        replica = type.Class("Replica", {
            container = type.Table({
                itemtestfn = type.Function(),
            }),
        }),
    })

    if not type.type_check(container_instance_type, inst) then
        util.modprint(container_instance_type.describe())
        util.display(inst)
        util.error("implementation of Tin Fishin' Bin changed, contact mod author!")
        return
    end
    local old_fn = util.get_class(inst.components.container).itemtestfn[1]
    local new_fn = function(container, item, slot)
        return old_fn(container, item, slot) or (util.access(item, "prefab") == "barnacle")
    end

    util.get_class(inst.components.container).itemtestfn[1] = new_fn
    util.get_class(inst.replica).container.itemtestfn = new_fn
end)
