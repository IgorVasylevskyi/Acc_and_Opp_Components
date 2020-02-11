({
    doInit : function (component, event, handler) {
        var recordId = component.get("v.recordId");
        console.log("main doInit executed");
        var action = component.get("c.hasInvoiceNumber");

        action.setParams({
            "accId" : recordId
        });

        action.setCallback(this, function (response) {
            var state = response.getState();

            if(state === "SUCCESS"){
                component.set("v.hasNumber", response.getReturnValue());
                console.log("main doInit ret val: " + response.getReturnValue());

            }else {
                console.log("main doInit failed with state: " + state);
                component.set("v.noError", false);
            }
        });
        $A.enqueueAction(action);
    },

    changeShowGenerate: function (component, event, handler) {

        var fromEvt = event.getParam("saved");
        component.set("v.hasNumber", fromEvt);
    },
})