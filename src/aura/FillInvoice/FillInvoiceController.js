({
    saveNumber : function(component, event, helper){

        var invoiceNumber = component.find("invoiceInput").get("v.value");
        var sObjectType = component.get("v.sObjectName");
        var recordId = component.get("v.recordId");

        console.log("type: " + sObjectType);
        console.log('recordId from fillInvoice: ' + recordId);

        var action;

        if (sObjectType == "Opportunity"){
            action = component.get("c.addInvoiceNumberOpp");
        }else if(sObjectType == "Account"){
            action = component.get("c.addInvoiceNumberAcc");
        }

        action.setParams({
            "recordId": component.get("v.recordId"),
            "invoiceNum": invoiceNumber
        });

        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS"){
                var resultToast = $A.get("e.force:showToast");
                resultToast.setParams({
                    "type": "success",
                    "title": "Success!",
                    "message": "Invoice Number successfully added."
                });
                resultToast.fire();
                //<EVENT>
                var evt = component.getEvent("saved");
                evt.setParams({"saved": true});
                evt.fire();
                //</EVENT>

                if(sObjectType == "Opportunity") {
                    $A.get("e.force:closeQuickAction").fire();
                    $A.get('e.force:refreshView').fire();
                }
                console.log("fillInvoiceNumber success");

            }else{
                console.log("fillInvoiceNumber failed with state " + state);
                var resultToast = $A.get("e.force:showToast");
                resultToast.setParams({
                    "type": "error",
                    "title": "ERROR!",
                    "message": "Invoice Number is too long"
                });
                resultToast.fire();
            }
        });
        $A.enqueueAction(action);
    }
})