import React from 'react';
import SignUpForm from './SignUpForm';
import '../../styles/SignUpStyles/SignUp.scss';

//SignUpForm nested here
const SignUp = () => {
    return ( 
        <main className="signUp">
                <h1>Zarejestruj się!</h1>
                <p>I dołącz do ekipy zoorganizowanych kinomaniaków</p>
                <SignUpForm/>
        </main>
     );
}
 
export default SignUp;
