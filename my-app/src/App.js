import React from "react";
import {
  BrowserRouter as Router,
  Switch,
  Route,
  Link
} from "react-router-dom";
import LoginScreen from "./pages/login/LoginScreen";
import HomeScreen from "./pages/home/HomeScreen";
import RegisterScreen from "./pages/register/RegisterScreen";
import CalculatorScreen from "./pages/calculator/CalculatorScreen";
import TutorialScreen from "./pages/tutorial/TutorialScreen";
import AboutScreen from "./pages/about/AboutScreen";

export default function App() {
  return (
      <Router>
        <div>
          <nav>
            <ul>
              <li>
                <Link to="/">Home</Link>
              </li>
              <li>
                <Link to="/about">About</Link>
              </li>
              <li>
                <Link to="/login">Login</Link>
              </li>
              <li>
                <Link to="/calculator">Calculadora</Link>
             </li>
              <li>
                <Link to="/tutorial">Tutorial</Link>
              </li>
            </ul>
          </nav>

          {/* A <Switch> looks through its children <Route>s and
            renders the first one that matches the exact current URL. */}
          <Switch>
            <Route exact path="/">
              <HomeScreen />
            </Route>
            <Route exact path="/about">
              <AboutScreen />
            </Route>
            <Route exact path="/login">
              <LoginScreen />
            </Route>
            <Route exact path="/register">
              <RegisterScreen />
            </Route>
            <Route exact path="/calculator">
              <CalculatorScreen />
            </Route>
            <Route exact path="/tutorial">
              <TutorialScreen />
            </Route>
          </Switch>
        </div>
      </Router>
  );
}