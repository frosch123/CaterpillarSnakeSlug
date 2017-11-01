/*
 * This file is part of Caterpillar-Snake-Slug.
 * Caterpillar-Snake-Slug is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, version 2.
 * Caterpillar-Snake-Slug is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with Debug Vehicles. If not, see <http://www.gnu.org/licenses/>.
 */
#version 3.7;

#include "transforms.inc"

#declare camwidth = 33;

#macro ottd(X,Y,Z)
  <X*0.1,Z*sqrt(6)/60,Y*0.1>
#end

#declare camdir = <1,sqrt(2/3),-1>;

camera {
  orthographic
  location camdir*16
  look_at <0,0,0>
  right x*camwidth*sqrt(2)
  up y*camwidth*sqrt(2)*image_height/image_width
  translate camdir*16
}

global_settings {
  ambient_light rgb<1,1,1>*0.8
}

light_source {
  <5, 10,-1>*50
  color rgb<1,1,1>
  parallel
  point_at <0,0,0>
}

#declare Slice = sphere {
  <0,0,0>, 0.2
  scale <1, 1, 0.6>
  pigment {
    radial frequency 8
    color_map {
      [0.0  color rgb <0.0, 0.1, 0.6> ]
      [0.24 color rgb <0.0, 0.1, 0.6> ]
      [0.26 color rgb <0.2, 0.7, 0.2> ]
      [0.74 color rgb <0.2, 0.7, 0.2> ]
      [0.75 color rgb <0.0, 0.1, 0.6> ]
      [1.0  color rgb <0.0, 0.1, 0.6> ]
    }
    rotate x*90
  }
  finish {
    diffuse 0.7
  }
}

#macro Part(d1, d2)

#local s = spline {
  cubic_spline
  -1.0, d1,
  -0.5, d1*0.5,
   0.5, d2*0.5,
   1.0, d2
}

#local i = -2;
#while (i <= 2)
intersection {
  object {
    Slice
    rotate z*(360/8)*(i*0.25)
    Spline_Trans(s, i*0.2499, y, 0.0001, 0)
  }
  plane {
    -z, 0.01
    Spline_Trans(s, max(i-0.99,-2)*0.2499, y, 0.0001, 0)
  }
  plane {
    z, 0.01
    Spline_Trans(s, min(i+0.99, 2)*0.2499, y, 0.0001, 0)
  }
  cutaway_textures
  translate y*0.15
}
#local i = i+1;
#end
/*
sphere {
  o1*0.5, 0.05
  pigment { rgb <5,0,0> }
  no_shadow
}
sphere {
  o2*0.5, 0.05
  pigment { rgb <0,5,0> }
  no_shadow
}

sphere_sweep {
  linear_spline
  3
  o1*0.5, 0.0001
  o1*0.3, 0.02
  <0,0,0>, 0.02

  pigment { rgb <1,0,0> }
  no_shadow
}
sphere_sweep {
  linear_spline
  3
  <0,0,0>, 0.02
  o2*0.3, 0.02
  o2*0.5, 0.0001

  pigment { rgb <0,1,0> }
  no_shadow
}
*/
#end

#declare offsets = array[32]
#declare offsets[ 0] = ottd(-4, -4, 0);
#declare offsets[ 1] = ottd(-3, -4, 0);
#declare offsets[ 2] = ottd(-2, -4, 0);
#declare offsets[ 3] = ottd(-1, -4, 0);
#declare offsets[ 4] = ottd( 0, -4, 0);
#declare offsets[ 5] = ottd( 1, -4, 0);
#declare offsets[ 6] = ottd( 2, -4, 0);
#declare offsets[ 7] = ottd( 3, -4, 0);
#declare offsets[ 8] = ottd( 4, -4, 0);
#declare offsets[ 9] = ottd( 4, -3, 0);
#declare offsets[10] = ottd( 4, -2, 0);
#declare offsets[11] = ottd( 4, -1, 0);
#declare offsets[12] = ottd( 4,  0, 0);
#declare offsets[13] = ottd( 4,  1, 0);
#declare offsets[14] = ottd( 4,  2, 0);
#declare offsets[15] = ottd( 4,  3, 0);
#declare offsets[16] = ottd( 4,  4, 0);
#declare offsets[17] = ottd( 3,  4, 0);
#declare offsets[18] = ottd( 2,  4, 0);
#declare offsets[19] = ottd( 1,  4, 0);
#declare offsets[20] = ottd( 0,  4, 0);
#declare offsets[21] = ottd(-1,  4, 0);
#declare offsets[22] = ottd(-2,  4, 0);
#declare offsets[23] = ottd(-3,  4, 0);
#declare offsets[24] = ottd(-4,  4, 0);
#declare offsets[25] = ottd(-4,  3, 0);
#declare offsets[26] = ottd(-4,  2, 0);
#declare offsets[27] = ottd(-4,  1, 0);
#declare offsets[28] = ottd(-4,  0, 0);
#declare offsets[29] = ottd(-4, -1, 0);
#declare offsets[30] = ottd(-4, -2, 0);
#declare offsets[31] = ottd(-4, -3, 0);

#declare z1 = int(clock / 5) - 2;
#declare z2 = mod(clock, 5)  - 2;

#declare d1 = -1;
#while (d1 < 31)
#declare d1 = d1 + 1;

#declare d2i = -1;
#while (d2i <= 15)
#declare d2i = d2i + 1;
#declare d2 = mod(d1 + d2i + 8, 32);

#declare o1 = offsets[d1] + ottd(0,0,z1);
#declare o2 = offsets[d2] + ottd(0,0,z2);
union {
  Part(o1, o2)
  translate <1, 0, -1>*(d2-16) + <1, 0, 1>*(d1-16) - 0.5*y
}

#end
#end

/*
box {
  ottd(-8,-8,0), ottd(8,8,8*10)
  pigment {rgb<0,0,1>}
}
*/
