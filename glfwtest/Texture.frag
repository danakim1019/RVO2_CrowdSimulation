#version 400

//vertex shader�� �̿��Ͽ� ���� �������� �̾��� primitive�� ����
//rasterizer�� �̿��ؾ� primitive�� �ش��ϴ� ��� fragment�� ������
//�̷��� fragment�鿡 ���� �۾��� �����ϴ� ��

in vec3 f_color;
in vec2 TexCoord;

uniform sampler2D ourTexture;

out vec4 FragColors;

void main()
{

	FragColors = vec4(f_color,1.0)*texture(ourTexture,TexCoord);
   //FragColors = vec4(f_color, 1.0);
}