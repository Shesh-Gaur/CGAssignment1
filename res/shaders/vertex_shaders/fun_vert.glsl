#version 440

// Include our common vertex shader attributes and uniforms
#include "../fragments/vs_common.glsl"

struct Material {
	sampler2D Diffuse;
	sampler2D Height;
};

uniform Material u_Material;


void main() {
	if (u_Toggle >= 4)
	{
		float scaledTime = u_Time * 0.1;

		float height = texture(u_Material.Height, inUV + scaledTime).r;
		vec3 posResult = vec3(inPosition.x, height * 3.0 + sin(inPosition.x *0.5), inPosition.z);

		outWorldPos = (u_Model * vec4(posResult , 1.0)).xyz;
		gl_Position = u_ModelViewProjection * vec4(posResult, 1.0);

		outNormal = mat3(u_NormalMatrix) * inNormal;
		outUV = inUV;
		outColor = inColor;
	}
	else
	{

		outWorldPos = (u_Model * vec4(inPosition , 1.0)).xyz;
		gl_Position = u_ModelViewProjection * vec4(inPosition, 1.0);

		outNormal = mat3(u_NormalMatrix) * inNormal;
		outUV = inUV;
		outColor = inColor;
	}

}

