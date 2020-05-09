// raylib-zig (c) Nikolas Wipper 2020

#include <raylib.h>

Ray WGetMouseRay(Vector2 *mousePosition, Camera camera)
{
    return GetMouseRay(*mousePosition, camera);
}

void WDrawPixel(int posX, int posY, Color *color)
{
    DrawPixel(posX, posY, *color);
}

void WDrawPixelV(Vector2 *position, Color *color)
{
    DrawPixelV(*position, *color);
}

void WDrawLine(int startPosX, int startPosY, int endPosX, int endPosY, Color *color)
{
    DrawLine(startPosX, startPosY, endPosX, endPosY, *color);
}

void WDrawLineV(Vector2 *startPos, Vector2 *endPos, Color *color)
{
    DrawLineV(*startPos, *endPos, *color);
}

void WDrawLineEx(Vector2 *startPos, Vector2 *endPos, float thick, Color *color)
{
    DrawLineEx(*startPos, *endPos, thick, *color);
}

void WDrawLineBezier(Vector2 *startPos, Vector2 *endPos, float thick, Color *color)
{
    DrawLineBezier(*startPos, *endPos, thick, *color);
}

void WDrawLineStrip(Vector2 *points, int numPoints, Color *color)
{
    DrawLineStrip(points, numPoints, *color);
}

void WDrawCircle(int centerX, int centerY, float radius, Color *color)
{
    DrawCircle(centerX, centerY, radius, *color);
}

void WDrawCircleSector(Vector2 *center, float radius, int startAngle, int endAngle, int segments, Color *color)
{
    DrawCircleSector(*center, radius, startAngle, endAngle, segments, *color);
}

void WDrawCircleSectorLines(Vector2 *center, float radius, int startAngle, int endAngle, int segments, Color *color)
{
    DrawCircleSectorLines(*center, radius, startAngle, endAngle, segments, *color);
}

void WDrawCircleGradient(int centerX, int centerY, float radius, Color *color1, Color *color2)
{
    DrawCircleGradient(centerX, centerY, radius, *color1, *color2);
}

void WDrawCircleV(Vector2 *center, float radius, Color *color)
{
    DrawCircleV(*center, radius, *color);
}

void WDrawCircleLines(int centerX, int centerY, float radius, Color *color)
{
    DrawCircleLines(centerX, centerY, radius, *color);
}

void WDrawEllipse(int centerX, int centerY, float radiusH, float radiusV, Color *color)
{
    DrawEllipse(centerX, centerY, radiusH, radiusV, *color);
}

void WDrawEllipseLines(int centerX, int centerY, float radiusH, float radiusV, Color *color)
{
    DrawEllipseLines(centerX, centerY, radiusH, radiusV, *color);
}

void WDrawRing(Vector2 *center, float innerRadius, float outerRadius, int startAngle, int endAngle, int segments, Color *color)
{
    DrawRing(*center, innerRadius, outerRadius, startAngle, endAngle, segments, *color);
}

void WDrawRingLines(Vector2 *center, float innerRadius, float outerRadius, int startAngle, int endAngle, int segments, Color *color)
{
    DrawRingLines(*center, innerRadius, outerRadius, startAngle, endAngle, segments, *color);
}

void WDrawRectangle(int posX, int posY, int width, int height, Color *color)
{
    DrawRectangle(posX, posY, width, height, *color);
}

void WDrawRectangleV(Vector2 *position, Vector2 *size, Color *color)
{
    DrawRectangleV(*position, *size, *color);
}

void WDrawRectangleRec(Rectangle *rec, Color *color)
{
    DrawRectangleRec(*rec, *color);
}

void WDrawRectanglePro(Rectangle *rec, Vector2 *origin, float rotation, Color *color)
{
    DrawRectanglePro(*rec, *origin, rotation, *color);
}

void WDrawRectangleGradientV(int posX, int posY, int width, int height, Color *color1, Color *color2)
{
    DrawRectangleGradientV(posX, posY, width, height, *color1, *color2);
}

void WDrawRectangleGradientH(int posX, int posY, int width, int height, Color *color1, Color *color2)
{
    DrawRectangleGradientH(posX, posY, width, height, *color1, *color2);
}

void WDrawRectangleGradientEx(Rectangle *rec, Color *col1, Color *col2, Color *col3, Color *col4)
{
    DrawRectangleGradientEx(*rec, *col1, *col2, *col3, *col4);
}

void WDrawRectangleLines(int posX, int posY, int width, int height, Color *color)
{
    DrawRectangleLines(posX, posY, width, height, *color);
}

void WDrawRectangleLinesEx(Rectangle *rec, int lineThick, Color *color)
{
    DrawRectangleLinesEx(*rec, lineThick, *color);
}

void WDrawRectangleRounded(Rectangle *rec, float roundness, int segments, Color *color)
{
    DrawRectangleRounded(*rec, roundness, segments, *color);
}

void WDrawRectangleRoundedLines(Rectangle *rec, float roundness, int segments, int lineThick, Color *color)
{
    DrawRectangleRoundedLines(*rec, roundness, segments, lineThick, *color);
}

void WDrawTriangle(Vector2 *v1, Vector2 *v2, Vector2 *v3, Color *color)
{
    DrawTriangle(*v1, *v2, *v3, *color);
}

void WDrawTriangleLines(Vector2 *v1, Vector2 *v2, Vector2 *v3, Color *color)
{
    DrawTriangleLines(*v1, *v2, *v3, *color);
}

void WDrawTriangleFan(Vector2 *points, int numPoints, Color *color)
{
    DrawTriangleFan(points, numPoints, *color);
}

void WDrawTriangleStrip(Vector2 *points, int pointsCount, Color *color)
{
    DrawTriangleStrip(points, pointsCount, *color);
}

void WDrawPoly(Vector2 *center, int sides, float radius, float rotation, Color *color)
{
    DrawPoly(*center, sides, radius, rotation, *color);
}

void WDrawPolyLines(Vector2 *center, int sides, float radius, float rotation, Color *color)
{
    DrawPolyLines(*center, sides, radius, rotation, *color);
}

bool WCheckCollisionRecs(Rectangle *rec1, Rectangle *rec2)
{
    return CheckCollisionRecs(*rec1, *rec2);
}

bool WCheckCollisionCircles(Vector2 *center1, float radius1, Vector2 *center2, float radius2)
{
    return CheckCollisionCircles(*center1, radius1, *center2, radius2);
}

bool WCheckCollisionCircleRec(Vector2 *center, float radius, Rectangle *rec)
{
    return CheckCollisionCircleRec(*center, radius, *rec);
}

bool WCheckCollisionPointRec(Vector2 *point, Rectangle *rec)
{
    return CheckCollisionPointRec(*point, *rec);
}

bool WCheckCollisionPointCircle(Vector2 *point, Vector2 *center, float radius)
{
    return CheckCollisionPointCircle(*point, *center, radius);
}

bool WCheckCollisionPointTriangle(Vector2 *point, Vector2 *p1, Vector2 *p2, Vector2 *p3)
{
    return CheckCollisionPointTriangle(*point, *p1, *p2, *p3);
}

void WDrawSphere(Vector3 *centerPos, float radius, Color *color)
{
    DrawSphere(*centerPos, radius, *color);
}

void WDrawRay(Ray ray, Color *color)
{
    DrawRay(ray, *color);
}

