Orchid.joker {
    key = "bellbill",
    atlas = 'jokers',
    atlas_id = 19,

    cost = 10,
    rarity = 3,

    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    unlocked = true,
    discovered = true,

    config = { extra = {} },

    loc_vars = function(self, info_queue, card)

    end,

    add_to_deck = function(self, card, from_debuff)
        if G.shop and G.STATE == G.STATES.SHOP then
            if G.shop_vouchers and G.shop_vouchers.cards[1] then
                G.shop_vouchers.cards[1].cost = 0
            end
        end
    end,

    calculate = function(self, card, context)
        if not context.blueprint then
            if context.starting_shop then
                if G.shop_vouchers and G.shop_vouchers.cards[1] then
                    G.shop_vouchers.cards[1].cost = 0
                end
            end
        end
    end,
}
