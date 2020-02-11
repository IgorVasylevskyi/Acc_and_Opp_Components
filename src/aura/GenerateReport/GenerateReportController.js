({
    /*doInit : function (component, event, helper) {
        var recordId = component.get("v.recordId");
        console.log("recordId  from generateOpp: " + recordId);

        var action = component.get("c.hasInvoiceNumber");

        action.setParams({
            "accId" : recordId
        });

        action.setCallback(this, function (response) {
            var state = response.getState();

            if (state === "SUCCESS"){
                console.log('doInit success');
                component.set("v.hasNumber", response.getReturnValue());
                var retVal = response.getReturnValue();

            }else{
                //$A.get("e.force:closeQuickAction").fire();
                component.set("v.noError", false);
                console.log("doInit failed with state: " + state);

                /*var resultToast = $A.get("e.force:showToast");
                resultToast.setParams({
                    "type": "warning",
                    "title": "Warning!",
                    "message": "The Account doesn't have main opp or has more than one."
                });
                resultToast.fire();
            }
        });
        $A.enqueueAction(action);
    }*/
})