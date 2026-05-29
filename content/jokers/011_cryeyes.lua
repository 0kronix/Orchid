Orchid.joker {
    key = "cryeyes",
    atlas = 'jokers',
    atlas_id = 11,

    cost = 5,
    rarity = 1,

    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    unlocked = true,
    discovered = true,

    config = { extra = { cur_chips = 0, mod_chips = 2 } },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mod_chips,
                card.ability.extra.cur_chips,
            }
        }
    end,

    calculate = function(self, card, context)
        if context.ending_shop and not context.blueprint then
            local unpurchased = Orchid.count_shop_items()

            if unpurchased > 0 then
                card.ability.extra.cur_chips = card.ability.extra.cur_chips + unpurchased * card.ability.extra.mod_chips
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.CHIPS,
                    card = card,
                }
            end
        end

        if context.joker_main and card.ability.extra.cur_chips > 0 then
            return {
                chips = card.ability.extra.cur_chips,
                card = card,
            }
        end
    end,
}
