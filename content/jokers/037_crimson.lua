Orchid.joker {
    key = "crimson",
    atlas = 'jokers',
    atlas_id = 37,

    loc_txt = {
        name = "Crimson",
        text = {
            "Scored {C:hearts}Hearts{} card turn",
            "{C:attention}adjacent{} cards into {C:hearts}Hearts{}",
            "after scoring"
        },
    },

    cost = 6,
    rarity = 2,

    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    unlocked = true,
    discovered = true,

    config = { extra = {} },

    loc_vars = function(self, info_queue, card)

    end,

    calculate = function(self, card, context)
        if context.after and not context.blueprint then
            for _, ccard in ipairs(context.scoring_hand) do
                if ccard:is_suit('Hearts', true) then
                    local left_card, right_card

                    for i = 1, #context.full_hand do
                        if context.full_hand[i] == ccard then
                            left_card = context.full_hand[i - 1]
                            right_card = context.full_hand[i + 1]
                        end
                    end

                    if left_card and not left_card:is_suit('Hearts', true) then
                        Orchid.convert_to(left_card, 'Hearts')
                        card:juice_up(0.3, 0.5)
                    end
                    if right_card and not right_card:is_suit('Hearts', true) then
                        Orchid.convert_to(right_card, 'Hearts')
                        card:juice_up(0.3, 0.5)
                    end
                end
            end
        end
    end
}
