pub extern fn WGetMouseRay(mousePosition: [*c]const Vector2, camera: Camera) Ray;
pub extern fn WDrawPixel(posX: c_int, posY: c_int, color: [*c]const Color) void;
pub extern fn WDrawPixelV(position: [*c]const Vector2, color: [*c]const Color) void;
pub extern fn WDrawLine(startPosX: c_int, startPosY: c_int, endPosX: c_int, endPosY: c_int, color: [*c]const Color) void;
pub extern fn WDrawLineV(startPos: [*c]const Vector2, endPos: [*c]const Vector2, color: [*c]const Color) void;
pub extern fn WDrawLineEx(startPos: [*c]const Vector2, endPos: [*c]const Vector2, thick: f32, color: [*c]const Color) void;
pub extern fn WDrawLineBezier(startPos: [*c]const Vector2, endPos: [*c]const Vector2, thick: f32, color: [*c]const Color) void;
pub extern fn WDrawLineStrip(points: [*c]const Vector2, numPoints: c_int, color: [*c]const Color) void;
pub extern fn WDrawCircle(centerX: c_int, centerY: c_int, radius: f32, color: [*c]const Color) void;
pub extern fn WDrawCircleSector(center: [*c]const Vector2, radius: f32, startAngle: c_int, endAngle: c_int, segments: c_int, color: [*c]const Color) void;
pub extern fn WDrawCircleSectorLines(center: [*c]const Vector2, radius: f32, startAngle: c_int, endAngle: c_int, segments: c_int, color: [*c]const Color) void;
pub extern fn WDrawCircleGradient(centerX: c_int, centerY: c_int, radius: f32, color1: [*c]const Color, color2: [*c]const Color) void;
pub extern fn WDrawCircleV(center: [*c]const Vector2, radius: f32, color: [*c]const Color) void;
pub extern fn WDrawCircleLines(centerX: c_int, centerY: c_int, radius: f32, color: [*c]const Color) void;
pub extern fn WDrawEllipse(centerX: c_int, centerY: c_int, radiusH: f32, radiusV: f32, color: [*c]const Color) void;
pub extern fn WDrawEllipseLines(centerX: c_int, centerY: c_int, radiusH: f32, radiusV: f32, color: [*c]const Color) void;
pub extern fn WDrawRing(center: [*c]const Vector2, innerRadius: f32, outerRadius: f32, startAngle: c_int, endAngle: c_int, segments: c_int, color: [*c]const Color) void;
pub extern fn WDrawRingLines(center: [*c]const Vector2, innerRadius: f32, outerRadius: f32, startAngle: c_int, endAngle: c_int, segments: c_int, color: [*c]const Color) void;
pub extern fn WDrawRectangle(posX: c_int, posY: c_int, width: c_int, height: c_int, color: [*c]const Color) void;
pub extern fn WDrawRectangleV(position: [*c]const Vector2, size: [*c]const Vector2, color: [*c]const Color) void;
pub extern fn WDrawRectangleRec(rec: [*c]const Rectangle, color: [*c]const Color) void;
pub extern fn WDrawRectanglePro(rec: [*c]const Rectangle, origin: [*c]const Vector2, rotation: f32, color: [*c]const Color) void;
pub extern fn WDrawRectangleGradientV(posX: c_int, posY: c_int, width: c_int, height: c_int, color1: [*c]const Color, color2: [*c]const Color) void;
pub extern fn WDrawRectangleGradientH(posX: c_int, posY: c_int, width: c_int, height: c_int, color1: [*c]const Color, color2: [*c]const Color) void;
pub extern fn WDrawRectangleGradientEx(rec: [*c]const Rectangle, col1: [*c]const Color, col2: [*c]const Color, col3: [*c]const Color, col4: [*c]const Color) void;
pub extern fn WDrawRectangleLines(posX: c_int, posY: c_int, width: c_int, height: c_int, color: [*c]const Color) void;
pub extern fn WDrawRectangleLinesEx(rec: [*c]const Rectangle, lineThick: c_int, color: [*c]const Color) void;
pub extern fn WDrawRectangleRounded(rec: [*c]const Rectangle, roundness: f32, segments: c_int, color: [*c]const Color) void;
pub extern fn WDrawRectangleRoundedLines(rec: [*c]const Rectangle, roundness: f32, segments: c_int, lineThick: c_int, color: [*c]const Color) void;
pub extern fn WDrawTriangle(v1: [*c]const Vector2, v2: [*c]const Vector2, v3: [*c]const Vector2, color: [*c]const Color) void;
pub extern fn WDrawTriangleLines(v1: [*c]const Vector2, v2: [*c]const Vector2, v3: [*c]const Vector2, color: [*c]const Color) void;
pub extern fn WDrawTriangleFan(points: [*c]const Vector2, numPoints: c_int, color: [*c]const Color) void;
pub extern fn WDrawTriangleStrip(points: [*c]const Vector2, pointsCount: c_int, color: [*c]const Color) void;
pub extern fn WDrawPoly(center: [*c]const Vector2, sides: c_int, radius: f32, rotation: f32, color: [*c]const Color) void;
pub extern fn WDrawPolyLines(center: [*c]const Vector2, sides: c_int, radius: f32, rotation: f32, color: [*c]const Color) void;
pub extern fn WCheckCollisionRecs(rec1: [*c]const Rectangle, rec2: [*c]const Rectangle) bool;
pub extern fn WCheckCollisionCircles(center1: [*c]const Vector2, radius1: f32, center2: [*c]const Vector2, radius2: f32) bool;
pub extern fn WCheckCollisionCircleRec(center: [*c]const Vector2, radius: f32, rec: [*c]const Rectangle) bool;
pub extern fn WCheckCollisionPointRec(point: [*c]const Vector2, rec: [*c]const Rectangle) bool;
pub extern fn WCheckCollisionPointCircle(point: [*c]const Vector2, center: [*c]const Vector2, radius: f32) bool;
pub extern fn WCheckCollisionPointTriangle(point: [*c]const Vector2, p1: [*c]const Vector2, p2: [*c]const Vector2, p3: [*c]const Vector2) bool;
pub extern fn WDrawSphere(centerPos: [*c]const Vector3, radius: f32, color: [*c]const Color) void;
pub extern fn WDrawRay(ray: Ray, color: [*c]const Color) void;

pub fn GetMouseRay(mousePosition: Vector2, camera: Camera) Ray
{
    return WGetMouseRay(&mousePosition, camera);
}

pub fn DrawPixel(posX: c_int, posY: c_int, color: Color) void
{
    WDrawPixel(posX, posY, &color);
}

pub fn DrawPixelV(position: Vector2, color: Color) void
{
    WDrawPixelV(&position, &color);
}

pub fn DrawLine(startPosX: c_int, startPosY: c_int, endPosX: c_int, endPosY: c_int, color: Color) void
{
    WDrawLine(startPosX, startPosY, endPosX, endPosY, &color);
}

pub fn DrawLineV(startPos: Vector2, endPos: Vector2, color: Color) void
{
    WDrawLineV(&startPos, &endPos, &color);
}

pub fn DrawLineEx(startPos: Vector2, endPos: Vector2, thick: f32, color: Color) void
{
    WDrawLineEx(&startPos, &endPos, thick, &color);
}

pub fn DrawLineBezier(startPos: Vector2, endPos: Vector2, thick: f32, color: Color) void
{
    WDrawLineBezier(&startPos, &endPos, thick, &color);
}

pub fn DrawLineStrip(points: []const Vector2, numPoints: c_int, color: Color) void
{
    WDrawLineStrip(&points[0], numPoints, &color);
}

pub fn DrawCircle(centerX: c_int, centerY: c_int, radius: f32, color: Color) void
{
    WDrawCircle(centerX, centerY, radius, &color);
}

pub fn DrawCircleSector(center: Vector2, radius: f32, startAngle: c_int, endAngle: c_int, segments: c_int, color: Color) void
{
    WDrawCircleSector(&center, radius, startAngle, endAngle, segments, &color);
}

pub fn DrawCircleSectorLines(center: Vector2, radius: f32, startAngle: c_int, endAngle: c_int, segments: c_int, color: Color) void
{
    WDrawCircleSectorLines(&center, radius, startAngle, endAngle, segments, &color);
}

pub fn DrawCircleGradient(centerX: c_int, centerY: c_int, radius: f32, color1: Color, color2: Color) void
{
    WDrawCircleGradient(centerX, centerY, radius, &color1, &color2);
}

pub fn DrawCircleV(center: Vector2, radius: f32, color: Color) void
{
    WDrawCircleV(&center, radius, &color);
}

pub fn DrawCircleLines(centerX: c_int, centerY: c_int, radius: f32, color: Color) void
{
    WDrawCircleLines(centerX, centerY, radius, &color);
}

pub fn DrawEllipse(centerX: c_int, centerY: c_int, radiusH: f32, radiusV: f32, color: Color) void
{
    WDrawEllipse(centerX, centerY, radiusH, radiusV, &color);
}

pub fn DrawEllipseLines(centerX: c_int, centerY: c_int, radiusH: f32, radiusV: f32, color: Color) void
{
    WDrawEllipseLines(centerX, centerY, radiusH, radiusV, &color);
}

pub fn DrawRing(center: Vector2, innerRadius: f32, outerRadius: f32, startAngle: c_int, endAngle: c_int, segments: c_int, color: Color) void
{
    WDrawRing(&center, innerRadius, outerRadius, startAngle, endAngle, segments, &color);
}

pub fn DrawRingLines(center: Vector2, innerRadius: f32, outerRadius: f32, startAngle: c_int, endAngle: c_int, segments: c_int, color: Color) void
{
    WDrawRingLines(&center, innerRadius, outerRadius, startAngle, endAngle, segments, &color);
}

pub fn DrawRectangle(posX: c_int, posY: c_int, width: c_int, height: c_int, color: Color) void
{
    WDrawRectangle(posX, posY, width, height, &color);
}

pub fn DrawRectangleV(position: Vector2, size: Vector2, color: Color) void
{
    WDrawRectangleV(&position, &size, &color);
}

pub fn DrawRectangleRec(rec: Rectangle, color: Color) void
{
    WDrawRectangleRec(&rec, &color);
}

pub fn DrawRectanglePro(rec: Rectangle, origin: Vector2, rotation: f32, color: Color) void
{
    WDrawRectanglePro(&rec, &origin, rotation, &color);
}

pub fn DrawRectangleGradientV(posX: c_int, posY: c_int, width: c_int, height: c_int, color1: Color, color2: Color) void
{
    WDrawRectangleGradientV(posX, posY, width, height, &color1, &color2);
}

pub fn DrawRectangleGradientH(posX: c_int, posY: c_int, width: c_int, height: c_int, color1: Color, color2: Color) void
{
    WDrawRectangleGradientH(posX, posY, width, height, &color1, &color2);
}

pub fn DrawRectangleGradientEx(rec: Rectangle, col1: Color, col2: Color, col3: Color, col4: Color) void
{
    WDrawRectangleGradientEx(&rec, &col1, &col2, &col3, &col4);
}

pub fn DrawRectangleLines(posX: c_int, posY: c_int, width: c_int, height: c_int, color: Color) void
{
    WDrawRectangleLines(posX, posY, width, height, &color);
}

pub fn DrawRectangleLinesEx(rec: Rectangle, lineThick: c_int, color: Color) void
{
    WDrawRectangleLinesEx(&rec, lineThick, &color);
}

pub fn DrawRectangleRounded(rec: Rectangle, roundness: f32, segments: c_int, color: Color) void
{
    WDrawRectangleRounded(&rec, roundness, segments, &color);
}

pub fn DrawRectangleRoundedLines(rec: Rectangle, roundness: f32, segments: c_int, lineThick: c_int, color: Color) void
{
    WDrawRectangleRoundedLines(&rec, roundness, segments, lineThick, &color);
}

pub fn DrawTriangle(v1: Vector2, v2: Vector2, v3: Vector2, color: Color) void
{
    WDrawTriangle(&v1, &v2, &v3, &color);
}

pub fn DrawTriangleLines(v1: Vector2, v2: Vector2, v3: Vector2, color: Color) void
{
    WDrawTriangleLines(&v1, &v2, &v3, &color);
}

pub fn DrawTriangleFan(points: []const Vector2, numPoints: c_int, color: Color) void
{
    WDrawTriangleFan(&points[0], numPoints, &color);
}

pub fn DrawTriangleStrip(points: []const Vector2, pointsCount: c_int, color: Color) void
{
    WDrawTriangleStrip(&points[0], pointsCount, &color);
}

pub fn DrawPoly(center: Vector2, sides: c_int, radius: f32, rotation: f32, color: Color) void
{
    WDrawPoly(&center, sides, radius, rotation, &color);
}

pub fn DrawPolyLines(center: Vector2, sides: c_int, radius: f32, rotation: f32, color: Color) void
{
    WDrawPolyLines(&center, sides, radius, rotation, &color);
}

pub fn CheckCollisionRecs(rec1: Rectangle, rec2: Rectangle) bool
{
    return WCheckCollisionRecs(&rec1, &rec2);
}

pub fn CheckCollisionCircles(center1: Vector2, radius1: f32, center2: Vector2, radius2: f32) bool
{
    return WCheckCollisionCircles(&center1, radius1, &center2, radius2);
}

pub fn CheckCollisionCircleRec(center: Vector2, radius: f32, rec: Rectangle) bool
{
    return WCheckCollisionCircleRec(&center, radius, &rec);
}

pub fn CheckCollisionPointRec(point: Vector2, rec: Rectangle) bool
{
    return WCheckCollisionPointRec(&point, &rec);
}

pub fn CheckCollisionPointCircle(point: Vector2, center: Vector2, radius: f32) bool
{
    return WCheckCollisionPointCircle(&point, &center, radius);
}

pub fn CheckCollisionPointTriangle(point: Vector2, p1: Vector2, p2: Vector2, p3: Vector2) bool
{
    return WCheckCollisionPointTriangle(&point, &p1, &p2, &p3);
}

pub fn DrawSphere(centerPos: Vector3, radius: f32, color: Color) void
{
    WDrawSphere(&centerPos, radius, &color);
}

pub fn DrawRay(ray: Ray, color: Color) void
{
    WDrawRay(ray, &color);
}

