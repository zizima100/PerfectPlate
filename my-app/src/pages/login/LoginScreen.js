import '../login/LoginSceenStyle.css';
import React, {useState} from "react";
import {Button, Link, TextField} from "@material-ui/core";

export default function LoginScreen() {
    const [userData, setUserData] = useState({username: "", password: ""})
    return (
        <div className="main">
            <div className="inputRow">
                <TextField
                    id="user-email"
                    label="Email"
                    placeholder="Insira seu email"
                    variant="filled"
                    type="email"
                    onChange={e => setUserData({...userData, username: e.target.value})}
                    value={userData.username}
                />
            </div>
            <div className="inputRow">
                <TextField
                    id="user-password"
                    label="Senha"
                    placeholder="Insira sua senha"
                    variant="filled"
                    type="password"
                    onChange={e => setUserData({...userData, password: e.target.value})}
                    value={userData.password}
                />
            </div>
            <div className="inputRow">
                <Button onClick={() => console.log(userData)} variant="contained">Entrar</Button>
            </div>
            <div className="inputRow">
                <span>Não tem conta? <Link href="/register">Cadastre-se!</Link></span>
            </div>
        </div>
    );
};
