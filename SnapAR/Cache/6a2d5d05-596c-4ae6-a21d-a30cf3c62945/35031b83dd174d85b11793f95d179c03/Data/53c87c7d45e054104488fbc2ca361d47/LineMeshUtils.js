"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.buildVertex = exports.buildSegment = exports.getEndWidth = exports.getTangent = exports.getSegmentNormalized = exports.getMiterOffset = void 0;
/**
 * Shifts vertices so that we can join corners of line segments w/ miter
 * @param prevSegment direction of previous vertex
 * @param nextSegment direction of next vertex
 * @param widthOffset offset of the width
 * @returns miterOffset - add or subtract this from a vertex to get offset needed
 */
function getMiterOffset(prevSegment, nextSegment, widthOffset) {
    const tangent = prevSegment.add(nextSegment).normalize();
    const miter = new vec3(-tangent.y, tangent.x, 0);
    const normalA = new vec3(-prevSegment.y, prevSegment.x, 0);
    const scaleWidth = widthOffset / miter.dot(normalA);
    return miter.uniformScale(scaleWidth);
}
exports.getMiterOffset = getMiterOffset;
function getSegmentNormalized(currentPoint, nextPoint) {
    return currentPoint.sub(nextPoint).normalize();
}
exports.getSegmentNormalized = getSegmentNormalized;
function getTangent(prevSegment, nextSegment) {
    return prevSegment.add(nextSegment).normalize();
}
exports.getTangent = getTangent;
function getEndWidth(current, next, widthAtVertex) {
    const direction = next.sub(current);
    const normalizedDir = new vec3(-direction.y, direction.x, 0).normalize();
    return normalizedDir.uniformScale(widthAtVertex);
}
exports.getEndWidth = getEndWidth;
/**
 * Builds a segment of the line using its MeshBuilder
 * @param point the position coordinates for the point
 * @param tangent of the connecting line segments
 * @param uv_v desired v coordinate for the vertex's uv map
 * vertices are shifted for thickness in the shader
 */
function buildSegment(point, prevSegment, tangent, uv_v) {
    return [
        //left vertices and tangent
        point.x,
        point.y,
        point.z,
        prevSegment.x,
        prevSegment.y,
        prevSegment.z,
        tangent.x,
        tangent.y,
        tangent.z,
        //left uv
        0,
        uv_v,
        //right vertices and tangent
        point.x,
        point.y,
        point.z,
        prevSegment.x,
        prevSegment.y,
        prevSegment.z,
        tangent.x,
        tangent.y,
        tangent.z,
        //right uv
        1,
        uv_v,
    ];
}
exports.buildSegment = buildSegment;
// Sets up data for a single line vertex, for use in setVertexInterleaved
function buildVertex(position, prevSegment, tangent, uv_u, uv_v) {
    return [
        position.x,
        position.y,
        position.z,
        prevSegment.x,
        prevSegment.y,
        prevSegment.z,
        tangent.x,
        tangent.y,
        tangent.z,
        uv_u,
        uv_v,
    ];
}
exports.buildVertex = buildVertex;
//# sourceMappingURL=LineMeshUtils.js.map