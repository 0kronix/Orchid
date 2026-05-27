Orchid.joker {
    key = "tornado",
    atlas = 'jokers',
    atlas_id = 6,
    soul = true,

    cost = 4,
    rarity = 1,

    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    unlocked = true,
    discovered = true,

    config = { extra = { xmult = 2 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult,
            }
        end

        if context.before and context.main_eval and not context.blueprint then
            if #context.full_hand < 2 then return end

            local seed = card.config.center.key

            local function shuffle_step(suffix, pitch)
                G.play:shuffle(seed .. suffix)
                G.play:align_cards()
                play_sound('cardSlide1', pitch)
                for _, c in ipairs(G.play.cards) do
                    c:juice_up(0.15, 0.1)
                end
            end

            shuffle_step('_1', 0.85)
            delay(0.15)
            shuffle_step('_2', 1.15)
            delay(0.15)
            shuffle_step('_3', 1.0)
            delay(0.2)
        end
    end
}
