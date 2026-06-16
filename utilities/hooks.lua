local card_is_face_ref = Card.is_face

function Card:is_face(from_boss)
    local ret = card_is_face_ref(self, from_boss)
    if ret then return ret end

    if self.debuff and not from_boss then return end

    if next(SMODS.find_card('j_orchid_3djoker')) then
        if SMODS.has_enhancement(self, 'm_mult')
            or SMODS.has_enhancement(self, 'm_bonus') then
            return true
        end
    end
end

local highlight_ref = Card.highlight

function Card:highlight(is_highlighted)
    highlight_ref(self, is_highlighted)

    Orchid.remove_gold_sell_button(self)

    if is_highlighted
        and Orchid.is_gold_card(self)
        and self.area == G.hand
        and Orchid.gold_selling_enabled()
    then
        Orchid.attach_gold_sell_button(self)
    end
end

local can_sell_ref = Card.can_sell_card

function Card:can_sell_card(context)
    if Orchid.can_sell_gold_card(self) then
        Orchid.update_gold_sell_cost(self)
        return true
    end
    return can_sell_ref(self, context)
end

local sell_card_ref = Card.sell_card

function Card:sell_card()
    if Orchid.is_gold_card(self) and self.area == G.hand then
        return Orchid.sell_gold_card(self)
    end
    return sell_card_ref(self)
end

G.FUNCS.orchid_can_sell_gold_card = function(e)
    local card = e.config.ref_table
    if Orchid.can_sell_gold_card(card) then
        Orchid.update_gold_sell_cost(card)
        e.config.colour = G.C.GREEN
        e.config.button = 'orchid_sell_gold_card'
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end

G.FUNCS.orchid_sell_gold_card = function(e)
    Orchid.sell_gold_card(e.config.ref_table)
end
