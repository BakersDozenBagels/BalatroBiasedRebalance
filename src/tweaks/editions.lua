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

local raw_get_weight = G.P_CENTERS.e_negative.get_weight
SMODS.Edition:take_ownership("negative", {
    weight = 2.4,
    get_weight = function(self)
        if G.GAME.selected_back.effect.center.key == "b_black" then
            return raw_get_weight(self) * 4
        end
        return raw_get_weight(self)
    end,
})

SMODS.Edition:take_ownership("foil", {
    config = { extra = 75 },
    weight = 15
})

SMODS.Edition:take_ownership("holo", {
    weight = 14
})

SMODS.Edition:take_ownership("polychrome", {
    weight = 3
})
