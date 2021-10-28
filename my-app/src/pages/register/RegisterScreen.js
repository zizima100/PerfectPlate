import './RegisterScreenStyle.css';
import React, {useState} from "react";
import {
    Button,
    Card,
    CardContent,
    FormControl,
    IconButton,
    InputLabel,
    MenuItem,
    Select,
    TextField,
} from "@material-ui/core";
import UserType from "../../enums/UserTypeEnum";
import UserSex from "../../enums/UserSexEnum";
import { Visibility, Check } from '@material-ui/icons';
import {useHistory} from "react-router-dom";

const INITIAL_STATE = {
  value: "",
  touched: false,
  hasError: true,
};

export default function RegisterScreen() {
    let history = useHistory();
    const [email, setEmail] = useState(INITIAL_STATE);
    const [password, setPassword] = useState(INITIAL_STATE);
    const [name, setName] = useState(INITIAL_STATE);
    const [age, setAge] = useState(INITIAL_STATE);
    const [sex, setSex] = useState(INITIAL_STATE);
    const [weight, setWeight] = useState(INITIAL_STATE);
    const [height, setHeight] = useState(INITIAL_STATE);
    const [userType, setUserType] = useState(INITIAL_STATE);
    const [setUserData] = useState({});
    const [isPasswordVisible, setIsPasswordVisible] = useState(false);

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
                hasError: value.length < 6
            });
        }
        if (field === "nome") {
            return setName({
                ...name,
                touched: true,
                hasError: !(
                    value.trim().length > 0 &&
                    value.split(" ").length > 1 &&
                    value.split(" ")[1] !== ""
                )
            });
        }
        if (field === "idade") {
            return setAge({
                ...age,
                touched: true,
                hasError: value < 0 || value > 120 || value === ""
            });
        }
        if (field === "peso") {
            return setWeight({
                ...weight,
                touched: true,
                hasError: value < 0 || value === ""
            });
        }
        if (field === "altura") {
            return setHeight({
                ...height,
                touched: true,
                hasError: value < 0 || value > 300 || value === ""
            });
        }
        if (field === "sexo") {
            return setSex({
                ...sex,
                touched: true,
                hasError: value.length === 0
            });
        }
        if (field === "classificacao") {
            return setUserType({
                ...userType,
                touched: true,
                hasError: value.length === 0
            });
        }
    }

    const submit = () => {
        //FALTA INTEGRAÇÃO COM A API
        // setUserData({
        //     email: email.value,
        //     password: password.value,
        //     name: name.value,
        //     age: age.value,
        //     sex: sex.value,
        //     weight: weight.value,
        //     height: height.value,
        //     userType: userType.value
        // });
        history.push("/login")
    }
    return (
        <div className="mainRegister">
            <Card sx={{ width: 700 }}>
                <CardContent>
                    <div className="pageTitle">
                        <span className="titleText">Crie uma conta</span>
                        <span>Fácil e rápido.</span>
                        <div className="separator"/>
                    </div>
                    <div className="inputRowWithIcon">
                        <div className="inputWrapper">
                            <TextField
                                error={email.hasError && email.touched}
                                label="Email"
                                placeholder="Insira seu email"
                                variant="outlined"
                                type="email"
                                onChange={e => setEmail({...email, value: e.target.value})}
                                onBlur={e => validateField(e.target.value, "email")}
                                value={email.value}
                            />
                        </div>
                        <div className="inputWrapper">
                            <div className="inputWithIcon">
                                <TextField
                                    error={password.hasError && password.touched}
                                    label="Senha"
                                    placeholder="Insira sua senha"
                                    variant="outlined"
                                    type={isPasswordVisible ? "text" : "password"}
                                    onChange={e => setPassword({...password, value: e.target.value})}
                                    onBlur={e => validateField(e.target.value, "senha")}
                                    value={password.value}
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
                                error={name.hasError && name.touched}
                                label="Nome e sobrenome"
                                placeholder="Insira seu nome completo"
                                variant="outlined"
                                type="text"
                                onChange={e => setName({...name, value: e.target.value})}
                                onBlur={e => validateField(e.target.value, "nome")}
                                value={name.value}
                            />
                        </div>
                        <div className="inputWrapper">
                            <TextField
                                error={age.hasError && age.touched}
                                label="Idade"
                                placeholder="Insira sua idade"
                                variant="outlined"
                                type="number"
                                onChange={e => setAge({...age, value: e.target.value})}
                                onBlur={e => validateField(e.target.value, "idade")}
                                value={age.value}
                            />
                        </div>
                    </div>
                    <div className="inputRow">
                        <div className="inputWrapper">
                            <div className="inputWrapper">
                                <TextField
                                    error={weight.hasError && weight.touched}
                                    label="Peso (kg)"
                                    placeholder="Insira seu Peso"
                                    variant="outlined"
                                    type="number"
                                    onChange={e => setWeight({...weight, value: e.target.value})}
                                    onBlur={e => validateField(e.target.value, "peso")}
                                    value={weight.value}
                                />
                            </div>
                        </div>
                        <div className="selectInputWrapper">
                            <FormControl sx={{ minWidth: 195 }}>
                                <InputLabel id="demo-simple-select-label">Sexo</InputLabel>
                                <Select
                                    error={sex.hasError && sex.touched}
                                    labelId="demo-simple-select-label"
                                    id="demo-simple-select"
                                    value={sex.value}
                                    label="Sexo"
                                    onChange={e => setSex({...sex, value: e.target.value})}
                                    onBlur={e => validateField(e.target.value, "sexo")}
                                >
                                    <MenuItem value={UserSex.MASCULINO}>Masculino</MenuItem>
                                    <MenuItem value={UserSex.FEMININO}>Feminino</MenuItem>
                                    <MenuItem value={UserSex.NAO_DECLARADO}>Prefiro não informar</MenuItem>
                                </Select>
                            </FormControl>
                        </div>
                    </div>
                    <div className="inputRow">
                        <div className="inputWrapper">
                            <div className="inputWrapper">
                                <TextField
                                    error={height.hasError && height.touched}
                                    label="Altura (cm)"
                                    placeholder="Insira sua Altura"
                                    variant="outlined"
                                    type="number"
                                    onChange={e => setHeight({...height, value: e.target.value})}
                                    onBlur={e => validateField(e.target.value, "altura")}
                                    value={height.value}
                                />
                            </div>
                        </div>
                        <div className="selectInputWrapper">
                            <FormControl sx={{ minWidth: 195 }}>
                                <InputLabel id="demo-simple-select-label">Classificação</InputLabel>
                                <Select
                                    error={userType.hasError && userType.touched}
                                    labelId="demo-simple-select-label"
                                    id="demo-simple-select"
                                    value={userType.value}
                                    label="Classificação"
                                    onChange={e => setUserType({...userType, value: e.target.value})}
                                    onBlur={e => validateField(e.target.value, "classificacao")}
                                >
                                    <MenuItem value={UserType.FISICULTURISTA}>Fisiculturista</MenuItem>
                                    <MenuItem value={UserType.PADRAO}>Frequentador</MenuItem>
                                    <MenuItem value={UserType.NUTRICIONISTA}>Nutricionista</MenuItem>
                                </Select>
                            </FormControl>
                        </div>
                    </div>
                    <div className="inputRow">
                        <Button
                            disabled={
                                (email.hasError && !(!email.touched && email.value !== "")) ||
                                (password.hasError && !(!password.touched && password.value !== "")) ||
                                name.hasError ||
                                age.hasError ||
                                sex.hasError ||
                                weight.hasError ||
                                height.hasError ||
                                userType.hasError
                            }
                            onClick={() => submit()}
                            variant="contained"
                            endIcon={<Check />}
                        >
                            Registrar
                        </Button>
                    </div>
                </CardContent>
            </Card>
        </div>
    );
}
