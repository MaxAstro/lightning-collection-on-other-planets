for _, planet in pairs(data.raw["planet"]) do
    if not planet.lightning_properties then
        planet.lightning_properties = {
            lightnings_per_chunk_per_tick = 0,
            search_radius = 0,
            priority_rules =
            {
                {
                type = "id",
                string = "lightning-collector",
                priority_bonus = 10000
                }
            },
            exemption_rules = {},
            lightning_types = {"lightning"}
        }
    end
end