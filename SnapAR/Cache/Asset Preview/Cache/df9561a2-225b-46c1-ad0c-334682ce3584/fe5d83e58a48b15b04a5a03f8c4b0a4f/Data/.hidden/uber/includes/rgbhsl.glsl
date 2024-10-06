#pragma once

#ifdef FRAGMENT_SHADER

vec3 RGBtoHCV(vec3 rgb)
{
    vec4 p = (rgb.g < rgb.b) ? vec4(rgb.bg, -1.0, 2.0/3.0) : vec4(rgb.gb, 0.0, -1.0/3.0);
    vec4 q = (rgb.r < p.x) ? vec4(p.xyw, rgb.r) : vec4(rgb.r, p.yzx);

    float c = q.x - min(q.w, q.y);
    float h = abs((q.w - q.y) / (6.0*c + 1e-7) + q.z);
    float v = q.x;

    return vec3(h, c, v);
}

vec3 RGBToHSL(vec3 rgb)
{
    vec3 hcv = RGBtoHCV(rgb);

    float lum = hcv.z - hcv.y * 0.5;
    float sat = hcv.y / (1.0 - abs(2.0*lum - 1.0) + 1e-7);

    return vec3(hcv.x, sat, lum);
}

vec3 HUEtoRGB(float hue)
{
    float r = abs(6.0*hue - 3.0) - 1.0;
    float g = 2.0 - abs(6.0*hue - 2.0);
    float b = 2.0 - abs(6.0*hue - 4.0);
    return clamp(vec3(r, g, b), 0.0, 1.0);
}

vec3 HSLToRGB(vec3 hsl)
{
    vec3 rgb = HUEtoRGB(hsl.x);
    float c = (1.0 - abs(2.0 * hsl.z - 1.0)) * hsl.y;
    rgb = (rgb - 0.5) * c + hsl.z;
    return rgb;
}

#endif // #ifdef FRAGMENT_SHADER
