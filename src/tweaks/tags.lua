--[[

Copyright (C) 2025  BakersDozenBagels

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.

]] --

SMODS.Tag:take_ownership("uncommon", {
    apply = function(self, tag, context)
        if context.type ~= 'store_joker_create' or tag.triggered then return end
        tag.triggered = true
        local card = create_card('Joker', context.area, nil, 0.9, nil, nil, nil, 'uta')
        create_shop_card_ui(card, 'Joker', context.area)
        card.states.visible = false
        if not G.GAME.modifiers.all_eternal then
            card:set_eternal(false)
        end
        card:set_perishable(false)
        card:set_rental(false)
        tag:yep('+', G.C.GREEN, function()
            card:start_materialize()
            card.ability.couponed = true
            card:set_cost()
            return true
        end)
        return card
    end
})

SMODS.Tag:take_ownership("rare", {
    apply = function(self, tag, context)
        if context.type ~= 'store_joker_create' or tag.triggered then return end
        tag.triggered = true
        local rares_in_possession = { 0 }
        for k, v in ipairs(G.jokers.cards) do
            if v.config.center.rarity == 3 and not rares_in_possession[v.config.center.key] then
                rares_in_possession[1] = rares_in_possession[1] + 1
                rares_in_possession[v.config.center.key] = true
            end
        end

        if #G.P_JOKER_RARITY_POOLS[3] > rares_in_possession[1] then
            local card = create_card('Joker', context.area, nil, 1, nil, nil, nil, 'rta')
            create_shop_card_ui(card, 'Joker', context.area)
            card.states.visible = false
            if not G.GAME.modifiers.all_eternal then
                card:set_eternal(false)
            end
            card:set_perishable(false)
            card:set_rental(false)
            tag:yep('+', G.C.RED, function()
                card:start_materialize()
                card.ability.couponed = true
                card:set_cost()
                return true
            end)
            return card
        else
            tag:nope()
        end
    end
})
