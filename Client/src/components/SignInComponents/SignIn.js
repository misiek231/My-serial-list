import React from 'react';
import '../../styles/SignUpStyles/SignUp.scss';
import spider from '../../img/spider.png';
import SignInForm from './SignInForm';

const SignIn = () => {
    return ( 
        <main>  
            <div className="spider">
                <img src={spider} alt=""/>
                <h1>Zaloguj się</h1>
            </div>
            <SignInForm/>
        </main>
     );
}
 
export default SignIn;
