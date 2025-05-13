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

local no_debuff = {
    bl_goad = true,
    bl_head = true,
    bl_club = true,
    bl_window = true,
}

SMODS.current_mod.set_debuff = function(card)
    if card.config.center.key == 'm_wild' and no_debuff[G.GAME.blind.config.blind.key] then
        return 'prevent_debuff'
    end
end

-- local raw_calculate = G.P_CENTERS.m_wild.calculate
-- SMODS.Enhancement:take_ownership("m_wild", {
--     calculate = function(self, card, context)
--         if context.ignore_debuff and context.debuff_card == card and no_debuff[G.GAME.blind.config.blind.key] then
--             return { prevent_debuff = true }
--         end
--         if raw_calculate then
--             return raw_calculate(self, card, context)
--         end
--     end
-- })
