// raylib-zig (c) Nikolas Wipper 2020

#include <raylib.h>
#include <raymath.h>

void WClearBackground(Color *color)
{
    ClearBackground(*color);
}

Ray WGetMouseRay(Vector2 *mousePosition, Camera camera)
{
    return GetMouseRay(*mousePosition, camera);
}

int WColorToInt(Color *color)
{
    return ColorToInt(*color);
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

Image WLoadImageEx(Color *pixels, int width, int height)
{
    return LoadImageEx(pixels, width, height);
}

Image WGenImageColor(int width, int height, Color *color)
{
    return GenImageColor(width, height, *color);
}

Image WGenImageGradientV(int width, int height, Color *top, Color *bottom)
{
    return GenImageGradientV(width, height, *top, *bottom);
}

Image WGenImageGradientH(int width, int height, Color *left, Color *right)
{
    return GenImageGradientH(width, height, *left, *right);
}

Image WGenImageGradientRadial(int width, int height, float density, Color *inner, Color *outer)
{
    return GenImageGradientRadial(width, height, density, *inner, *outer);
}

Image WGenImageChecked(int width, int height, int checksX, int checksY, Color *col1, Color *col2)
{
    return GenImageChecked(width, height, checksX, checksY, *col1, *col2);
}

Image WImageFromImage(Image image, Rectangle *rec)
{
    return ImageFromImage(image, *rec);
}

Image WImageText(char *text, int fontSize, Color *color)
{
    return ImageText(text, fontSize, *color);
}

Image WImageTextEx(Font font, char *text, float fontSize, float spacing, Color *tint)
{
    return ImageTextEx(font, text, fontSize, spacing, *tint);
}

void WImageToPOT(Image *image, Color *fillColor)
{
    ImageToPOT(image, *fillColor);
}

void WImageAlphaClear(Image *image, Color *color, float threshold)
{
    ImageAlphaClear(image, *color, threshold);
}

void WImageCrop(Image *image, Rectangle *crop)
{
    ImageCrop(image, *crop);
}

void WImageResizeCanvas(Image *image, int newWidth, int newHeight, int offsetX, int offsetY, Color *color)
{
    ImageResizeCanvas(image, newWidth, newHeight, offsetX, offsetY, *color);
}

void WImageColorTint(Image *image, Color *color)
{
    ImageColorTint(image, *color);
}

void WImageColorReplace(Image *image, Color *color, Color *replace)
{
    ImageColorReplace(image, *color, *replace);
}

void WImageClearBackground(Image *dst, Color *color)
{
    ImageClearBackground(dst, *color);
}

void WImageDrawPixel(Image *dst, int posX, int posY, Color *color)
{
    ImageDrawPixel(dst, posX, posY, *color);
}

void WImageDrawPixelV(Image *dst, Vector2 *position, Color *color)
{
    ImageDrawPixelV(dst, *position, *color);
}

void WImageDrawLine(Image *dst, int startPosX, int startPosY, int endPosX, int endPosY, Color *color)
{
    ImageDrawLine(dst, startPosX, startPosY, endPosX, endPosY, *color);
}

void WImageDrawLineV(Image *dst, Vector2 *start, Vector2 *end, Color *color)
{
    ImageDrawLineV(dst, *start, *end, *color);
}

void WImageDrawCircle(Image *dst, int centerX, int centerY, int radius, Color *color)
{
    ImageDrawCircle(dst, centerX, centerY, radius, *color);
}

void WImageDrawCircleV(Image *dst, Vector2 *center, int radius, Color *color)
{
    ImageDrawCircleV(dst, *center, radius, *color);
}

void WImageDrawRectangle(Image *dst, int posX, int posY, int width, int height, Color *color)
{
    ImageDrawRectangle(dst, posX, posY, width, height, *color);
}

void WImageDrawRectangleV(Image *dst, Vector2 *position, Vector2 *size, Color *color)
{
    ImageDrawRectangleV(dst, *position, *size, *color);
}

void WImageDrawRectangleRec(Image *dst, Rectangle *rec, Color *color)
{
    ImageDrawRectangleRec(dst, *rec, *color);
}

void WImageDrawRectangleLines(Image *dst, Rectangle *rec, int thick, Color *color)
{
    ImageDrawRectangleLines(dst, *rec, thick, *color);
}

void WImageDraw(Image *dst, Image src, Rectangle *srcRec, Rectangle *dstRec, Color *tint)
{
    ImageDraw(dst, src, *srcRec, *dstRec, *tint);
}

void WImageDrawText(Image *dst, Vector2 *position, char *text, int fontSize, Color *color)
{
    ImageDrawText(dst, *position, text, fontSize, *color);
}

void WImageDrawTextEx(Image *dst, Vector2 *position, Font font, char *text, float fontSize, float spacing, Color *color)
{
    ImageDrawTextEx(dst, *position, font, text, fontSize, spacing, *color);
}

void WDrawTexture(Texture2D texture, int posX, int posY, Color *tint)
{
    DrawTexture(texture, posX, posY, *tint);
}

void WDrawTextureV(Texture2D texture, Vector2 *position, Color *tint)
{
    DrawTextureV(texture, *position, *tint);
}

void WDrawTextureEx(Texture2D texture, Vector2 *position, float rotation, float scale, Color *tint)
{
    DrawTextureEx(texture, *position, rotation, scale, *tint);
}

void WDrawTextureRec(Texture2D texture, Rectangle *sourceRec, Vector2 *position, Color *tint)
{
    DrawTextureRec(texture, *sourceRec, *position, *tint);
}

void WDrawTextureQuad(Texture2D texture, Vector2 *tiling, Vector2 *offset, Rectangle *quad, Color *tint)
{
    DrawTextureQuad(texture, *tiling, *offset, *quad, *tint);
}

void WDrawTexturePro(Texture2D texture, Rectangle *sourceRec, Rectangle *destRec, Vector2 *origin, float rotation, Color *tint)
{
    DrawTexturePro(texture, *sourceRec, *destRec, *origin, rotation, *tint);
}

void WDrawTextureNPatch(Texture2D texture, NPatchInfo nPatchInfo, Rectangle *destRec, Vector2 *origin, float rotation, Color *tint)
{
    DrawTextureNPatch(texture, nPatchInfo, *destRec, *origin, rotation, *tint);
}

Font WLoadFontFromImage(Image image, Color *key, int firstChar)
{
    return LoadFontFromImage(image, *key, firstChar);
}

Image WGenImageFontAtlas(CharInfo *chars, Rectangle **recs, int charsCount, int fontSize, int padding, int packMethod)
{
    return GenImageFontAtlas(chars, recs, charsCount, fontSize, padding, packMethod);
}

void WDrawText(char *text, int posX, int posY, int fontSize, Color *color)
{
    DrawText(text, posX, posY, fontSize, *color);
}

void WDrawTextEx(Font font, char *text, Vector2 *position, float fontSize, float spacing, Color *tint)
{
    DrawTextEx(font, text, *position, fontSize, spacing, *tint);
}

void WDrawTextRec(Font font, char *text, Rectangle *rec, float fontSize, float spacing, bool wordWrap, Color *tint)
{
    DrawTextRec(font, text, *rec, fontSize, spacing, wordWrap, *tint);
}

void WDrawTextRecEx(Font font, char *text, Rectangle *rec, float fontSize, float spacing, bool wordWrap, Color *tint, int selectStart, int selectLength, Color *selectTint, Color *selectBackTint)
{
    DrawTextRecEx(font, text, *rec, fontSize, spacing, wordWrap, *tint, selectStart, selectLength, *selectTint, *selectBackTint);
}

void WDrawTextCodepoint(Font font, int codepoint, Vector2 *position, float scale, Color *tint)
{
    DrawTextCodepoint(font, codepoint, *position, scale, *tint);
}

void WDrawLine3D(Vector3 *startPos, Vector3 *endPos, Color *color)
{
    DrawLine3D(*startPos, *endPos, *color);
}

void WDrawPoint3D(Vector3 *position, Color *color)
{
    DrawPoint3D(*position, *color);
}

void WDrawCircle3D(Vector3 *center, float radius, Vector3 *rotationAxis, float rotationAngle, Color *color)
{
    DrawCircle3D(*center, radius, *rotationAxis, rotationAngle, *color);
}

void WDrawCube(Vector3 *position, float width, float height, float length, Color *color)
{
    DrawCube(*position, width, height, length, *color);
}

void WDrawCubeV(Vector3 *position, Vector3 *size, Color *color)
{
    DrawCubeV(*position, *size, *color);
}

void WDrawCubeWires(Vector3 *position, float width, float height, float length, Color *color)
{
    DrawCubeWires(*position, width, height, length, *color);
}

void WDrawCubeWiresV(Vector3 *position, Vector3 *size, Color *color)
{
    DrawCubeWiresV(*position, *size, *color);
}

void WDrawCubeTexture(Texture2D texture, Vector3 *position, float width, float height, float length, Color *color)
{
    DrawCubeTexture(texture, *position, width, height, length, *color);
}

void WDrawSphere(Vector3 *centerPos, float radius, Color *color)
{
    DrawSphere(*centerPos, radius, *color);
}

void WDrawSphereEx(Vector3 *centerPos, float radius, int rings, int slices, Color *color)
{
    DrawSphereEx(*centerPos, radius, rings, slices, *color);
}

void WDrawSphereWires(Vector3 *centerPos, float radius, int rings, int slices, Color *color)
{
    DrawSphereWires(*centerPos, radius, rings, slices, *color);
}

void WDrawCylinder(Vector3 *position, float radiusTop, float radiusBottom, float height, int slices, Color *color)
{
    DrawCylinder(*position, radiusTop, radiusBottom, height, slices, *color);
}

void WDrawCylinderWires(Vector3 *position, float radiusTop, float radiusBottom, float height, int slices, Color *color)
{
    DrawCylinderWires(*position, radiusTop, radiusBottom, height, slices, *color);
}

void WDrawPlane(Vector3 *centerPos, Vector2 *size, Color *color)
{
    DrawPlane(*centerPos, *size, *color);
}

void WDrawRay(Ray ray, Color *color)
{
    DrawRay(ray, *color);
}

void WDrawGizmo(Vector3 *position)
{
    DrawGizmo(*position);
}

Mesh WGenMeshHeightmap(Image heightmap, Vector3 *size)
{
    return GenMeshHeightmap(heightmap, *size);
}

Mesh WGenMeshCubicmap(Image cubicmap, Vector3 *cubeSize)
{
    return GenMeshCubicmap(cubicmap, *cubeSize);
}

void WDrawModel(Model model, Vector3 *position, float scale, Color *tint)
{
    DrawModel(model, *position, scale, *tint);
}

void WDrawModelEx(Model model, Vector3 *position, Vector3 *rotationAxis, float rotationAngle, Vector3 *scale, Color *tint)
{
    DrawModelEx(model, *position, *rotationAxis, rotationAngle, *scale, *tint);
}

void WDrawModelWires(Model model, Vector3 *position, float scale, Color *tint)
{
    DrawModelWires(model, *position, scale, *tint);
}

void WDrawModelWiresEx(Model model, Vector3 *position, Vector3 *rotationAxis, float rotationAngle, Vector3 *scale, Color *tint)
{
    DrawModelWiresEx(model, *position, *rotationAxis, rotationAngle, *scale, *tint);
}

void WDrawBoundingBox(BoundingBox box, Color *color)
{
    DrawBoundingBox(box, *color);
}

void WDrawBillboard(Camera camera, Texture2D texture, Vector3 *center, float size, Color *tint)
{
    DrawBillboard(camera, texture, *center, size, *tint);
}

void WDrawBillboardRec(Camera camera, Texture2D texture, Rectangle *sourceRec, Vector3 *center, float size, Color *tint)
{
    DrawBillboardRec(camera, texture, *sourceRec, *center, size, *tint);
}

bool WCheckCollisionSpheres(Vector3 *centerA, float radiusA, Vector3 *centerB, float radiusB)
{
    return CheckCollisionSpheres(*centerA, radiusA, *centerB, radiusB);
}

bool WCheckCollisionBoxSphere(BoundingBox box, Vector3 *center, float radius)
{
    return CheckCollisionBoxSphere(box, *center, radius);
}

bool WCheckCollisionRaySphere(Ray ray, Vector3 *center, float radius)
{
    return CheckCollisionRaySphere(ray, *center, radius);
}

bool WCheckCollisionRaySphereEx(Ray ray, Vector3 *center, float radius, Vector3 *collisionPoint)
{
    return CheckCollisionRaySphereEx(ray, *center, radius, collisionPoint);
}

RayHitInfo WGetCollisionRayTriangle(Ray ray, Vector3 *p1, Vector3 *p2, Vector3 *p3)
{
    return GetCollisionRayTriangle(ray, *p1, *p2, *p3);
}

void WUnloadShader(Shader *shader)
{
    UnloadShader(*shader);
}

void WSetShapesTexture(Texture2D texture, Rectangle *source)
{
    SetShapesTexture(texture, *source);
}

int WGetShaderLocation(Shader *shader, char *uniformName)
{
    return GetShaderLocation(*shader, uniformName);
}

void WSetShaderValue(Shader *shader, int uniformLoc, void *value, int uniformType)
{
    SetShaderValue(*shader, uniformLoc, value, uniformType);
}

void WSetShaderValueV(Shader *shader, int uniformLoc, void *value, int uniformType, int count)
{
    SetShaderValueV(*shader, uniformLoc, value, uniformType, count);
}

void WSetShaderValueMatrix(Shader *shader, int uniformLoc, Matrix mat)
{
    SetShaderValueMatrix(*shader, uniformLoc, mat);
}

void WSetShaderValueTexture(Shader *shader, int uniformLoc, Texture2D texture)
{
    SetShaderValueTexture(*shader, uniformLoc, texture);
}

Texture2D WGenTextureCubemap(Shader *shader, Texture2D map, int size)
{
    return GenTextureCubemap(*shader, map, size);
}

Texture2D WGenTextureIrradiance(Shader *shader, Texture2D cubemap, int size)
{
    return GenTextureIrradiance(*shader, cubemap, size);
}

Texture2D WGenTexturePrefilter(Shader *shader, Texture2D cubemap, int size)
{
    return GenTexturePrefilter(*shader, cubemap, size);
}

Texture2D WGenTextureBRDF(Shader *shader, int size)
{
    return GenTextureBRDF(*shader, size);
}

void WBeginShaderMode(Shader *shader)
{
    BeginShaderMode(*shader);
}

void WSetVrConfiguration(VrDeviceInfo info, Shader *distortion)
{
    SetVrConfiguration(info, *distortion);
}

float WVector2Length(Vector2 *v)
{
    return Vector2Length(*v);
}

float WVector2DotProduct(Vector2 *v1, Vector2 *v2)
{
    return Vector2DotProduct(*v1, *v2);
}

float WVector2Distance(Vector2 *v1, Vector2 *v2)
{
    return Vector2Distance(*v1, *v2);
}

float WVector2Angle(Vector2 *v1, Vector2 *v2)
{
    return Vector2Angle(*v1, *v2);
}

float WVector3Length(Vector3 *v)
{
    return Vector3Length(*v);
}

float WVector3DotProduct(Vector3 *v1, Vector3 *v2)
{
    return Vector3DotProduct(*v1, *v2);
}

float WVector3Distance(Vector3 *v1, Vector3 *v2)
{
    return Vector3Distance(*v1, *v2);
}

void WVector3OrthoNormalize(Vector3 *v1, Vector3 *v2)
{
    Vector3OrthoNormalize(v1, v2);
}

Matrix WMatrixRotate(Vector3 *axis, float angle)
{
    return MatrixRotate(*axis, angle);
}

Matrix WMatrixRotateXYZ(Vector3 *ang)
{
    return MatrixRotateXYZ(*ang);
}

Matrix WMatrixLookAt(Vector3 *eye, Vector3 *target, Vector3 *up)
{
    return MatrixLookAt(*eye, *target, *up);
}

float WQuaternionLength(Quaternion *q)
{
    return QuaternionLength(*q);
}

Matrix WQuaternionToMatrix(Quaternion *q)
{
    return QuaternionToMatrix(*q);
}

void WQuaternionToAxisAngle(Quaternion *q, Vector3 *outAxis, float *outAngle)
{
    QuaternionToAxisAngle(*q, outAxis, outAngle);
}

