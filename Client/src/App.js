import React from 'react';
import Header from './components/Header';
import { Switch, Route } from "react-router-dom";
import SignUp from './components/SignUpComponents/SignUp';
import SignIn from './components/SignInComponents/SignIn';
import Footer from './components/Footer';
import ListView from './components/ListViewComponents/ListView';
import SignUpContextProvider from './contexts/SignUpContext';
import SignInContextProvider from './contexts/SignInContext';
import CompulsoryContextProvider from './contexts/CompulsoryContext';
import Welcome from './components/Welcome';
import SeriesView from './components/SeriesViewComponents/SeriesView';
import OneSeriesContextProvider from './contexts/OneSeriesContext';

function App() {
  return (
    <div className="App">
      <CompulsoryContextProvider>
      <Header/>
      <Switch>
        <Route exact path="/">
          <Welcome/>
        </Route>
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
        <Route path="/listview/current" render={() => <ListView  status={0} header={"Aktualnie oglądane:"} />} />
        <Route path="/series/:id">
          <OneSeriesContextProvider>
            <SeriesView/>
          </OneSeriesContextProvider>
        </Route>
      </Switch>
      <Footer/>
      </CompulsoryContextProvider>
    </div>
  );
}

export default App;
