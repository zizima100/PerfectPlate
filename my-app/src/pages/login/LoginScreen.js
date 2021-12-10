import './LoginScreenStyle.css';
import React, { useState } from "react";
import { Button, Card, CardContent, IconButton, TextField } from "@material-ui/core";
import { Visibility, LockOpen } from "@material-ui/icons";
import ApiService from "../../api/ApiService"
import { useDispatch } from 'react-redux';
import { setId, setUserType } from "../../store/Auth/AuthReducer";
import { Link, useHistory } from "react-router-dom";
import UserType from "./../../enums/UserTypeEnum";

const INITIAL_STATE = {
    value: "",
    touched: false,
    hasError: false,
};

export default function LoginScreen() {
    const apiInstance = ApiService();
    const [email, setEmail] = useState(INITIAL_STATE);
    const [password, setPassword] = useState(INITIAL_STATE);
    const [isPasswordVisible, setIsPasswordVisible] = useState(false);
    const dispatch = useDispatch();
    const history = useHistory();

    const validateField = (value, field) => {
        if (field === "email") {
            return setEmail({
                ...email,
                touched: true,
                hasError:
                    value.length < 6 ||
                    !value.includes("@")
            });
        }
        if (field === "senha") {
            return setPassword({
                ...password,
                touched: true,
                hasError: value.length < 4
            });
        }
    }

    const login = async () => {
        const result = await apiInstance.userLogin(email.value, password.value);
        const { ok, message, data } = result.data;

        if (!ok && message === "USER_UNFOUND") {
            alert("Usuário ou senhas incorretos!");
            return;
        }

        if (ok && data) {
            dispatch(setId(data.id));
            dispatch(setUserType(data.userType));
            if (data.userType === UserType.ADMIN) {
                return history.push("/ingredient-register");
            }
            history.push("/calculator")
        }
    }

    return (
        <div className="login__main-login">
            <Card sx={{ width: 500 }}>
                <CardContent>
                    <div className="pageTitle">
                        <span className="titleText">Já tem uma conta?</span>
                        <span>Insira seus dados abaixo e aproveite dos benefícios!</span>
                        <div className="separator" />
                    </div>
                    <div className="login__input-row">
                        <TextField
                            error={email.hasError && email.touched}
                            label="Email"
                            placeholder="Insira seu email"
                            variant="outlined"
                            type="email"
                            onChange={e => setEmail({ ...email, value: e.target.value })}
                            onBlur={e => validateField(e.target.value, "email")}
                            value={email.value}
                            onKeyPress={(e) => {
                                if (e.key === 'Enter') {
                                    login().then()
                                }
                            }}
                        />
                    </div>
                    <div className="login__input-row-with-icon">
                        <TextField
                            error={password.hasError && password.touched}
                            label="Senha"
                            placeholder="Insira sua senha"
                            variant="outlined"
                            type={isPasswordVisible ? "text" : "password"}
                            onChange={e => setPassword({ ...password, value: e.target.value })}
                            onBlur={e => validateField(e.target.value, "senha")}
                            value={password.value}
                            onKeyPress={(e) => {
                                if (e.key === 'Enter') {
                                    login().then()
                                }
                            }}
                        />
                        <div onClick={() => setIsPasswordVisible(!isPasswordVisible)}>
                            <IconButton color="primary" component="span">
                                <Visibility />
                            </IconButton>
                        </div>
                    </div>
                    <div className="login__input-row">
                        <Button
                            disabled={
                                (email.hasError && !(!email.touched && email.value !== "")) ||
                                (password.hasError && !(!password.touched && password.value !== ""))
                            }
                            onClick={() => login()}
                            variant="contained"
                            endIcon={<LockOpen />}
                        >
                            Entrar
                        </Button>
                    </div>
                    <div className="login__input-row">
                        <span>Ainda não tem conta? <Link to="/register">Cadastre-se!</Link></span>
                    </div>
                </CardContent>
            </Card>
        </div>
    );
};
