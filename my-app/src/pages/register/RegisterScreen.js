import '../register/RegisterScreenStyle.css';
import React, {useState} from "react";
import {Button, FormControl, InputLabel, MenuItem, Select, TextField} from "@material-ui/core";
import UserType from "../../enums/UserTypeEnum";

export default function RegisterScreen() {
    const [userData, setUserData] = useState(
        {
            email: "",
            password: "",
            name: "",
            age: 0,
            sex: "",
            weight: 0,
            height: 0,
            userType: "",
        }
    )
    return (
        <div className="main">
            <div className="inputRow">
                <TextField
                    id="user-email"
                    label="Email"
                    placeholder="Insira seu email"
                    variant="filled"
                    type="email"
                    onChange={e => setUserData({...userData, email: e.target.value})}
                    value={userData.email}
                />
            </div>
            <div className="inputRow">
                <TextField
                    id="user-email"
                    label="Senha"
                    placeholder="Insira sua senha"
                    variant="filled"
                    type="password"
                    onChange={e => setUserData({...userData, password: e.target.value})}
                    value={userData.password}
                />
            </div>
            <div className="inputRow">
                <TextField
                    id="user-email"
                    label="Nome"
                    placeholder="Insira seu nome completo"
                    variant="filled"
                    type="text"
                    onChange={e => setUserData({...userData, name: e.target.value})}
                    value={userData.name}
                />
            </div>
            <div className="inputRow">
                <TextField
                    id="user-email"
                    label="Idade"
                    placeholder="Insira sua idade"
                    variant="filled"
                    type="number"
                    onChange={e => setUserData({...userData, age: e.target.value})}
                    value={userData.age}
                />
            </div>
            <div className="inputRow">
                <FormControl variant="filled" sx={{ m: 1, minWidth: 190 }}>
                    <InputLabel id="demo-simple-select-filled-label">Sexo</InputLabel>
                    <Select
                        labelId="demo-simple-select-filled-label"
                        id="demo-simple-select-filled"
                        onChange={e => setUserData({...userData, sex: e.target.value})}
                        value={userData.sex}
                    >
                        <MenuItem value={"masc"}>Masculino</MenuItem>
                        <MenuItem value={"fem"}>Feminino</MenuItem>
                        <MenuItem value={"nenhum"}>Prefiro não informar</MenuItem>
                    </Select>
                </FormControl>
            </div>
            <div className="inputRow">
                <Button onClick={() => console.log(userData)} variant="contained">Registrar</Button>
            </div>
        </div>
    );
}
