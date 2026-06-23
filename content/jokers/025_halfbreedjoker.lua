Orchid.joker {
    key = "halfbreedjoker",
    atlas = 'jokers',
    atlas_id = 25,

    loc_txt = {
        name = "Half-Breed Joker",
        text = {
            "{C:green}#1# in #2#{} chance to create",
            "random {C:attention}Tag{} if {C:attention}played hand{}",
            "contains cards with and",
            "without {C:attention}enhancement"
        },
    },

    cost = 7,
    rarity = 2,

    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    unlocked = true,
    discovered = true,

    config = { extra = { odds = 5 } },

    loc_vars = function(self, info_queue, card)
        local num, den = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
        return { vars = { num, den } }
    end,

    calculate = function(self, card, context)
        if context.after then
            local ecards = 0
            local necards = 0

            for _, ccard in ipairs(context.full_hand) do
                if next(SMODS.get_enhancements(ccard)) then
                    ecards = ecards + 1
                else
                    necards = necards + 1
                end
            end

            if ecards > 0 and necards > 0 then
                if Orchid.prob_check(G.GAME.probabilities.normal, card.ability.extra.odds, card.config.center.key) then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.2,
                        func = function()
                            Orchid.create_tag(nil, card.config.center.key)
                            return true
                        end
                    }))

                    return {
                        message = localize("orchid_plustag_ex")
                    }
                end
            end
        end
    end
}
