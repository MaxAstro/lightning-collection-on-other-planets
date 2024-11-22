-- Calculates the chance of a lightning spawn
---@param range double
---@param magnetic_field double
---@return boolean
function lightning_chance(range, magnetic_field)
    if math.random(100) > magnetic_field then return false end      -- Magnetic field/100 chance to pass this check
    local range_chance = range ^ 1.2                                -- Range_chance is out of 250; this will roughly be 20% at normal quality,
    if math.random(250) > range_chance then return false end        -- 60% at vanilla legendary, and 100% at quality 10 or higher
    return true
end

-- Calculates the range value of a lightning collector
-- This is the smaller of the collector's max range, or the distance to the nearest collector minus a penalty for the number of nearby collectors
---@param lightning_collector LuaEntity
---@return double
function get_range_value(lightning_collector)
    local surface = lightning_collector.surface
    local prototype = lightning_collector.prototype --[[@as data.LightningAttractorPrototype]]
    local collection_range = prototype.range_elongation
    local quality_effect = lightning_collector.quality.level * 7.5      -- Each level of quality adds 7.5 range to a lightning collector
    collection_range = collection_range + quality_effect
    penalty_range = collection_range * 0.75                             -- Lightning collectors within 75% of max range add an extra penalty
    local penalty = 0
    local night_factor = 0.25 + surface.darkness                        -- Range is adjusted by surface darkness; in the middle of the night (darkness=0.85) there is a small bonus
    collection_range = collection_range * night_factor

    -- Locate all nearby entities of type "lightning-attractor" - even though rods can't spawn lightning, they still apply a penalty if nearby
    attractors = surface.find_entities_filtered{
        position = lightning_collector.position,
        radius = collection_range,
        type = "lightning-attractor"
    }
    for _, attractor in pairs(attractors) do
        local distance = util.distance(lightning_collector.position, attractor.position)
        if distance < collection_range then
            collection_range = distance         -- Reduce the effective range to the range to the nearest collector
        end
        if distance > penalty_range then
            penalty = penalty + 1               -- Each nearby collector adds a one tile penalty to effective range
        end
    end
    return collection_range - penalty           -- A negative number for the range check means an alert should be shown
end

---@param event NthTickEventData
function do_lightning_check(event)
    for _, surface in pairs(game.surfaces) do
        magnetic_field = surface.get_property("magnetic-field")
        if magnetic_field < 99 and surface.darkness >= 0.4 then     -- Skip running on surfaces with a magnetic field of 99 (i.e. Fulgora), and during the day
            lightning_collectors = surface.find_entities_filtered{name = "lightning-collector"}
            for _, lightning_collector in pairs(lightning_collectors) do
                local range = get_range_value(lightning_collector)  -- Calculate the effective range of the collector
                if range < 0 then                                   -- Send an alert if the collector is too clustered
                    for _, player in lightning_collector.force.players do
                        ---@cast player LuaPlayer
                        player.add_custom_alert(lightning_collector, {type = "entity", name = "lightning-collector"}, "lcoop-custom-alerts.lcoop-too-clustered-alert", true)
                    end
                else
                    for _, player in lightning_collector.force.players do   -- Remove alert if there is one
                        ---@cast player LuaPlayer
                        player.remove_alert{entity = lightning_collector, message = "lcoop-custom-alerts.lcoop-too-clustered-alert"}
                    end
                    local tick_rate = settings.global["lcoop-check-frequency-setting"].value      --[[@as integer]]
                    local base_chance = 0.1 * tick_rate / 60                -- Base chance of lightning is 10% per second, regardless of check frequency
                                                                            -- On Nauvis, this means that a normal quality lightning collector will average two strikes per night
                                                                            -- A legendary quality collector will average around seven strikes per night
                    base_chance = base_chance + 1                           -- Debug code
                    if math.random() <= base_chance and lightning_chance(range, magnetic_field) then
                        local lightning_x = lightning_collector.position.x - 2 + math.random(4)   -- Slightly randomize the lightning location for visual variety
                        local lightning_y = lightning_collector.position.y - 2 + math.random(4)
                        surface.execute_lightning{name = "lightning", position = {lightning_x, lightning_y}}
                    end
                end
            end
        end
    end
end

script.on_nth_tick(settings.global["lcoop-check-frequency-setting"].value --[[@as integer]], do_lightning_check)