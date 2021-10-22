import '../register/RegisterScreenStyle.css';
import React, {useState} from "react";
import {Button, FormControl, IconButton, InputLabel, MenuItem, Select, TextField} from "@material-ui/core";
import UserType from "../../enums/UserTypeEnum";
import { Visibility } from '@material-ui/icons';

export default function RegisterScreen() {
    // ADICIONAR VALIDACAO DE HAS ERROR
    const [userData, setUserData] = useState(
        {
            email: "",
            password: "",
            name: "",
            age: null,
            sex: "",
            weight: null,
            height: null,
            userType: "",
        }
    )
    const [isPasswordVisible, setIsPasswordVisible] = useState(false);
    return (
        <div className="main">
            <div className="inputRow">
                <div className="inputWrapper">
                    <TextField
                        label="Email"
                        placeholder="Insira seu email"
                        variant="outlined"
                        type="email"
                        onChange={e => setUserData({...userData, email: e.target.value})}
                        value={userData.email}
                    />
                </div>
                <div className="inputWrapper">
                    <div className="inputWithIcon">
                        <TextField
                            label="Senha"
                            placeholder="Insira sua senha"
                            variant="outlined"
                            type={isPasswordVisible ? "text" : "password"}
                            onChange={e => setUserData({...userData, password: e.target.value})}
                            value={userData.password}
                        />
                        <div className="passwordVisibleIcon" onClick={() => setIsPasswordVisible(!isPasswordVisible)}>
                            <IconButton color="primary" component="span">
                                <Visibility />
                            </IconButton>
                        </div>
                    </div>
                </div>
            </div>
            <div className="inputRow">
                <div className="inputWrapper">
                    <TextField
                        label="Nome"
                        placeholder="Insira seu nome completo"
                        variant="outlined"
                        type="text"
                        onChange={e => setUserData({...userData, name: e.target.value})}
                        value={userData.name}
                    />
                </div>
                <div className="inputWrapper">
                    <TextField
                        label="Idade"
                        placeholder="Insira sua idade"
                        variant="outlined"
                        type="number"
                        onChange={e => setUserData({...userData, age: e.target.value})}
                        value={userData.age}
                    />
                </div>
            </div>
            <div className="inputRow">
                <div className="inputWrapper">
                    <div className="inputWrapper">
                        <TextField
                            label="Peso"
                            placeholder="Insira seu Peso"
                            variant="outlined"
                            type="number"
                            onChange={e => setUserData({...userData, weight: e.target.value})}
                            value={userData.weight}
                        />
                    </div>
                </div>
                <div className="selectInputWrapper">
                    <FormControl sx={{ minWidth: 195 }}>
                        <InputLabel id="demo-simple-select-label">Sexo</InputLabel>
                        <Select
                            labelId="demo-simple-select-label"
                            id="demo-simple-select"
                            value={userData.sex}
                            label="Sexo"
                            onChange={e => setUserData({...userData, sex: e.target.value})}
                        >
                            <MenuItem value={"masc"}>Masculino</MenuItem>
                            <MenuItem value={"fem"}>Feminino</MenuItem>
                            <MenuItem value={"nenhum"}>Prefiro não informar</MenuItem>
                        </Select>
                    </FormControl>
                </div>
            </div>
            <div className="inputRow">
                <div className="inputWrapper">
                    <div className="inputWrapper">
                        <TextField
                            label="Altura"
                            placeholder="Insira sua Altura"
                            variant="outlined"
                            type="number"
                            onChange={e => setUserData({...userData, height: e.target.value})}
                            value={userData.height}
                        />
                    </div>
                </div>
                <div className="selectInputWrapper">
                    <FormControl sx={{ minWidth: 195 }}>
                        <InputLabel id="demo-simple-select-label">Classificação</InputLabel>
                        <Select
                            labelId="demo-simple-select-label"
                            id="demo-simple-select"
                            value={userData.userType}
                            label="Classificação"
                            onChange={e => setUserData({...userData, userType: e.target.value})}
                        >
                            <MenuItem value={UserType.FISICULTURISTA}>Fisiculturista</MenuItem>
                            <MenuItem value={UserType.PADRAO}>Frequentador</MenuItem>
                            <MenuItem value={UserType.NUTRICIONISTA}>Nutricionista</MenuItem>
                        </Select>
                    </FormControl>
                </div>
            </div>
            <div className="inputRow">
                <Button onClick={() => console.log(userData)} variant="contained">Registrar</Button>
            </div>
        </div>
    );
}
