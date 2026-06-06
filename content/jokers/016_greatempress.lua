Orchid.joker {
    key = "greatempress",
    atlas = 'jokers',
    atlas_id = 16,

    cost = 6,
    rarity = 2,

    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    unlocked = true,
    discovered = true,

    config = { extra = { odds = 4 } },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.p_arcana_normal_1
        info_queue[#info_queue + 1] = G.P_CENTERS.p_spectral_normal_1
        info_queue[#info_queue + 1] = G.P_CENTERS.c_empress
        local num, den = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
        return { vars = { num, den } }
    end,

    calculate = function(self, card, context)
        if context.modify_booster_card and not context.blueprint then
            local kind = context.booster and context.booster.config.center.kind
            if kind ~= 'Arcana' and kind ~= 'Spectral' then return end

            local seed = card.config.center.key .. '_empress_' .. (context.index or 0)
            if Orchid.prob_check(G.GAME.probabilities.normal, card.ability.extra.odds, seed) then
                context.card:set_ability(G.P_CENTERS.c_empress, nil, true)
            end
        end
    end,
}
