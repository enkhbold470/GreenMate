
const callbacks = [];

global.hoverIdx = 0;
const interactionController = script.getSceneObject().getComponent('Component.InteractionComponent');

interactionController.onHover.add(function() {
    global.hoverIdx++;
    callbacks.forEach(function(callback) {
        callback();
    });
});

script.addOnHoverCallback = function(callback) {
    callbacks.push(callback);
};
