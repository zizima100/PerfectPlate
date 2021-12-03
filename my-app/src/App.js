import React from "react";

import {
  BrowserRouter as Router,
  Switch,
  Route,
  Link
} from "react-router-dom";

import {
  Tabs,
  Tab,
  Typography,
  Box,
} from "@material-ui/core";

import '../src/App.css';
import LoginScreen from "./pages/login/LoginScreen";
import HomeScreen from "./pages/home/HomeScreen";
import RegisterScreen from "./pages/register/RegisterScreen";
import CalculatorScreen from "./pages/calculator/CalculatorScreen";
import TutorialScreen from "./pages/tutorial/TutorialScreen";
import IngredientRegisterScreen from "./pages/ingredient-register/IngredientRegisterScreen";
import IngredientSuggestionScreen from "./pages/ingredient-suggestion/IngredientSuggestionScreen";
import NutricionalTable from "./pages/nutricion-table/NutricionTable";
import AboutScreen from "./pages/about/AboutScreen";
import PlatesListScreen from "./pages/plates-list/PlatesListScreen";

export default function App() {
  return (
    <Router>
      <div>
        <nav className="navbar">
          <Link className="navbar__btn" to="/login">Login</Link>
          <Link className="navbar__btn" to="/calculator">Calculadora</Link>
          <Link className="navbar__btn" to="/tutorial">Tutorial</Link>
          <Link className="navbar__btn" to="/about">Sobre nós</Link>
          <Link className="navbar__btn" to="/nutricion-table">Tabela Nutricional</Link>
          <Link className="navbar__btn" to="/ingredient-register">Registro de Ingredientes</Link>
          <Link className="navbar__btn" to="/ingredient-suggestion">Sugestão de Ingredientes</Link>
          <Link className="navbar__btn" to="/plates-list">Listagem de Pratos</Link>
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
        </Switch>
      </div>
    </Router>
  );
}
