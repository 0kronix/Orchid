Orchid.joker {
    key = "agameaboutjumpingcube",
    atlas = 'jokers',
    atlas_id = 29,

    loc_txt = {
        name = "A Game About Jumping Cube",
        text = {
            "Gains {C:chips}+#1#{} Chips at {C:attention}end of round{}.",
            "Loses {C:chips}-#2#{} Chips for each",
            "scored {C:spades}Spades{} card",
            "{C:inactive}(Currently {C:chips}+#3#{}{C:inactive} Chips)"
        },
    },

    cost = 4,
    rarity = 1,

    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    unlocked = true,
    discovered = true,

    config = { extra = { pmod_chips = 10, nmod_chips = 5, cur_chips = 0 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.pmod_chips, card.ability.extra.nmod_chips, card.ability.extra.cur_chips } }
    end,

    calculate = function(self, card, context)
        if not context.blueprint then
            if context.end_of_round and context.cardarea == G.jokers then
                card.ability.extra.cur_chips = card.ability.extra.cur_chips + card.ability.extra.pmod_chips

                return {
                    message = localize("k_upgrade_ex"),
                    colour = G.C.CHIPS
                }
            end

            if context.individual and context.cardarea == G.play then
                local ccard = context.other_card

                if ccard:is_suit('Spades', true) and card.ability.extra.cur_chip >= card.ability.extra.nmod_chips then
                    card.ability.extra.cur_chips = card.ability.extra.cur_chips - card.ability.extra.nmod_chips

                    return {
                        message = localize("orchid_degrade_ex"),
                        colour = G.C.CHIPS,
                        message_card = card,
                        card = card
                    }
                end
            end
        end

        if context.joker_main then
            return {
                chips = card.ability.extra.cur_chips
            }
        end
    end
}
