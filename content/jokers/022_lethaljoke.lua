Orchid.joker {
    key = "lethaljoke",
    atlas = 'jokers',
    atlas_id = 22,

    loc_txt = {
        name = "Lethal Joke",
        text = {
            "{X:mult,C:white}X#1#{} Mult,",
            "Scoring {C:attention}#2#{}, {C:attention}#3#{} or {C:attention}#4#{}",
            "{C:red}destroys{} this Joker",
            "{C:inactive}(Ranks change each round){}",
        },
    },

    cost = 4,
    rarity = 1,

    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,

    unlocked = true,
    discovered = true,

    config = { extra = { xmult = 3, rank_count = 3, ranks = {} } },

    loc_vars = function(self, info_queue, card)
        local ranks = card.ability.extra.ranks
        if not ranks or #ranks < card.ability.extra.rank_count then
            ranks = Orchid.pick_ranks(
                card.ability.extra.rank_count,
                card.config.center.key .. '_preview'
            )
            card.ability.extra.ranks = ranks
        end

        return {
            vars = {
                card.ability.extra.xmult,
                localize(ranks[1].key, 'ranks') or "?",
                localize(ranks[2].key, 'ranks') or "?",
                localize(ranks[3].key, 'ranks') or "?",
            }
        }
    end,

    add_to_deck = function(self, card, from_debuff)
        if not from_debuff then
            card.ability.extra.ranks = Orchid.pick_ranks(
                card.ability.extra.rank_count,
                card.config.center.key .. '_start_' .. G.GAME.round_resets.ante
            )
        end
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult,
            }
        end

        if context.individual
            and context.cardarea == G.play
            and not context.blueprint
            and not card.getting_sliced then
            if Orchid.rank_in_list(context.other_card, card.ability.extra.ranks) then
                card.getting_sliced = true

                G.E_MANAGER:add_event(Event({
                    func = function()
                        card:start_dissolve({ G.C.RED }, nil, 1.6)
                        play_sound('slice1', 0.96 + math.random() * 0.08)
                        return true
                    end
                }))
            end
        end

        if context.end_of_round
            and not context.repetition
            and not context.individual
            and not context.blueprint
            and not card.getting_sliced then
            card.ability.extra.ranks = Orchid.pick_ranks(
                card.ability.extra.rank_count,
                card.config.center.key .. '_round_' .. G.GAME.round_resets.ante .. '_' .. G.GAME.hands_played
            )

            return {
                message = localize('k_reset'),
            }
        end
    end
}
