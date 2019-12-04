export const registerUser = (name,value) =>{
    return{
        type:'REGISTER_USER',
        name,
        value
    }
}

export const restoreDefault = () =>{
    return{
        type:'RESTORE_DEFAULT'
    }
}