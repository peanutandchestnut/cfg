#version 430 core

in vertex_data
{
  vec4 color;
} fi;

out vec4 frag_color;

void main(void)
{
  frag_color = fi.color;
}
