Orchid.joker {
    key = "procrastjoker",
    atlas = 'jokers',
    atlas_id = 31,

    loc_txt = {
        name = "Procrastinating Joker",
        text = {
            "Copy the {C:attention}abilities{} of adjacent {C:attention}Jokers",
            "You {C:red}must{} skip {C:attention}Blind{} each {C:attention}Ante",
            "{C:inactive}(otherwise, the Joker will be debuffed",
            "{C:inactive}until the end of the Ante)"
        },
    },

    cost = 8,
    rarity = 3,

    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    unlocked = true,
    discovered = true,

    config = { extra = { should_activate = false, should_debuff = true } },

    loc_vars = function(self, info_queue, card)
        if card.area and card.area == G.jokers then
            local left_joker, right_joker
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    left_joker = G.jokers.cards[i - 1]
                    right_joker = G.jokers.cards[i + 1]
                end
            end
            local left_compatible = left_joker and left_joker ~= card and left_joker.config.center.blueprint_compat
            local right_compatible = right_joker and right_joker ~= card and right_joker.config.center.blueprint_compat
            local main_end = {
                {
                    n = G.UIT.C,
                    config = { align = "bm", minh = 0.4 },
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = { ref_table = card, align = "m", colour = left_compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
                            nodes = {
                                { n = G.UIT.T, config = { text = ' <- ' .. localize('k_' .. (left_compatible and 'compatible' or 'incompatible')) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
                            }
                        },
                        {
                            n = G.UIT.C,
                            config = { align = "bm", minh = 0.4 },
                            nodes = {
                                {
                                    n = G.UIT.C,
                                    config = { ref_table = card, align = "m", colour = G.C.WHITE, r = 0.05, padding = 0.06 },
                                    nodes = {
                                        { n = G.UIT.T, config = { text = '', colour = G.C.WHITE, scale = 0.32 * 0.8 } },
                                    }
                                }
                            }
                        },
                        {
                            n = G.UIT.C,
                            config = { ref_table = card, align = "m", colour = right_compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
                            nodes = {
                                { n = G.UIT.T, config = { text = ' ' .. localize('k_' .. (right_compatible and 'compatible' or 'incompatible')) .. ' -> ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
                            }
                        }
                    }
                }
            }
            return { main_end = main_end }
        end
    end,

    calculate = function(self, card, context)
        if not context.blueprint then
            if context.end_of_round and context.beat_boss then
                if not card.debuff and card.ability.extra.should_debuff then
                    card:set_debuff(true)
                else
                    card:set_debuff(false)
                end
                card:juice_up(0.3, 0.5)
            end

            if context.setting_blind then
                card.ability.extra.should_debuff = true
            end

            if context.skipping_blind then
                card.ability.extra.should_debuff = false
            end

            local left_joker, right_joker = nil, nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    left_joker = G.jokers.cards[i - 1]
                    right_joker = G.jokers.cards[i + 1]
                end
            end
            local left_compatible = left_joker and left_joker ~= card and left_joker.config.center.blueprint_compat
            local right_compatible = right_joker and right_joker ~= card and right_joker.config.center.blueprint_compat

            if left_compatible or right_compatible then card.ability.extra.should_activate = true end

            local effect_to_return

            if card.ability.extra.should_activate then
                local effect1_def
                if left_joker then
                    effect1_def = SMODS.blueprint_effect(card, left_joker, context)
                end

                local effect2_def
                if right_joker then
                    effect2_def = SMODS.blueprint_effect(card, right_joker, context)
                end

                if effect1_def and effect2_def then
                    effect_to_return = SMODS.merge_effects { effect1_def, effect2_def }
                else
                    effect_to_return = effect1_def or effect2_def
                end
            end

            return effect_to_return
        end
    end
}
