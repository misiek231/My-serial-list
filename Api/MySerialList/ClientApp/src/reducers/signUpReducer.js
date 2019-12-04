export const signUpReducer = (state,action) =>{
    switch(action.type){
        case 'REGISTER_USER':
            return{
                ...state,
                registerUser:{
                    ...state.registerUser,
                    [action.name]:action.value
                }
            }
        case 'RESTORE_DEFAULT':
            return{
                ...state,
                registerUser:{
                    ...state.registerUser,
                    username: '',
                    password: '',
                    email: ''
                }
            }
        default:
            return state;
    }
}