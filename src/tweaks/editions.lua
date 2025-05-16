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

local polling_playing = false

local raw_get_weight = G.P_CENTERS.e_negative.get_weight
SMODS.Edition:take_ownership("negative", {
    weight = .4,
    get_weight = function(self)
        local mul = polling_playing and 7 or 1
        if G.GAME.selected_back.effect.center.key == "b_black" then
            mul = mul * 4
        end
        return raw_get_weight(self) * mul
    end,
})

local raw_get_weight = G.P_CENTERS.e_foil.get_weight
SMODS.Edition:take_ownership("foil", {
    config = setmetatable({ chips = 50 }, {
        __index = function(t, k)
            if k == 'extra' then return t.chips end
            return rawget(t, k)
        end,
        __newindex = function(t, k, v)
            if k == 'extra' then
                t.chips = v; return
            end
            rawset(t, k, v)
        end,
    }),
    weight = 1.75,
    get_weight = function(self)
        local mul = polling_playing and 2 or 1
        return raw_get_weight(self) * mul
    end,
})

local raw_get_weight = G.P_CENTERS.e_holo.get_weight
SMODS.Edition:take_ownership("holo", {
    weight = 1.75,
    get_weight = function(self)
        local mul = polling_playing and 2 or 1
        return raw_get_weight(self) * mul
    end,
})

local raw_get_weight = G.P_CENTERS.e_polychrome.get_weight
SMODS.Edition:take_ownership("polychrome", {
    weight = .5,
    get_weight = function(self)
        local mul = polling_playing and 2.8 or 1
        return raw_get_weight(self) * mul
    end,
})

local raw_poll_edition = poll_edition
function poll_edition(k, m, n, ...)
    polling_playing = n
    return raw_poll_edition(k, m, k == "wheel_of_fortune", ...)
end
