import React from 'react';
import Header from './components/Header';
import { Switch, Route } from "react-router-dom";
import SignUp from './components/SignUpComponents/SignUp';
import SignIn from './components/SignInComponents/SignIn';
import Footer from './components/Footer';
import SignUpContextProvider from './contexts/SignUpContext';
import SignInContextProvider from './contexts/SignInContext';
import CompulsoryContextProvider from './contexts/CompulsoryContext';

function App() {
  return (
    <div className="App">
      <CompulsoryContextProvider>
      <Header/>
      <Switch>
        <Route exact path="/signup">
          <SignUpContextProvider>
            <SignUp/>
          </SignUpContextProvider>
        </Route>
        <Route exact path="/signin">
          <SignInContextProvider>
            <SignIn/>
          </SignInContextProvider>
        </Route>
      </Switch>
      <Footer/>
      </CompulsoryContextProvider>
    </div>
  );
}

export default App;
