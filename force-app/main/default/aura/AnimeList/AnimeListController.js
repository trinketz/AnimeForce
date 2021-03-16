({
    displayAnimeImages : function(component, event, helper) {
        let action = component.get('c.getAnimeList');
        console.log('handler fired');
        action.setCallback(this, function(response){
            if(response.getState() == 'SUCCESS'){
                console.log(response.getReturnValue())
                component.set('v.images', response.getReturnValue());
            }
        });

        $A.enqueueAction(action);
    }
})
