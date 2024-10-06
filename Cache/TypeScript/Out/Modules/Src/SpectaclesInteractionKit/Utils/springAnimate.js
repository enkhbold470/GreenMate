"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.SpringAnimate = void 0;
class SpringAnimate {
    constructor(k, damp, mass) {
        this.k = k;
        this.damp = damp;
        this.mass = mass;
        this.velocity = vec3.zero();
    }
    /**
  * Evaluates the new position of the object based on the spring dynamics.
  * @param currentValue The current position of the object.
  * @param targetValue The target position of the object.
  * @returns The updated position of the object.
  */
    evaluate(currentValue, targetValue) {
        // Calculate the spring force for each axis
        const forceX = -this.k * (currentValue.x - targetValue.x);
        const forceY = -this.k * (currentValue.y - targetValue.y);
        const forceZ = -this.k * (currentValue.z - targetValue.z);
        const force = new vec3(forceX, forceY, forceZ);
        // Damping for each axis
        const damping = this.velocity.uniformScale(-this.damp);
        // Acceleration
        const acceleration = force.add(damping).uniformScale(1 / this.mass);
        // Update velocity
        this.velocity = this.velocity.add(acceleration.uniformScale(getDeltaTime()));
        // Update position
        const updatedValue = currentValue.add(this.velocity.uniformScale(getDeltaTime()));
        return updatedValue;
    }
    reset() {
        this.velocity = vec3.zero();
    }
}
exports.SpringAnimate = SpringAnimate;
//# sourceMappingURL=springAnimate.js.map