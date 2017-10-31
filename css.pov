/*
 * This file is part of Caterpillar-Snake-Slug.
 * Caterpillar-Snake-Slug is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, version 2.
 * Caterpillar-Snake-Slug is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with Debug Vehicles. If not, see <http://www.gnu.org/licenses/>.
 */
#include "transforms.inc"

camera {
  orthographic
  location <1,0.82,-1>*16
  look_at <0,0,0>
  right x*33*sqrt(2)
  up y*33*sqrt(2)*image_height/image_width
  translate <1,0.82,-1>*16
}

#declare zscale = 0.02;

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
  <0,0,0>, 0.1
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
    -z, 0
    Spline_Trans(s, max(i-0.99,-2)*0.2499, y, 0.0001, 0)
  }
  plane {
    z, 0
    Spline_Trans(s, min(i+0.99, 2)*0.2499, y, 0.0001, 0)
  }
  cutaway_textures
}
#local i = i+1;
#end

#end

#declare offsets = array[32]
#declare offsets[ 0] = <-0.2 ,0,-0.2 >;
#declare offsets[ 1] = <-0.15,0,-0.2 >;
#declare offsets[ 2] = <-0.1 ,0,-0.2 >;
#declare offsets[ 3] = <-0.05,0,-0.2 >;
#declare offsets[ 4] = < 0.0 ,0,-0.2 >;
#declare offsets[ 5] = < 0.05,0,-0.2 >;
#declare offsets[ 6] = < 0.1 ,0,-0.2 >;
#declare offsets[ 7] = < 0.15,0,-0.2 >;
#declare offsets[ 8] = < 0.2 ,0,-0.2 >;
#declare offsets[ 9] = < 0.2 ,0,-0.15>;
#declare offsets[10] = < 0.2 ,0,-0.1 >;
#declare offsets[11] = < 0.2 ,0,-0.05>;
#declare offsets[12] = < 0.2 ,0, 0.0 >;
#declare offsets[13] = < 0.2 ,0, 0.05>;
#declare offsets[14] = < 0.2 ,0, 0.1 >;
#declare offsets[15] = < 0.2 ,0, 0.15>;
#declare offsets[16] = < 0.2 ,0, 0.2 >;
#declare offsets[17] = < 0.15,0, 0.2 >;
#declare offsets[18] = < 0.1 ,0, 0.2 >;
#declare offsets[19] = < 0.05,0, 0.2 >;
#declare offsets[20] = < 0.0 ,0, 0.2 >;
#declare offsets[21] = <-0.05,0, 0.2 >;
#declare offsets[22] = <-0.1 ,0, 0.2 >;
#declare offsets[23] = <-0.15,0, 0.2 >;
#declare offsets[24] = <-0.2 ,0, 0.2 >;
#declare offsets[25] = <-0.2 ,0, 0.15>;
#declare offsets[26] = <-0.2 ,0, 0.1 >;
#declare offsets[27] = <-0.2 ,0, 0.05>;
#declare offsets[28] = <-0.2 ,0, 0.0 >;
#declare offsets[29] = <-0.2 ,0,-0.05>;
#declare offsets[30] = <-0.2 ,0,-0.1 >;
#declare offsets[31] = <-0.2 ,0,-0.15>;

#declare z1 = int(clock / 5) - 2;
#declare z2 = mod(clock, 5)  - 2;

#declare d1 = -1;
#while (d1 < 31)
#declare d1 = d1 + 1;

#declare d2i = -1;
#while (d2i <= 15)
#declare d2i = d2i + 1;
#declare d2 = mod(d1 + d2i + 4, 32);

#declare o1 = offsets[d1] + y*z1*zscale;
#declare o2 = offsets[d2] + y*z2*zscale;
union {
  Part(o1, o2)

  /*
  sphere_sweep {
    linear_spline
    3
    <o1.x,0,o1.z>, 0.01
    o1, 0.01
    <0,0,0>, 0.01

    translate y*-0.5
    pigment { rgb <1,0,0> }
    no_shadow
  }
  sphere_sweep {
    linear_spline
    3
    <0,0,0>, 0.01
    o2, 0.01
    <o2.x,0,o2.z>, 0.01

    translate y*-0.5
    pigment { rgb <0,1,0> }
    no_shadow
  }
  */
  /*
  box {
    <-0.55,-0.5,-0.55>,
    <-0.45,-0.5 + 8*5*zscale,-0.45>
#if (z2 = -2)
    pigment { rgb <1,0,0> }
#else
    pigment { rgb <0,1,0> }
#end
    no_shadow
  }
  */
  translate <1, 0, -1>*(d2-16) + <1, 0, 1>*(d1-16)
}

#end
#end
