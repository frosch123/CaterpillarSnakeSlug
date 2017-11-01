# This file is part of Caterpillar-Snake-Slug.
# Caterpillar-Snake-Slug is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, version 2.
# Caterpillar-Snake-Slug is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with Debug Vehicles. If not, see <http://www.gnu.org/licenses/>.

NAME = css

POV_1x = +W2112 +H1056
POV_4x = +W8448 +H4224

FRAME_MIDDLE = 12
FRAME_LAST = 24

POV_OPT = -D +A +ua
POV_ALL = +KF$(FRAME_LAST) +KFI0 +KFF$(FRAME_LAST)
POV_TEST = +K$(FRAME_MIDDLE)

DIR_1x_32bpp = sprites_1x_32bpp
DIR_4x_32bpp = sprites_4x_32bpp
DIR_1x_8bpp = sprites_1x_8bpp
DIR_4x_8bpp = sprites_4x_8bpp

NAME_LAST_1x_32bpp = $(DIR_1x_32bpp)/$(NAME)$(FRAME_LAST).png
NAME_LAST_4x_32bpp = $(DIR_4x_32bpp)/$(NAME)$(FRAME_LAST).png
NAME_LAST_1x_8bpp = $(DIR_1x_8bpp)/$(NAME)$(FRAME_LAST)-8bpp.png
NAME_LAST_4x_8bpp = $(DIR_4x_8bpp)/$(NAME)$(FRAME_LAST)-8bpp.png

all: $(NAME).grf

test:
	povray $(POV_OPT) $(POV_1x) $(POV_TEST) +O$(NAME)_test_1x.png $(NAME).pov
	povray $(POV_OPT) $(POV_4x) $(POV_TEST) +O$(NAME)_test_4x.png $(NAME).pov

$(NAME_LAST_1x_32bpp): $(NAME).pov
	mkdir -p $(DIR_1x_32bpp)
	povray $(POV_OPT) $(POV_1x) $(POV_ALL) +O$(DIR_1x_32bpp)/ $^

$(NAME_LAST_4x_32bpp): $(NAME).pov
	mkdir -p $(DIR_4x_32bpp)
	povray $(POV_OPT) $(POV_4x) $(POV_ALL) +O$(DIR_4x_32bpp)/ $^

$(NAME_LAST_1x_8bpp): $(NAME_LAST_1x_32bpp)
	echo "RGBA EATER required"

$(NAME_LAST_4x_8bpp): $(NAME_LAST_4x_32bpp)
	echo "RGBA EATER required"

$(NAME).nml: $(NAME).pnml
	cpp -E -o $@ $^

$(NAME).grf: $(NAME).nml $(NAME_LAST_1x_32bpp) $(NAME_LAST_4x_32bpp) $(NAME_LAST_1x_8bpp) $(NAME_LAST_4x_8bpp)
	nmlc -c --grf $(NAME).grf $(NAME).nml
