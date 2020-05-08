// raylib-zig (c) Nikolas Wipper 2020

#ifndef RAYLIB_ZIG_WORKAROUND_H
#define RAYLIB_ZIG_WORKAROUND_H

#include <raylib.h>

#define VECTOR2 float x, float y
#define VECTOR3 float x, float y, float z
#define COLOR unsigned char r, unsigned char g, unsigned char b, unsigned char a

Ray WGetMouseRay(Vector2 * mousePosition, Camera camera);

void WDrawSphere(Vector3 * centerPos, float radius, Color * color);
void WDrawRay(Ray ray, Color * color);

#endif //RAYLIB_ZIG_WORKAROUND_H
