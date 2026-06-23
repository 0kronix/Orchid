Orchid.joker {
    key = "chipsup",
    atlas = 'jokers',
    atlas_id = 20,

    loc_txt = {
        name = "Chips Upgrade Plate",
        text = {
            "Give each scored",
            "{C:attention}Bonus{} Card {C:chips}+8{} Chips",
            "permanently"
        }
    },

    cost = 4,
    rarity = 1,

    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    unlocked = true,
    discovered = true,

    config = { extra = { chips_bonus = 8 } },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_bonus

        return { vars = { card.ability.extra.chips_bonus } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local target = context.other_card

            if SMODS.has_enhancement(target, 'm_bonus') then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        target.ability.perma_bonus = (target.ability.perma_bonus or 0) + card.ability.extra.chips_bonus
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
