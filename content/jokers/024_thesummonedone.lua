Orchid.joker {
    key = "thesummonedone",
    atlas = 'jokers',
    atlas_id = 24,

    loc_txt = {
        name = "The Summoned One",
        text = {
            "If {C:attention}played hand{} contain",
            "only three {C:attention}6s{}, this Joker",
            "gains {X:mult,C:white}X#1#{} Mult and {C:red}destroy{}",
            "all played {C:attention}6s",
            "{C:inactive}(Currently {X:mult,C:white}X#2#{}{C:inactive} Mult){}"
        },
    },

    cost = 4,
    rarity = 1,

    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    unlocked = true,
    discovered = true,

    config = { extra = { mod_xmult = 1, cur_xmult = 1 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mod_xmult, card.ability.extra.cur_xmult } }
    end,

    calculate = function(self, card, context)
        if not context.blueprint then
            if context.before then
                if #context.full_hand == 3 then
                    if context.full_hand[1]:get_id() == 6 and
                        context.full_hand[2]:get_id() == 6 and
                        context.full_hand[3]:get_id() == 6 then
                        card.ability.extra.cur_xmult = card.ability.extra.cur_xmult + card.ability.extra.mod_xmult
                        delay(0.5)
                        for i = 1, #context.full_hand do
                            context.full_hand[i]:start_dissolve({ G.C.RED }, nil, 1.6)
                        end
                        SMODS.destroy_cards(context.full_hand, nil, nil, true)
                        delay(0.5)

                        return {
                            message = localize('k_upgrade_ex'),
                            colour = G.C.MULT
                        }
                    end
                end
            end
        end

        if context.joker_main then
            return {
                xmult = card.ability.extra.cur_xmult
            }
        end
    end
}
