export const signInUser = (name,value) =>{
    return{
        type:'SIGN_IN',
        name,
        value
    }
}

export const restoreDefault = () =>{
    return{
        type:'RESTORE_DEFAULT'
    }
}