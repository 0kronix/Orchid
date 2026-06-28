Orchid.joker {
    key = "ruth",
    atlas = 'jokers',
    atlas_id = 34,

    loc_txt = {
        name = "Ruth",
        text = {
            "Each {C:chips}Common {C:attention}Joker{} give",
            "{C:money}$#1#{} at end of round"
        },
    },

    cost = 6,
    rarity = 2,

    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    unlocked = true,
    discovered = true,

    config = { extra = { money = 1 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.money } }
    end,

    calc_dollar_bonus = function(self, card)
        local jokers = 0

        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].config.center.rarity == 1 then
                jokers = jokers + 1
            end
        end

        if jokers > 0 then
            return jokers * card.ability.extra.money
        end
    end
}
