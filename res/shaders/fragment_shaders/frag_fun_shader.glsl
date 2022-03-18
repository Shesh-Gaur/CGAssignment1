#version 430

#include "../fragments/fs_common_inputs.glsl"

// We output a single color to the color buffer
layout(location = 0) out vec4 frag_color;

////////////////////////////////////////////////////////////////
/////////////// Instance Level Uniforms ////////////////////////
////////////////////////////////////////////////////////////////

// Represents a collection of attributes that would define a material
// For instance, you can think of this like material settings in 
// Unity
struct Material {
	sampler2D Diffuse;
	sampler2D Height;	
};
// Create a uniform for the material
uniform Material u_Material;

////////////////////////////////////////////////////////////////
///////////// Application Level Uniforms ///////////////////////
////////////////////////////////////////////////////////////////

#include "../fragments/multiple_point_lights.glsl"

////////////////////////////////////////////////////////////////
/////////////// Frame Level Uniforms ///////////////////////////
////////////////////////////////////////////////////////////////


#include "../fragments/color_correction.glsl"


// https://learnopengl.com/Advanced-Lighting/Advanced-Lighting
void main() {

	if (u_Toggle >= 4)
	{
		vec3 normal = normalize(inNormal);
		float scaledTime = u_Time * 0.1;
		vec3 lightAccumulation = CalcAllLightContribution(inWorldPos, normal, u_CamPos.xyz, 0, u_Toggle);
		vec4 textureColor = texture(u_Material.Diffuse, inUV + scaledTime);
		vec3 newColor = vec3(1,0,1);
		vec3 result = lightAccumulation  * inColor * textureColor.rgb * newColor ;
		frag_color = vec4(ColorCorrect(result), textureColor.a);

	}
	else
	{
		vec3 normal = normalize(inNormal);
		vec3 lightAccumulation = CalcAllLightContribution(inWorldPos, normal, u_CamPos.xyz, 0, u_Toggle);
		vec4 textureColor = texture(u_Material.Diffuse, inUV);
		vec3 newColor = vec3(1,0,1);	
		vec3 result = lightAccumulation  * inColor * textureColor.rgb * newColor;
		frag_color = vec4(ColorCorrect(result), textureColor.a);
	}
}