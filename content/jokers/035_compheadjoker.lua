Orchid.joker {
    key = "compheadjoker",
    atlas = 'jokers',
    atlas_id = 35,

    loc_txt = {
        name = "Comphead Joker",
        text = {
            "{C:green}#1# in #2#{} chance that",
            "triggered {C:attention}Tag{} will",
            "create another {C:attention}random{} one",
        },
    },

    cost = 8,
    rarity = 3,

    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    unlocked = true,
    discovered = true,

    config = { extra = { odds = 3 } },

    loc_vars = function(self, info_queue, card)
        local num, den = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
        return { vars = { num, den } }
    end,

    calculate = function(self, card, context)
        if context.tag_triggered then
            if Orchid.prob_check(G.GAME.probabilities.normal, card.ability.extra.odds, card.config.center.key) then
                Orchid.create_tag(nil, card.config.center.key)
                return {
                    message = localize("orchid_plustag_ex")
                }
            end
        end
    end
}
