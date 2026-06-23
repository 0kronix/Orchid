Orchid.joker {
    key = "tinyhatjoker",
    atlas = 'jokers',
    atlas_id = 13,

    loc_txt = {
        name = "Tiny Hat Joker",
        text = {
            "Every Tag give {C:mult}+#1#{} Mult",
            "{C:inactive}(Currently {C:mult}+#2#{}{C:inactive}){}",
        },
    },

    cost = 5,
    rarity = 1,

    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    unlocked = true,
    discovered = true,

    config = { extra = { mod_mult = 10, cur_mult = 0 } },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mod_mult,
                card.ability.extra.cur_mult
            }
        }
    end,

    calculate = function(self, card, context)
        if (context.tag_added or context.tag_triggered) and not context.blueprint then
            card.ability.extra.cur_mult = #G.GAME.tags * card.ability.extra.mod_mult
        end

        if context.joker_main then
            return {
                xchips = card.ability.extra.cur_mult
            }
        end
    end,
}
