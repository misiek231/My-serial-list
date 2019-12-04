export const signInReducer = (state,action) =>{
    switch(action.type){
        case 'SIGN_IN':
            return{
                ...state,
                signInUser:{
                    ...state.signInUser,
                    [action.name]:action.value
                }
            }
        case 'RESTORE_DEFAULT':
            return{
                ...state,
                signInUser:{
                    ...state.signInUser,
                    username: '',
                    password: ''
                }
            }
        default:
            return state;
    }
}