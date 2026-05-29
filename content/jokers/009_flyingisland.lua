Orchid.joker {
    key = "flyingisland",
    atlas = 'jokers',
    atlas_id = 9,

    cost = 6,
    rarity = 2,

    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    unlocked = true,
    discovered = true,

    config = { extra = { odds = 12, dollars = 1 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME.probabilities.normal, card.ability.extra.odds, card.ability.extra.dollars } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local scored = context.other_card

            if not SMODS.has_no_rank(scored) and not scored:is_face() then
                local prob_bonus = scored:get_id()
                local numerator = math.min(G.GAME.probabilities.normal + prob_bonus, card.ability.extra.odds)

                if Orchid.prob_check(numerator, card.ability.extra.odds, card.config.center.key) then
                    return {
                        dollars = card.ability.extra.dollars,
                        card = card
                    }
                end
            end
        end
    end
}
