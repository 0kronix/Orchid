Orchid.joker {
    key = "blackclover",
    atlas = 'jokers',
    atlas_id = 7,

    cost = 6,
    rarity = 2,

    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    unlocked = true,
    discovered = true,

    config = { extra = { dollars = 4 } },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky
        return { vars = { card.ability.extra.dollars } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit('Clubs', true) and SMODS.has_enhancement(context.other_card, 'm_lucky') then
                return {
                    dollars = card.ability.extra.dollars,
                    card = card,
                }
            end
        end
    end
}
