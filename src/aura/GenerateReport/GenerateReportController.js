({
    doInit : function (component, event, helper) {
        var recordId = component.get("v.recordId");

        var action = component.get("c.getTypes");

        action.setParams({
            "accId" : recordId
        });
        action.setCallback(this, function (response) {
            var state = response.getState();
            if(state === "SUCCESS"){
                console.log("GenerateReport doInit success");
                component.set("v.types", response.getReturnValue());

            }else{
                console.log("GenReport doInit failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    },

    generate : function (component, event, helper) {
        $A.get("e.force:closeQuickAction").fire();
    }
})