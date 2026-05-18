SMODS.Joker {
    key = "lastphoto",
    atlas = 'jokers',
    pos = Orchid.get_atlas_pos(1, 6),

    pixel_size = { h = 95 / 1.2 },

    cost = 4,
    rarity = 1,

    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    unlocked = true,
    discovered = true,

    config = { extra = { dollars = 10 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end,

    calc_dollar_bonus = function(self, card)
        if G.GAME.blind and G.GAME.blind.boss then
            if G.GAME.current_round.hands_left == 0 then
                return card.ability.extra.dollars
            end
        end
    end
}
