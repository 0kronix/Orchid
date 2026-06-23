Orchid.joker {
    key = "buttwoarebetter",
    atlas = 'jokers',
    atlas_id = 27,

    loc_txt = {
        name = "But Two are Better",
        text = {
            "{C:green}#1# in #2#{} chance to create",
            "a copy of purchased",
            "{C:attention}consumeable",
            "{C:inactive}(Must have room)"
        },
    },

    cost = 9,
    rarity = 3,

    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    unlocked = true,
    discovered = true,

    config = { extra = { odds = 6 } },

    loc_vars = function(self, info_queue, card)
        local num, den = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
        return { vars = { num, den } }
    end,

    calculate = function(self, card, context)
        if not context.blueprint then
            if context.buying_card then
                local ccard = context.card

                if not (ccard.config.center.set == 'Joker') then
                    if Orchid.prob_check(G.GAME.probabilities.normal, card.ability.extra.odds, card.config.center.key) and
                        #G.consumeables.cards < G.consumeables.config.card_limit - 1 then
                        local copy_card = copy_card(ccard)

                        G.consumeables:emplace(copy_card)
                        copy_card:juice_up(0.5, 0.5)
                        card:juice_up(0.3, 0.5)
                    end
                end
            end
        end
    end
}
