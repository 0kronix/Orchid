Orchid.joker {
    key = "multup",
    atlas = 'jokers',
    atlas_id = 21,

    cost = 4,
    rarity = 1,

    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    unlocked = true,
    discovered = true,

    config = { extra = { mult_bonus = 1 } },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_mult

        return { vars = { card.ability.extra.mult_bonus } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local target = context.other_card

            if SMODS.has_enhancement(target, 'm_mult') then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        target.ability.perma_mult = (target.ability.perma_mult or 0) + card.ability.extra.mult_bonus
                        play_sound('card1')
                        target:juice_up(0.3, 0.3)
                        return true
                    end
                }))
                delay(0.5)
            end
        end
    end,
}
