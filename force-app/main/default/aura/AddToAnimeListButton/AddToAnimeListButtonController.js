({
    init : function(component, event, helper){
        // if anime is in list, return true, else false
        let action = component.get('c.hasAnime');
        action.setParams({ 'animeId' : component.get('v.recordId')});
        action.setCallback(this, function(resp){
            if(resp.getState() == 'SUCCESS'){
                component.set('v.isAdded', resp.getReturnValue());
            } 
        });

        $A.enqueueAction(action);
    },

    handleClick : function(component, event, helper){
        let action = component.get('c.addAnime');
        action.setParams({ 'animeId': component.get('v.recordId')});
        action.setCallback(this, function(resp){
            if(resp.getState() == 'SUCCESS'){
                component.set('v.isAdded', true);
            } 
        })

        $A.enqueueAction(action);
    }, 
})
