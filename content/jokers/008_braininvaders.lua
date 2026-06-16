Orchid.joker {
    key = "braininvaders",
    atlas = 'jokers',
    atlas_id = 8,

    cost = 9,
    rarity = 3,

    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    unlocked = true,
    discovered = true,

    config = { extra = { cnt = 1 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.cnt } }
    end,

    calculate = function(self, card, context)
        if context.after and not context.blueprint then
            for _, scored_card in ipairs(context.scoring_hand) do
                if scored_card:is_face() then
                    if scored_card.base.value ~= "Jack" then
                        Orchid.modify_rank(scored_card, -card.ability.extra.cnt)
                        return {
                            message = localize("orchid_drain_ex"),
                            card = scored_card
                        }
                    else
                        SMODS.destroy_cards(scored_card)
                        delay(0.5)
                    end
                end
            end
        end
    end
}
