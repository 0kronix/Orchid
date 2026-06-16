Orchid.joker_atlas_cols = 8

function Orchid.prob_check(chance, odds, key)
    if pseudorandom(key) < chance / odds then
        return true
    end
    return false
end

function Orchid.pick_ranks(count, seed)
    local seen = {}
    local pool = {}

    if G.playing_cards and #G.playing_cards > 0 then
        for _, card in ipairs(G.playing_cards) do
            if card and not SMODS.has_no_rank(card) and card.base and card.base.value then
                local key = card.base.value
                local rank = SMODS.Ranks[key]

                if rank and rank.id and not seen[key] then
                    seen[key] = true
                    pool[#pool + 1] = {
                        key = key,
                        id = rank.id,
                    }
                end
            end
        end
    end

    if #pool == 0 then
        local fallback = {
            '2', '3', '4', '5', '6', '7', '8',
            '9', '10', 'Jack', 'Queen', 'King', 'Ace'
        }

        for _, key in ipairs(fallback) do
            local rank = SMODS.Ranks[key]
            if rank and rank.id then
                pool[#pool + 1] = {
                    key = key,
                    id = rank.id,
                }
            end
        end
    end

    local picked = {}
    for i = 1, count do
        if #pool == 0 then break end

        local index = pseudorandom(seed .. '_' .. i, 1, #pool)
        picked[#picked + 1] = table.remove(pool, index)
    end

    return picked
end

function Orchid.rank_in_list(card, ranks)
    if SMODS.has_no_rank(card) then return false end

    local id = card:get_id()
    for _, rank in ipairs(ranks or {}) do
        if rank.id == id then
            return true
        end
    end

    return false
end

function Orchid.random_legendary_joker(seed, exclude_key)
    local pool = {}

    for _, center in ipairs(G.P_JOKER_RARITY_POOLS[4] or {}) do
        local in_pool = SMODS.add_to_pool(center)

        if in_pool
            and center.key ~= exclude_key
            and not G.GAME.banned_keys[center.key] then
            pool[#pool + 1] = center
        end
    end

    return pseudorandom_element(pool, pseudoseed(seed))
end

function Orchid.add_to_deck(card)
    card:add_to_deck()
    G.deck.config.card_limit = G.deck.config.card_limit + 1
    table.insert(G.playing_cards, card)

    G.deck:emplace(card)
    card.states.visible = nil

    G.E_MANAGER:add_event(Event({
        func = function()
            card:start_materialize()
            return true
        end
    }))
end

-- Special thanks for All In Jest mod! <3
Orchid.card_area_preview = function(cardArea, desc_nodes, config)
    if not config then config = {} end
    local height = config.h or 1.25
    local width = config.w or 1
    local card_limit = config.card_limit or #config.cards or 1
    local override = config.override or false
    local cards = config.cards or {}
    local padding = config.padding or 0.07
    local margin_left = config.ml or 0
    local margin_top = config.mt or 0
    local alignment = config.alignment or "cm"
    local scale = config.scale or 1
    local type = config.type or "title"
    local box_height = config.box_height or 0
    local highlight_limit = config.highlight_limit or 0
    local x_offset = config.x_offset or 0
    if override or not cardArea then
        cardArea = CardArea(
            G.ROOM.T.x + margin_left * G.ROOM.T.w - x_offset, G.ROOM.T.h + margin_top
            , G.CARD_W <= width * G.CARD_W and width * G.CARD_W or G.CARD_W, height * G.CARD_H,
            { card_limit = card_limit, type = type, highlight_limit = highlight_limit, collection = true, temporary = true }
        )
        for i, card in ipairs(cards) do
            card.T.w = card.T.w * scale
            card.T.h = card.T.h * scale
            card.VT.h = card.T.h
            card.VT.h = card.T.h
            local area = cardArea
            if (card.config.center) then
                card:set_sprites(card.config.center)
            end
            area:emplace(card)
        end
    end
    local uiEX = {
        n = G.UIT.R,
        config = { align = alignment, padding = padding, no_fill = true, minh = box_height },
        nodes = {
            {
                n = G.UIT.R,
                config = { padding = padding, r = 0.12, colour = lighten(G.C.JOKER_GREY, 0.8), emboss = 0.07 },
                nodes = {
                    { n = G.UIT.O, config = { object = cardArea } }
                }
            }
        }
    }
    if cardArea then
        if desc_nodes then
            desc_nodes[#desc_nodes + 1] = {
                uiEX
            }
        end
    end
    return uiEX
end

function Orchid.is_gold_card(card)
    return card
        and card.config.center
        and card.config.center.key == 'm_gold'
end

function Orchid.get_goldenboy()
    for _, joker in ipairs(SMODS.find_card('j_orchid_goldenboy')) do
        if not joker.debuff and not joker.getting_sliced then
            return joker
        end
    end
end

function Orchid.gold_selling_enabled()
    return Orchid.get_goldenboy() ~= nil
end

function Orchid.get_gold_sell_price()
    local joker = Orchid.get_goldenboy()
    return joker and joker.ability.extra.dollars
end

function Orchid.update_gold_sell_cost(card)
    local price = Orchid.get_gold_sell_price()
    if not price then return end
    card.sell_cost = price
    card.sell_cost_label = price
end

function Orchid.can_sell_gold_card(card)
    if not Orchid.gold_selling_enabled() then return false end
    if not Orchid.is_gold_card(card) then return false end
    if not card.area or card.area ~= G.hand then return false end
    if not card.highlighted then return false end
    if G.play and #G.play.cards > 0 then return false end
    if G.CONTROLLER.locked then return false end
    if G.GAME.STOP_USE and G.GAME.STOP_USE > 0 then return false end
    return true
end

function Orchid.remove_gold_sell_button(card)
    if card.orchid_gold_sell_ui and card.children.use_button then
        card.children.use_button:remove()
        card.children.use_button = nil
        card.orchid_gold_sell_ui = nil
    end
end

function Orchid.gold_sell_button_def(card)
    local sell = {
        n = G.UIT.C,
        config = { align = 'cl' },
        nodes = {
            {
                n = G.UIT.C,
                config = {
                    ref_table = card,
                    align = 'cl',
                    padding = 0.1,
                    r = 0.08,
                    minw = 1.25,
                    hover = true,
                    shadow = true,
                    colour = G.C.UI.BACKGROUND_INACTIVE,
                    one_press = true,
                    button = 'orchid_sell_gold_card',
                    func = 'orchid_can_sell_gold_card',
                },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = { align = 'tm' },
                        nodes = {
                            {
                                n = G.UIT.R,
                                config = { align = 'cm', maxw = 1.25 },
                                nodes = {
                                    {
                                        n = G.UIT.T,
                                        config = {
                                            text = localize('b_sell'),
                                            colour = G.C.UI.TEXT_LIGHT,
                                            scale = 0.4,
                                            shadow = true,
                                        },
                                    },
                                },
                            },
                            {
                                n = G.UIT.R,
                                config = { align = 'cm' },
                                nodes = {
                                    {
                                        n = G.UIT.T,
                                        config = {
                                            text = localize('$'),
                                            colour = G.C.WHITE,
                                            scale = 0.4,
                                            shadow = true,
                                        },
                                    },
                                    {
                                        n = G.UIT.T,
                                        config = {
                                            ref_table = card,
                                            ref_value = 'sell_cost_label',
                                            colour = G.C.WHITE,
                                            scale = 0.55,
                                            shadow = true,
                                        },
                                    },
                                },
                            },
                        },
                    },
                    { n = G.UIT.B, config = { w = 0.1, h = 0.6 } },
                },
            },
        },
    }

    return {
        n = G.UIT.ROOT,
        config = { padding = 0, colour = G.C.CLEAR },
        nodes = {
            {
                n = G.UIT.C,
                config = { padding = 0.15, align = 'cl' },
                nodes = {
                    { n = G.UIT.R, config = { align = 'cl' }, nodes = { sell } },
                },
            },
        },
    }
end

function Orchid.attach_gold_sell_button(card)
    Orchid.update_gold_sell_cost(card)
    card.orchid_gold_sell_ui = true
    card.children.use_button = UIBox {
        definition = Orchid.gold_sell_button_def(card),
        config = {
            align = 'cl',
            offset = { x = 0.4, y = 0 },
            parent = card,
        },
    }
end

function Orchid.sell_gold_card(card)
    if not Orchid.can_sell_gold_card(card) then return end

    local price = card.sell_cost or Orchid.get_gold_sell_price()
    if not price then return end

    G.CONTROLLER.locks.selling_card = true
    stop_use()
    Orchid.remove_gold_sell_button(card)

    if card.area then
        card.area:remove_from_highlighted(card, true)
    end

    SMODS.calculate_context({
        remove_playing_cards = true,
        removed = { card },
    })

    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.2,
        func = function()
            play_sound('coin2')
            card:juice_up(0.3, 0.4)
            return true
        end,
    }))
    delay(0.2)
    G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = function()
            ease_dollars(price)
            card.paperback_dissolve_sell_flag = true
            card:start_dissolve({ G.C.GOLD })
            card.paperback_dissolve_sell_flag = false
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.3,
                blocking = false,
                func = function()
                    G.CONTROLLER.locks.selling_card = nil
                    return true
                end,
            }))
            return true
        end,
    }))
end

function Orchid.convert_to(card, suit)
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.15,
        func = function()
            card:flip()
            play_sound('card1')
            card:juice_up(0.3, 0.3)
            return true
        end
    }))
    delay(0.2)
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.1,
        func = function()
            SMODS.change_base(card, suit)
            return true
        end
    }))
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.15,
        func = function()
            card:flip()
            play_sound('card1')
            card:juice_up(0.3, 0.3)
            return true
        end
    }))
    delay(0.5)
end

function Orchid.modify_rank(card, cnt)
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.3,
        func = function()
            SMODS.modify_rank(card, cnt)
            play_sound('card1')
            card:juice_up(0.3, 0.3)
            return true
        end
    }))
    delay(0.5)
end

function Orchid.pick_hand(exclude, key)
    local pool = {}
    for k, _ in pairs(G.GAME.hands) do
        if SMODS.is_poker_hand_visible(k) and k ~= exclude then
            pool[#pool + 1] = k
        end
    end
    if #pool == 0 then
        for k, _ in pairs(G.GAME.hands) do
            if SMODS.is_poker_hand_visible(k) then
                pool[#pool + 1] = k
            end
        end
    end
    return pseudorandom_element(pool, pseudoseed(key))
end

function Orchid.count_shop_items()
    local count = 0
    local areas = { G.shop_jokers, G.shop_booster, G.shop_vouchers }
    for _, area in ipairs(areas) do
        if area and area.cards then
            count = count + #area.cards
        end
    end
    return count
end

function Orchid.on_left_or_right_of(card, area, step)
    local ret_card
    for i = 1, #area do
        if area[i] == card then
            ret_card = area[i + step]
        end
    end
    return ret_card
end

function Orchid.most_played_hand()
    local _handname, _played = 'High Card', -1
    for hand_key, hand in pairs(G.GAME.hands) do
        if hand.played > _played and SMODS.is_poker_hand_visible(hand_key) then
            _played = hand.played
            _handname = hand_key
        end
    end
    return _handname
end

function Orchid.turn_face(card, seed)
    local face_cards = {}
    for _, v in pairs(SMODS.Ranks) do
        if v.face then
            table.insert(face_cards, v)
        end
    end
    assert(SMODS.change_base(card, nil, pseudorandom_element(face_cards, seed).key))
    card:juice_up(0.3, 0.5)
end

function Orchid.create_tag(tag, seed)
    local tag_pool = get_current_pool('Tag')
    if tag == nil then
        tag = pseudorandom_element(tag_pool, seed)
    else
        return add_tag(Tag(tag, false, 'Small'))
    end
    local it = 1
    while tag == 'UNAVAILABLE' do
        it = it + 1
        tag = pseudorandom_element(tag_pool, seed .. it)
    end
    return add_tag(Tag(tag, false, 'Small'))
end

function Orchid.create_voucher(voucher, seed, cost_mod, cost)
    local voucher_pool = get_current_pool('Voucher')
    local voucher_card = nil
    if voucher == nil then
        local it = 1
        voucher = pseudorandom_element(voucher_pool, seed)
        while voucher == 'UNAVAILABLE' do
            it = it + 1
            voucher = pseudorandom_element(voucher_pool, seed .. it)
        end
        voucher_card = SMODS.create_card({ area = G.play, key = voucher })
    else
        voucher_card = SMODS.create_card({ area = G.play, key = voucher })
    end

    voucher_card:start_materialize()
    if cost_mod == "set" then
        voucher_card.cost = cost
    elseif cost_mod == "mult" then
        voucher_card.cost = voucher_card.cost * cost
    elseif cost_mod == "mod" then
        voucher_card.cost = voucher_card.cost + cost
    else
        voucher_card.cost = voucher_card.cost
    end
    G.play:emplace(voucher_card)
    delay(0.8)
    voucher_card:redeem()

    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.5,
        func = function()
            voucher_card:start_dissolve()
            return true
        end
    }))
end

function Orchid.tablefind(tbl, val)
    for i, v in ipairs(tbl) do
        if v == val then
            return true
        end
    end
    return false
end

Orchid.soul_count = 0

function Orchid.get_atlas_pos(id, atl)
    atl = atl or Orchid.joker_atlas_cols
    id = id + Orchid.soul_count

    local x_id, y_id = 0, 0

    if atl > 0 then
        if id <= atl then
            x_id = id - 1
        else
            if id % atl ~= 0 then
                x_id = id % atl - 1
            else
                x_id = atl - 1
            end
        end
        y_id = math.ceil(id / atl) - 1
        return { x = x_id, y = y_id }
    else
        return { y = id - 1 }
    end
end

function Orchid.joker(def)
    local id = assert(def.atlas_id, "Orchid.joker: atlas_id is required")
    def.atlas_id = nil

    def.pos = Orchid.get_atlas_pos(id)

    if def.soul then
        def.soul_pos = Orchid.get_atlas_pos(id + 1)
        Orchid.soul_count = Orchid.soul_count + 1
        def.soul = nil
    end

    return SMODS.Joker(def)
end
