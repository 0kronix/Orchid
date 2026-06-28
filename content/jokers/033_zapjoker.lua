Orchid.joker {
    key = "zapjoker",
    atlas = 'jokers',
    atlas_id = 33,

    loc_txt = {
        name = "Zap Joker",
        text = {
            "{X:mult,C:white}X#2#{} Mult if adjacent {C:attention}Jokers",
            "shares the same rarity,",
            "otherwise {C:chips}+#1#{} Chips"
        },
    },

    cost = 7,
    rarity = 2,

    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    unlocked = true,
    discovered = true,

    config = { extra = { chips = 80, xmult = 1.5 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.xmult } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local left_joker, right_joker

            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    left_joker = G.jokers.cards[i - 1]
                    right_joker = G.jokers.cards[i + 1]
                end
            end

            if left_joker and right_joker and left_joker.config.center.rarity == right_joker.config.center.rarity then
                return {
                    xmult = card.ability.extra.xmult
                }
            else
                return {
                    chips = card.ability.extra.chips
                }
            end
        end
    end
}
