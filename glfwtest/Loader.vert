#version 450 core
layout (location = 0) in vec3 coord3d;
layout(location=1) in vec3 v_normal;
layout(location=2) in vec3 texCoords;
out vec3 color;

layout(std430, binding = 1) buffer ssbo2  //for moving characters
{
	mat4 offset[];
};


uniform vec4 LightPosition;
uniform vec3 Ka;
uniform vec3 Kd;
uniform vec3 Ks;
uniform vec3 LightIntensity;

uniform vec2 agentPos;
uniform vec2 agentPos2;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;
uniform mat3 NormalMatrix;



void main()
{
	mat4 location = offset[gl_InstanceID];
	//change vertex position : ��� light ����� camera��ǥ�迡�� �̷����
	mat4 ModelViewMatrix = view * model;
	mat4 mvp = projection * view * model;

	vec4 P= ModelViewMatrix * vec4(coord3d,1.0); //camera��ǥ�迡���� vertex��ġ��
	//normal ����
	vec3 N = normalize(NormalMatrix * v_normal); //local ��ǥ�迡���� normal�� ����
	
	vec3 L = normalize(vec3(LightPosition - P));	//��������� ���� vec3�� ����

	vec3 V = normalize(vec3(-P));			//CameraPositon(0,0,0) - P = -P
	vec3 R = normalize(reflect(-L,N));		//�ݻ�

	vec3 ambient = LightIntensity * Ka;
	vec3 diffuse = LightIntensity * Kd * max(dot(L,N),0);
	vec3 spec = LightIntensity * Ks * pow(max(dot(R,V), 0.0), 10.0);

	color = ambient + diffuse + spec;

	//color = LightIntensity * Kd * max(0,dot(L,N));

	int personNum = 20;
	//��
	float column = gl_InstanceID/personNum;
	//��
	float raw = gl_InstanceID%personNum;

	
	gl_Position = mvp *location* vec4(coord3d,1.0);
	//gl_Position = mvp * vec4(coord3d+vec3(raw*5,0,column*5),1.0);
	//gl_Position = mvp * vec4(coord3d+vec3(agentPos[gl_InstanceID].x,0,agentPos[gl_InstanceID].y),1.0);
	//gl_Position = mvp * vec4(coord3d+vec3(agentPos[gl_InstanceID].x,0,agentPos[gl_InstanceID].y),1.0);

}
