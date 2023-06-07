///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////
#ifdef WATER

#if defined(VERTEX) ///////////////////////////////////////////////////

// TODO: Write your vertex shader here
layout(location = 0) in vec3 aPosition;
layout(location = 2) in vec2 aTexCoord;

// Uniform blocks
layout(binding = 1, std140) uniform LocalParams
{
    mat4 uWorldMatrix;
    mat4 uWorldViewProjectionMatrix;
};

out vec2 vTexCoord;
out vec4 clipSpace;

const float tiling = 6.0;

void main()
{
    clipSpace = uWorldViewProjectionMatrix * vec4(aPosition.x, 0.0, aPosition.y, 1.0);
    gl_Position = clipSpace;
//    vTexCoord = vec2(aPosition.x/2.0 + 0.5, aPosition.y/2.0 + 0.5) * tiling;
    vTexCoord = aTexCoord;
}

#elif defined(FRAGMENT) ///////////////////////////////////////////////

// TODO: Write your fragment shader here
layout(location = 0) out vec4 oColor;

in vec2 vTexCoord;
in vec4 clipSpace;

uniform sampler2D reflectionTexture;
uniform sampler2D refractionTexture;
uniform sampler2D dudvMap;

uniform float moveFactor;

const float waveStrength = 0.02;

void main()
{
    vec2 ndc = (clipSpace.xy/clipSpace.w)/2.0 + 0.5;
    vec2 refractTexCoords = vec2(ndc.x, ndc.y);
    vec2 reflectTexCoords = vec2(ndc.x, 1.0-ndc.y);

    vec2 distortion1 = (texture(dudvMap, vec2(vTexCoord.x + moveFactor, vTexCoord.y)).rg * 2.0 - 1.0) * waveStrength;
    vec2 distortion2 = (-texture(dudvMap, vec2(vTexCoord.x + moveFactor, vTexCoord.y + moveFactor)).rg * 2.0 - 1.0) * waveStrength;
    vec2 total = distortion1 + distortion2;

    refractTexCoords += distortion1;
    refractTexCoords = clamp(refractTexCoords, 0.001, 0.999);

    reflectTexCoords += distortion1;
    reflectTexCoords.x = clamp(reflectTexCoords.x, 0.001, 0.999);
    reflectTexCoords.y = clamp(reflectTexCoords.y, 0.001, 0.999);

    vec4 reflectColour = texture(reflectionTexture, reflectTexCoords + vec2(-0.1, 0.0));
    vec4 refractColour = texture(refractionTexture, refractTexCoords);

    oColor = refractColour;
    oColor = mix(oColor, vec4(0.0, 0.3, 0.5, 1.0), 0.2);
}

#endif
#endif


// NOTE: You can write several shaders in the same file if you want as
// long as you embrace them within an #ifdef block (as you can see above).
// The third parameter of the LoadProgram function in engine.cpp allows
// chosing the shader you want to load by name.
