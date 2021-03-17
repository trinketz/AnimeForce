({
    displayFeaturedAnime: function(component, event, helper) {
        let action = component.get('c.getFeaturedAnime');
        action.setCallback(this, function(response){
            if(response.getState() == 'SUCCESS'){
                component.set('v.images', response.getReturnValue());
            }
        });

        $A.enqueueAction(action);
    },

    hello: function(component, event, helper){
        alert('hello');
    }
})