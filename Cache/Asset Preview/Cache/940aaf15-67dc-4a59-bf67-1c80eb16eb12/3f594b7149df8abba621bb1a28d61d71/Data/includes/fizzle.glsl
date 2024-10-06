//-----------------------------------------------------------------------
// Copyright (c) 2017 Snap Inc.
//-----------------------------------------------------------------------

#ifndef FIZZLE_GLSL
#define FIZZLE_GLSL

#ifdef FRAGMENT_SHADER
#ifdef ENABLE_FIZZLE

uniform vec3 fizzleScale;
uniform float transition;

float map( float value, float inputMin, float inputMax, float outputMin, float outputMax ) { return ((value - inputMin) / (inputMax - inputMin) * (outputMax - outputMin) + outputMin); }
float linearStep( float _edge0, float _edge1, float _t ) { return clamp( (_t - _edge0)/(_edge1 - _edge0), 0.0, 1.0); }

// hash and snoise licensed under MIT via: https://www.shadertoy.com/view/4sfGzS
// The MIT License
// Copyright 2013 Inigo Quilez
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the Software), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software. THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

float hash(vec3 p)
{
    p  = fract( p*0.3183099+.1 );
    p *= 17.0;
    return fract( p.x*p.y*p.z*(p.x+p.y+p.z) );
}

float snoise( vec3 x )
{
    vec3 p = floor(x);
    vec3 f = fract(x);
    f = f*f*(3.0-2.0*f);

    return mix(mix(mix( hash(p+vec3(0.0,0.0,0.0)),
                       hash(p+vec3(1.0,0.0,0.0)),f.x),
                   mix( hash(p+vec3(0.0,1.0,0.0)),
                       hash(p+vec3(1.0,1.0,0.0)),f.x),f.y),
               mix(mix( hash(p+vec3(0.0,0.0,1.0)),
                       hash(p+vec3(1.0,0.0,1.0)),f.x),
                   mix( hash(p+vec3(0.0,1.0,1.0)),
                       hash(p+vec3(1.0,1.0,1.0)),f.x),f.y),f.z);
}

vec4 fizzle(vec4 col)
{
    vec4 result = col;
    if( transition >= 1.0 )
    {
        discard;
    }
    else if( transition > 0.0 )
    {
        vec3 burnPassOutColor = vec3(1.0, 1.0, 1.0);

        vec3 origColor = result.xyz;  // surface color could be anything
        vec3 origColorInverted = vec3(1.0 - result.xyz);
        vec3 burnEdgeColor = vec3(1.0, 1.0, 1.0);

        vec3 p = vec3( varPos.xyz * fizzleScale );

        float amountToMoveUpwards = 6.0;
        p.xyz += vec3(0.0, map( smoothstep( 0.0, 0.8, transition), 0.0, 1.0, 0.0, amountToMoveUpwards), 0.0); // make it move

        float noiseVal = (snoise(p) + 1.0) * 0.5;
        noiseVal -= smoothstep( 0.0, 1.0, transition);
        noiseVal = smoothstep( 0.05, 0.95, noiseVal ); // let's keep it at 0 and 1 a little bit longer, also gives it a bit of easing
        if (noiseVal <= 0.0) discard;

        float burnAmount = 1.0 - linearStep( 0.0, 0.1, noiseVal ); // we have a value from 0..1, let's map it so the first X% ramps up to 1 and holds there
        float burnColorMix = linearStep( 0.9, 1.0, burnAmount );
        burnColorMix = linearStep( 0.2, 0.8, burnColorMix ); // Stay at 0 and 1.0 longer
        vec3 burnColor = mix( origColorInverted, burnEdgeColor, burnColorMix );

        float surfaceOrBurn = 1.0 - step( 0.0075, noiseVal );
        burnPassOutColor = mix( origColor, burnColor, surfaceOrBurn );

        result.xyz = burnPassOutColor;
    }
    return result;
}

#endif  // #ifdef ENABLE_FIZZLE
#endif  // #ifdef FRAGMENT_SHADER
#endif  // FIZZLE_GLSL
