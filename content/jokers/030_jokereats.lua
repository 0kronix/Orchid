Orchid.joker {
    key = "jokereats",
    atlas = 'jokers',
    atlas_id = 30,

    loc_txt = {
        name = "Joker Eats",
        text = {
            "Skipping a {C:attention}Booster Pack",
            "level up random hand"
        },
    },

    cost = 5,
    rarity = 1,

    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    unlocked = true,
    discovered = true,

    config = { extra = {} },

    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,

    calculate = function(self, card, context)
        if context.skipping_booster then
            local random_hand = pseudorandom_element(Orchid.get_visible_hands(), card.config.center.key)
            SMODS.smart_level_up_hand(card, random_hand, nil, 1)
        end
    end
}
