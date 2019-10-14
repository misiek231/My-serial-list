import React, { useState, useContext } from 'react'
import { Input, Tooltip, Icon, Button } from 'antd';
import { Link } from 'react-router-dom';
import { SignUpContext } from '../../contexts/SignUpContext';
import { registerUser, restoreDefault } from '../../actions/signUpActions';
import axios from 'axios';
import { openNotificationWithIcon, openNotificationWithIconErr, openNotificationWithIconWarning } from '../../actions/notifications';
import { CompulsoryContext } from '../../contexts/CompulsoryContext';

//SignUpForm to get new user data and send to the server

const SignUpForm = () => {
    const [ iconLoading, setIconLoading ] = useState(false)

    const [ text, setText] = useState('Zarejestruj się')

    const [confirmPassword, setConfirmPassword] = useState('');

    const { signUpData, dispatch } = useContext(SignUpContext);

    const { compulsoryData } = useContext(CompulsoryContext);

    const handleChange = (name,value) =>{
        dispatch(registerUser(name,value));
    }

    const handleConfirmPasswordChange = (value) =>{
        setConfirmPassword(value);
    }

    const handleSubmit = (e) =>{
        e.preventDefault();
        if(confirmPassword !== signUpData.registerUser.password){
            openNotificationWithIconWarning('warning');
            return
        }else{
            setIconLoading(true);
            axios.post(compulsoryData.ip +'/api/account/create', signUpData.registerUser)
            .then(res =>{
                openNotificationWithIcon('success');
                dispatch(restoreDefault());
                setConfirmPassword('');
                setIconLoading(false);
                setText('Gotowe!')
            })
            .catch(err =>{
                openNotificationWithIconErr('error')
                console.log(err)
                setIconLoading(false);
            })
        }
    }

    return ( 
        <form onSubmit={handleSubmit}>
            <div className="label_box">
                <label htmlFor="user_name">Nazwa użytkownika</label>
                <Input
                    onChange={(e) => {handleChange('username', e.target.value)}}
                    value={signUpData.registerUser.username}
                    id="user_name"
                    prefix={<Icon type="user" />}
                    suffix={
                        <Tooltip title="Pod taką nazwą będziesz widziany przez innych użytkowników serwisu">
                        <Icon type="info-circle" />
                        </Tooltip>
                    }
                />
            </div>
            <div className="label_box">
                <label htmlFor="password">Hasło</label>
                <Input.Password 
                    onChange={(e) => {handleChange('password', e.target.value)}}
                    value={signUpData.registerUser.password}
                    id="password"
                    prefix = {
                        <Icon type="lock" />
                    }
                />
            </div>
            <div className="label_box">
                <label htmlFor="confirm_password">Potwierdź hasło</label>
                <Input.Password 
                value={confirmPassword}
                onChange = {(e) => {handleConfirmPasswordChange(e.target.value)}}
                id="confirm_password"
                prefix = {
                    <Icon type="lock" />
                }
                />
            </div>
            <div className="label_box">
                <label htmlFor="email">E-mail</label>
                <Input
                    onChange={(e) => {handleChange('email', e.target.value)}}
                    value={signUpData.registerUser.email}
                    id="email"
                    prefix={<Icon type="mail" />}
                    suffix={
                        <Tooltip title="Na ten adres e-mail zostaną wysłane informacje, w razie próby
                        odzyskania konta">
                        <Icon type="info-circle" />
                        </Tooltip>
                    }
                />
                <Link to="/signin"><p>Posiadasz już konto? Zaloguj się</p></Link>
            </div>
            <Button
                type="primary"
                htmlType="submit"
                icon="check"
                loading={iconLoading}
            >
                {text}
            </Button>
        </form>
     );
}
 
export default SignUpForm;