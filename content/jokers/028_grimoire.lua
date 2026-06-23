Orchid.joker {
    key = "grimoire",
    atlas = 'jokers',
    atlas_id = 28,

    loc_txt = {
        name = "Grimoire",
        text = { {
            "{X:mult,C:white}X#1#{} Mult",
        }, {
            "Lose {X:mult,C:white}-X#2#{} Mult for",
            "each unique {C:attention}enhancement",
            "in {C:attention}full deck"
        } },
    },

    cost = 5,
    rarity = 1,

    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    unlocked = true,
    discovered = true,

    config = { extra = { max_xmult = 3, cur_xmult = 3, mod_xmult = 0.25 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.cur_xmult, card.ability.extra.mod_xmult } }
    end,

    update = function(self, card, dt)
        card.ability.extra.cur_xmult = math.max(0.25,
            card.ability.extra.max_xmult - card.ability.extra.mod_xmult * #Orchid.get_unique_enh())
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.cur_xmult
            }
        end
    end
}
