Orchid.joker {
    key = "rockpaperjoker",
    atlas = 'jokers',
    atlas_id = 10,

    cost = 3,
    rarity = 1,

    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,

    unlocked = true,
    discovered = true,

    config = { extra = { sell = 1, hand = 'Flush' } },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.sell,
                localize(card.ability.extra.hand, 'poker_hands'),
            }
        }
    end,

    add_to_deck = function(self, card, from_debuff)
        if not from_debuff then
            card.ability.extra.hand = Orchid.pick_hand(nil, card.config.center.key)
        end
    end,

    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local ret
            if context.scoring_name == card.ability.extra.hand then
                card.ability.extra_value = (card.ability.extra_value or 0) + card.ability.extra.sell
                card:set_cost()
                ret = {
                    message = localize('k_val_up'),
                    colour = G.C.MONEY,
                    card = card
                }
            end
            card.ability.extra.hand = Orchid.pick_hand(card.ability.extra.hand, card.config.center.key)
            return ret
        end
    end,
}
