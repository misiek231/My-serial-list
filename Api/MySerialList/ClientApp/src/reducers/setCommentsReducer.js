export const setCommentsReducer = (state,action) =>{
    switch(action.type){
        case 'SET_COMMENTS':
            return action.data
        default:
            return state;
    }
}