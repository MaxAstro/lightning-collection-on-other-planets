-- Lightning collector check frequency
local check_frequency_setting = {
    type = "int-setting",
    name = "lcoop-check-frequency-setting",
    setting_type = "runtime-global",
    order = "a",
    maximum_value = 240,
    minimum_value = 1,
    default_value = 60,
}

data:extend({
    check_frequency_setting
})