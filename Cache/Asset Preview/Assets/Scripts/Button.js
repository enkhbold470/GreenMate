//@input Component.ScriptComponent controller
//@input string functionName
//@input string hoverFunctionName
//@input int id

const interactionComp = script.getSceneObject().getComponent('Component.InteractionComponent');

interactionComp.onTap.add(function() {
    script.controller[script.functionName](script.id);
});

interactionComp.onHoverStart.add(function() {
    if (script.hoverFunctionName.length > 0) {
        script.controller[script.hoverFunctionName](script.id, 1);
    }
});

interactionComp.onHoverEnd.add(function() {
    if (script.hoverFunctionName.length > 0) {
        script.controller[script.hoverFunctionName](script.id, 0);
    }
});

script.setId = function(newId) {
    script.id = newId;
};
