#version 400

layout (location = 0) in vec3 coord3d;
layout (location = 1) in vec3 v_normal;

out vec3 f_color;

struct LightInfo {
  vec4 Position; // Light position in eye coords.
  vec3 La;       // Ambient light intensity
  vec3 Ld;       // Diffuse light intensity
  vec3 Ls;       // Specular light intensity
};

uniform LightInfo Light;

struct MaterialInfo {
  vec3 Ka;            // Ambient reflectivity
  vec3 Kd;            // Diffuse reflectivity
  vec3 Ks;            // Specular reflectivity
  float Shiness;    // Specular shininess factor (phong exponent)
};
uniform MaterialInfo Material;

uniform mat4 ModelViewMatrix;
uniform mat3 NormalMatrix;
uniform mat4 mvp;

uniform mat4 myMatrix;
uniform vec3 skelMatrix[10];

uniform vec2 position;


void main()
{
	//change vertex position : ��� light ����� camera��ǥ�迡�� �̷����
	vec4 P= ModelViewMatrix * vec4(coord3d,1.0); //camera��ǥ�迡���� vertex��ġ��
	//normal ����
	vec3 N = normalize(NormalMatrix * v_normal); //local ��ǥ�迡���� normal�� ����
	
	vec3 L = normalize(vec3(Light.Position - P));	//��������� ���� vec3�� ����

	vec3 V = normalize(vec3(-P));			//CameraPositon(0,0,0) - P = -P
	vec3 R = normalize(reflect(-L,N));		//�ݻ�

	vec3 ambient = Light.La * Material.Ka;
	vec3 diffuse = Light.Ld * Material.Kd * max(dot(L,N),0);
	vec3 spec = Light.Ls * Material.Ks * pow(max(dot(R,V), 0.0), Material.Shiness);

	f_color = ambient + diffuse + spec;

	int objNum=2;
	int column = gl_InstanceID/objNum;
	int low = gl_InstanceID%objNum;

	gl_Position = mvp * vec4(coord3d+skelMatrix[gl_InstanceID%10]+vec3(position,0.0),1.0)*myMatrix;

}
