Orchid.joker {
    key = "mindofglory",
    atlas = 'jokers',
    atlas_id = 12,

    loc_txt = {
        name = "Mind of Glory",
        text = {
            "This Joker gains {X:mult,C:white}X#1#{} Mult",
            "if played hand contains",
            "the {C:attention}previous{} one,",
            "otherwise loses {X:mult,C:white}X#2#{} Mult",
            "{C:inactive}(Currently {X:mult,C:white}X#3#{}{C:inactive}, Previous: {C:attention}#4#{}{C:inactive}){}",
        },
    },

    cost = 8,
    rarity = 3,

    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    unlocked = true,
    discovered = true,

    config = { extra = { cur_xmult = 1, mod_xmult = 0.1, hand = "None" } },

    loc_vars = function(self, info_queue, card)
        local prev = card.ability.extra.hand
        local prev_name = "None"
        if prev and prev ~= "None" and G.GAME.hands[prev] then
            prev_name = localize(prev, 'poker_hands')
        end
        return {
            vars = {
                card.ability.extra.mod_xmult,
                card.ability.extra.mod_xmult / 2,
                card.ability.extra.cur_xmult,
                prev_name,
            }
        }
    end,

    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local ret
            local prev = card.ability.extra.hand
            if prev ~= "None" and context.poker_hands[prev] and next(context.poker_hands[prev]) then
                card.ability.extra.cur_xmult = card.ability.extra.cur_xmult + card.ability.extra.mod_xmult
                ret = {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT,
                    card = card
                }
            else
                if card.ability.extra.cur_xmult >= 1 + card.ability.extra.mod_xmult / 2 then
                    card.ability.extra.cur_xmult = card.ability.extra.cur_xmult - card.ability.extra.mod_xmult / 2
                    ret = {
                        message = localize('orchid_degrade_ex'),
                        colour = G.C.MULT,
                        card = card
                    }
                end
            end
            card.ability.extra.hand = context.scoring_name
            return ret
        end

        if context.joker_main then
            return {
                xmult = card.ability.extra.cur_xmult
            }
        end
    end,
}
