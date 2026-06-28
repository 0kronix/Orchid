Orchid.joker {
    key = "3djoker",
    atlas = 'jokers',
    atlas_id = 18,

    loc_txt = {
        name = "3D Joker",
        text = {
            "{C:attention}Mult{} and {C:attention}Bonus{} cards",
            "count as {C:attention}face{} cards",
        }
    },

    cost = 6,
    rarity = 2,

    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    unlocked = true,
    discovered = true,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_mult
        info_queue[#info_queue + 1] = G.P_CENTERS.m_bonus
    end,
}
