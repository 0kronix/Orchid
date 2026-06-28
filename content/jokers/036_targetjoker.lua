Orchid.joker {
    key = "targetjoker",
    atlas = 'jokers',
    atlas_id = 36,

    loc_txt = {
        name = "Target Joker",
        text = {
            "Playing hand {C:attention}#1#{} times in a row",
            "{C:attention}level up{} it {C:attention}#2#{} times",
            "{C:inactive}(Current: {C:attention}#3#{}{C:inactive}, {C:attention}#4#{}{C:inactive} )"
        },
    },

    cost = 8,
    rarity = 3,

    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    unlocked = true,
    discovered = true,

    config = { extra = { hands = 3, levels = 3, hand = "None", cur_hands = 0 } },

    loc_vars = function(self, info_queue, card)
        local h = card.ability.extra.hand
        local hname = "None"
        if h and h ~= "None" and G.GAME.hands[h] then
            hname = localize(h, 'poker_hands')
        end

        return { vars = { card.ability.extra.hands, card.ability.extra.levels, hname, card.ability.extra.cur_hands } }
    end,

    calculate = function(self, card, context)
        if context.after then
            if card.ability.extra.hand == SMODS.last_hand.scoring_name then
                card.ability.extra.cur_hands = card.ability.extra.cur_hands + 1

                if card.ability.extra.cur_hands >= card.ability.extra.hands then
                    SMODS.smart_level_up_hand(card, SMODS.last_hand.scoring_name, nil, card.ability.extra.levels)
                    card.ability.extra.hand = "None"
                    card.ability.extra.cur_hands = 0
                end
            else
                card.ability.extra.hand = SMODS.last_hand.scoring_name
                card.ability.extra.cur_hands = 1
            end
        end
    end
}
