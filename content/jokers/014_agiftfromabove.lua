Orchid.joker {
    key = "agiftfromabove",
    atlas = 'jokers',
    atlas_id = 14,

    cost = 3,
    rarity = 1,

    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,

    unlocked = true,
    discovered = true,

    config = { extra = { rounds = 4, tags = 2, dollars = 10, hands = 1, cur_rounds = 0 } },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.rounds,
                card.ability.extra.tags,
                card.ability.extra.dollars,
                card.ability.extra.hands,
                card.ability.extra.cur_rounds
            }
        }
    end,

    calculate = function(self, card, context)
        local ret
        if context.end_of_round and not context.blueprint and card.ability.extra.cur_rounds < card.ability.extra.rounds
            and context.game_over == false and context.main_eval then
            card.ability.extra.cur_rounds = card.ability.extra.cur_rounds + 1

            ret = {
                message = card.ability.extra.cur_rounds .. '/' .. card.ability.extra.rounds
            }
            if card.ability.extra.cur_rounds >= card.ability.extra.rounds then
                local choose = pseudorandom(card.config.center.key, 0, 3)

                if choose < 1 then
                    for i = 1, card.ability.extra.tags do
                        Orchid.create_tag(nil, card.config.center.key)
                    end
                elseif choose > 2 then
                    G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
                else
                    ret = {
                        dollars = card.ability.extra.dollars
                    }
                end
                SMODS.destroy_cards(card)
            end

            return ret
        end
    end,
}
