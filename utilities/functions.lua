function Orchid.prob_check(chance, odds, key)
    if pseudorandom(key) < chance / odds then
        return true
    end
    return false
end

function Orchid.convert_to(card, suit, key)
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
            SMODS.change_base(card, suit_conv)
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

function Orchid.get_atlas_pos(id, atl)
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
        return {x = x_id, y = y_id}
    else
        return { y = id - 1 }
    end
end