Orchid.joker {
    key = "infinityjimbo",
    atlas = 'jokers',
    atlas_id = 38,

    loc_txt = {
        name = "Infinity Jimbo",
        text = {
            "{C:green}#1# in #2#{} chance to duplicate",
            "used {C:planet}Planet{} card"
        },
    },

    cost = 6,
    rarity = 2,

    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    unlocked = true,
    discovered = true,

    config = { extra = { odds = 3 } },

    loc_vars = function(self, info_queue, card)
        local num, den = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
        return { vars = { num, den, card.ability.extra.ret } }
    end,

    calculate = function(self, card, context)
        if not context.blueprint then
            if context.using_consumeable and context.consumeable.config.center.set == 'Planet' then
                if Orchid.prob_check(G.GAME.probabilities.normal, card.ability.extra.odds, card.config.center.key) and
                    #G.consumeables.cards < G.consumeables.config.card_limit - 1 then
                    local copy_card = copy_card(context.consumeable)

                    G.consumeables:emplace(copy_card)
                    copy_card:juice_up(0.5, 0.5)
                    card:juice_up(0.3, 0.5)
                end
            end
        end
    end
}
