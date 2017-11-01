# This file is part of Caterpillar-Snake-Slug.
# Caterpillar-Snake-Slug is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, version 2.
# Caterpillar-Snake-Slug is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with Debug Vehicles. If not, see <http://www.gnu.org/licenses/>.

all: css.grf

sprites_1x_32bpp/css24.png: css.pov
	mkdir -p sprites_1x_32bpp
	povray -D +A +ua +W1320 +H660 +KF24 +KFI0 +KFF24 +Osprites_1x_32bpp/ $^

sprites_4x_32bpp/css24.png: css.pov
	mkdir -p sprites_4x_32bpp
	povray -D +A +ua +W5280 +H2640 +KF24 +KFI0 +KFF24 +Osprites_4x_32bpp/ $^

sprites_1x_8bpp/css24-8bpp.png: sprites_1x_32bpp/css24.png
	echo "RGBA EATER required"

sprites_4x_8bpp/css24-8bpp.png: sprites_4x_32bpp/css24.png
	echo "RGBA EATER required"

css.nml: css.pnml
	cpp -E -o $@ $^

css.grf: css.nml sprites_1x_32bpp/css24.png sprites_4x_32bpp/css24.png sprites_1x_8bpp/css24-8bpp.png sprites_4x_8bpp/css24-8bpp.png
	nmlc -c --grf css.grf css.nml
