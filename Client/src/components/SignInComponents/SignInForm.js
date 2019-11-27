import React, { useState, useContext } from 'react'
import { Input, Tooltip, Icon, Button } from 'antd';
import { Link, withRouter } from 'react-router-dom';
import { withCookies } from 'react-cookie';
import { CompulsoryContext } from '../../contexts/CompulsoryContext';
import { signInUser, restoreDefault } from '../../actions/signInActions';
import { SignInContext } from '../../contexts/SignInContext';
import { openNotificationWithIconWarning } from '../../actions/notifications';
import axios from 'axios';

//SignInForm to log in on user account

const SignUpForm = (props) => {
    const [ iconLoading, setIconLoading ] = useState(false);

    const { signInData, dispatch } = useContext(SignInContext);

    const { compulsoryData } = useContext(CompulsoryContext);

    const handleChange = (name,value) =>{
        dispatch(signInUser(name,value));
    }

    const handleSubmit = (e) =>{
        e.preventDefault();
        setIconLoading(true);
        axios.post(compulsoryData.ip +'/api/Account/login', signInData.signInUser)
        .then(res =>{
            dispatch(restoreDefault());
            setIconLoading(false);
            const { cookies } = props;
            cookies.set('token', res.data.token, {path: '/'});
            cookies.set('username', signInData.signInUser.username, {path: '/'});
            props.history.push('/listview/current/' + signInData.signInUser.username );
        })
        .catch(err =>{
            setIconLoading(false);
            openNotificationWithIconWarning('warning', err.response.data)
        })
}

    return ( 
        <form onSubmit={handleSubmit}>
            <div className="label_box">
                <label htmlFor="user_name">Nazwa użytkownika</label>
                <Input
                    onChange={(e) => {handleChange('username', e.target.value)}}
                    value={signInData.signInUser.username}
                    id="user_name"
                    prefix={<Icon type="user" />}
                    suffix={
                        <Tooltip title="Podaj żytą przy rejestracji nazwę użytkownika">
                        <Icon type="info-circle" />
                        </Tooltip>
                    }
                />
            </div>
            <div className="label_box">
                <label htmlFor="password">Hasło</label>
                <Input.Password 
                    onChange={(e) => {handleChange('password', e.target.value)}}
                    value={signInData.signInUser.password}
                    id="password"
                    prefix = {
                        <Icon type="lock" />
                    }
                />
            </div>
            <div className="label_box">
                <Link to="/signup"><p>Nie posiadasz konta? Zarejstruj się</p></Link>
            </div>
            <Button
                type="primary"
                htmlType="submit"
                icon="check"
                loading={iconLoading}
            >
                Zaloguj się
            </Button>
        </form>
     );
}
 
export default withRouter(withCookies(SignUpForm));