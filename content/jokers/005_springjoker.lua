Orchid.joker {
    key = "springjoker",
    atlas = 'jokers',
    atlas_id = 5,

    cost = 7,
    rarity = 2,

    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    unlocked = true,
    discovered = true,

    config = { extra = { odds = 4, ret = 1 } },

    loc_vars = function(self, info_queue, card)
        local num, den = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
        return { vars = { num, den, card.ability.extra.ret } }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.play and context.repetition and not context.repetition_only then
            if Orchid.prob_check(G.GAME.probabilities.normal, card.ability.extra.odds, card.config.center.key) then
                if context.other_card:is_suit('Spades', true) then
                    return {
                        message = localize('k_again_ex'),
                        repetitions = card.ability.extra.ret,
                        messege_card = context.other_card
                    }
                end
            end
        end
    end
}
