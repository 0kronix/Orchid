Orchid.joker {
    key = "tinyhatjoker",
    atlas = 'jokers',
    atlas_id = 13,

    cost = 7,
    rarity = 2,

    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    unlocked = true,
    discovered = true,

    config = { extra = { tags = 2, mod_xchips = 0.3, cur_xchips = 1 } },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.tags,
                card.ability.extra.mod_xchips,
                card.ability.extra.cur_xchips
            }
        }
    end,

    calculate = function(self, card, context)
        if (context.tag_added or context.tag_triggered) and not context.blueprint then
            card.ability.extra.cur_xchips = 1 +
                math.floor(#G.GAME.tags / card.ability.extra.tags) * card.ability.extra.mod_xchips
        end

        if context.joker_main then
            return {
                xchips = card.ability.extra.cur_xchips
            }
        end
    end,
}
