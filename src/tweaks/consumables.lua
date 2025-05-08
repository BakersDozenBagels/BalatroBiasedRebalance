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

local poker_hands = {
    -- ["High Card"] = { 1, 15 },
    -- ["Pair"] = { 1, 20 },
    ["Two Pair"] = { 2, 15 },
    ["Three of a Kind"] = { 2, 25 },
    ["Straight"] = { 3, 35 },
    ["Flush"] = { 2, 20 },
    ["Full House"] = { 3, 35 },
    ["Four of a Kind"] = { 3, 45 },
    ["Straight Flush"] = { 4, 55 },
    ["Five of a Kind"] = { 4, 50, 15, 150 },
    ["Flush House"] = { 5, 45, 16, 175 },
    ["Flush Five"] = { 5, 60, 20, 200 },
}

local raw_Game_init_game_object = Game.init_game_object
function Game:init_game_object()
    local ret = raw_Game_init_game_object(self)
    for k, v in pairs(poker_hands) do
        ret.hands[k].l_mult = v[1]
        ret.hands[k].l_chips = v[2]
        if v[3] then
            ret.hands[k].mult = v[3]
            ret.hands[k].s_mult = v[3]
            ret.hands[k].chips = v[4]
            ret.hands[k].s_chips = v[4]
        end
    end
    return ret
end

SMODS.Consumable:take_ownership("lovers", { config = { mod_conv = 'm_wild', max_highlighted = 2 } })
