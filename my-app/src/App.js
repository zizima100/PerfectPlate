import React, {useEffect, useState} from "react";

import {
  BrowserRouter as Router,
  Switch,
  Route,
  Link,
} from "react-router-dom";

import '../src/App.css';
import LoginScreen from "./pages/login/LoginScreen";
import RegisterScreen from "./pages/register/RegisterScreen";
import CalculatorScreen from "./pages/calculator/CalculatorScreen";
import TutorialScreen from "./pages/tutorial/TutorialScreen";
import IngredientRegisterScreen from "./pages/ingredient-register/IngredientRegisterScreen";
import IngredientSuggestionScreen from "./pages/ingredient-suggestion/IngredientSuggestionScreen";
import NutricionalTable from "./pages/nutricion-table/NutricionTable";
import AboutScreen from "./pages/about/AboutScreen";
import PlatesListScreen from "./pages/plates-list/PlatesListScreen";
import {useSelector} from "react-redux";
import UserType from "./enums/UserTypeEnum";
import PlateEditVisualizeScreen from "./pages/plate-edit-visualize/PlateEditVisualizeScreen";

export default function App() {
  const selector = useSelector(state => state);
  const [isLogged, setIsLogged] = useState(false);
  const [isAdmin, setIsAdmin] = useState(false);

  useEffect(() => {
    if (selector.userData.id === 0) {
      setIsLogged(false);
    } else {
      setIsLogged(true);
      if (selector.userData.userType === UserType.ADMIN) {
        setIsAdmin(true);
      }
    }
  }, [selector]);
  return (
    <Router>
      <div>
        <nav className="navbar">
          {
            isLogged ? (
              isAdmin ? (
                <>
                  <Link className="navbar__btn" to="/ingredient-register">Registro de Ingredientes</Link>
                  <Link className="navbar__btn" onClick={() => window.location.reload(false)}>Sair</Link>
                </>
              ) : (
                <>
                  <Link className="navbar__btn" to="/plates-list">Listagem de Pratos</Link>
                  <Link className="navbar__btn" to="/calculator">Calculadora Nutricional</Link>
                  <Link className="navbar__btn" to="/ingredient-suggestion">Sugestão de Ingredientes</Link>
                  <Link className="navbar__btn" to="/tutorial">Tutorial</Link>
                  <Link className="navbar__btn" to="/about">Sobre nós</Link>
                  <Link className="navbar__btn" onClick={() => window.location.reload(false)}>Sair</Link>
                </>
                )
            ) : (
              <>
                <Link className="navbar__btn" to="/login">Login</Link>
                <Link className="navbar__btn" to="/tutorial">Tutorial</Link>
                <Link className="navbar__btn" to="/about">Sobre nós</Link>
              </>
            )
          }

        </nav>

        <Switch>
          <Route exact path="/">
            <LoginScreen />
          </Route>
          <Route exact path="/login">
            <LoginScreen />
          </Route>
          <Route exact path="/about">
            <AboutScreen />
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
          <Route exact path="/nutricion-table">
            <NutricionalTable />
          </Route>
          <Route exact path="/ingredient-register">
            <IngredientRegisterScreen />
          </Route>
          <Route exact path="/ingredient-suggestion">
            <IngredientSuggestionScreen />
          </Route>
          <Route exact path="/plates-list">
            <PlatesListScreen />
          </Route>
          <Route exact path="/plate-edit-visualize">
            <PlateEditVisualizeScreen />
          </Route>
        </Switch>
      </div>
    </Router>
  );
}
