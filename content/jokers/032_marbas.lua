Orchid.joker {
    key = "marbas",
    atlas = 'jokers',
    atlas_id = 32,

    loc_txt = {
        name = "Marbas",
        text = {
            "Using {C:tarot}Tarot{} card also",
            "level up {C:attention}Straight"
        },
    },

    cost = 4,
    rarity = 1,

    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    unlocked = true,
    discovered = true,

    config = { extra = {} },

    loc_vars = function(self, info_queue, card)

    end,

    calculate = function(self, card, context)
        if not context.blueprint then
            if context.using_consumeable and context.consumeable.config.center.set == 'Tarot' then
                SMODS.smart_level_up_hand(context.consumeable, "Straight", nil, 1)
            end
        end
    end
}
