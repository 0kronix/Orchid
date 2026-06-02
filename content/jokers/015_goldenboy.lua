Orchid.joker {
    key = "goldenboy",
    atlas = 'jokers',
    atlas_id = 15,

    cost = 7,
    rarity = 3,

    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    unlocked = true,
    discovered = true,

    config = { extra = { dollars = 4 } },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.dollars
            }
        }
    end,

    calculate = function(self, card, context)

    end,
}
