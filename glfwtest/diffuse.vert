#version 400

layout(location=0) in vec3 coord3d;
layout(location=1) in vec3 v_color;

out vec3 outColor;

uniform vec4 LightLocation;
uniform vec3 Kd;
uniform vec3 Ld;

uniform vec3 color;

uniform mat4 ModelViewMatrix;
uniform mat3 NormalMatrix;
uniform mat4 mvp;
uniform mat4 location;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

void main()
{
	//change vertex position : ��� light ����� camera��ǥ�迡�� �̷����
	vec4 P= ModelViewMatrix * vec4(coord3d,1.0); //camera��ǥ�迡���� vertex��ġ��
	//normal ����
	vec3 N = normalize(NormalMatrix * v_color); //local ��ǥ�迡���� normal�� ����
	
	vec3 L = normalize(vec3(LightLocation - P));	//��������� ���� vec3�� ����

	outColor = color;

	gl_Position = projection* view *location* model * vec4(coord3d,1.0);

}
