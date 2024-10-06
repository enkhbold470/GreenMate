// SimpleGPUParticlesController.js
// Version: 0.0.1
// Event: On Awake
// Description: Controls parameters on the GPU Particles material

// @input Component.RenderMeshVisual[] particles
// @ui {"widget":"group_start", "label":"Particles Settings"}
    // @input float particlesIntensity = 0.1 {"widget":"slider", "min":0.0, "max":1.0, "step":0.01}
    // @input bool advanced
    // @input int minParticles = 0 {"showIf":"advanced", "min":0}
    // @input int maxParticles = 50000 {"showIf":"advanced", "min":1} 
// @ui {"widget":"group_end"}

var minParticles = script.minParticles;
var maxParticles = script.maxParticles;
var particles = script.particles;

// validate inputs
function validateInputs() {
    for (var i = 0; i < particles.length; i++) {
        if (particles[i] == null) {
            print("ERROR: pleae make sure all Particles Visuals are assigned.");
            return false;
        }
        if (particles[i].mainMaterial == null) {
            print("ERROR: please make sure all Particle Visuals have Particle Materials assigned.");
            return false;
        }
    }
    return true;
}

if(!validateInputs()) return;


// onUpdate
function onUpdate(eventData) {
    for (var i = 0; i < script.particles.length; i++){        
        var meshVisual = script.particles[i];
        if(meshVisual ==  null) return; // prevent error when creating new array input
        var particleMat = meshVisual.mainMaterial;

        if(minParticles == 0 && script.particlesIntensity == 0){
            // Disable Particles visual when particle count is 0.
            // This is because instance count for particles materials must be >= 1
            meshVisual.enabled = false;
        } else {
            meshVisual.enabled = true;
            if(particleMat!=null) {
                particleMat.mainPass.instanceCount = lerp(minParticles, maxParticles, script.particlesIntensity);
            }
        }
    }
}
var updateEvent = script.createEvent("UpdateEvent").bind(onUpdate);


// lerp
function lerp(a, b, t) {
    return a * (1.0 - t) + b * t;
}