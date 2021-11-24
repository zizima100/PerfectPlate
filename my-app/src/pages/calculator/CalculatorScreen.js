import './CalculatorScreenStyle.css';
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
import ApiService from "../../api/ApiService"
import UserSex from "../../enums/UserSexEnum";

const INITIAL_STATE = {
    value: "",
    touched: false,
    hasError: true,
};

export default function CalculatorScreen() {
    const apiInstance = ApiService();
    const [carbo, setCarbo] = useState(INITIAL_STATE);
    const [legume, setLegume] = useState(INITIAL_STATE);
    const [proteina, setProteina] = useState(INITIAL_STATE);

    const INGREDIENTES_API = {
        carboidratos: [ 
            {value: 'batata_doce', label: 'Batata Doce'},
            {value: 'mandioquinha', label: 'Mandioquinha'},
            {value: 'batata', label: 'Batata'},
            {value: 'arroz', label: 'Arroz'},
        ],
        legumes: [
            {value: 'vagem', label: 'Vagem'},
            {value: 'espinafre', label: 'Espinafre'},
            {value: 'cenoura', label: 'Cenoura'},
        ],
        proteinas: [
            {value: 'frango', label: 'Frango'},
            {value: 'carne_de_boi', label: 'Carne de Boi'},
            {value: 'carne_de_porco', label: 'Carne de Porco'},
        ],
    }

    const validateField = (value, field) => {
        if (field === "carbo") {
            return setCarbo({
                ...carbo,
                touched: true,
                hasError: value.length === 0,
            });
        }
        if (field === "legume") {
            return setLegume({
                ...legume,
                touched: true,
                hasError: value.length === 0,
            });
        }
        if (field === "proteina") {
            return setProteina({
                ...proteina,
                touched: true,
                hasError: value.length === 0,
            });
        }
    }

    const submit = async () => {
        const result = await apiInstance.userRegister({
            carbo: carbo.value,
            legume: legume.value,
            proteina: proteina.value,
        });
        console.log(result);
    }

    return (
        <div className="calculatorMain">
            <Card sx={{ width: 500 }}>
                <CardContent>
                    <div className="selectInputWrapper">
                        <FormControl sx={{ minWidth: 195 }}>
                            <InputLabel id="demo-simple-select-label">Carboidrato</InputLabel>
                            <Select
                                error={carbo.hasError && carbo.touched}
                                labelId="demo-simple-select-label"
                                id="demo-simple-select"
                                value={carbo.value}
                                label="Carboidrato"
                                onChange={e => setCarbo({
                                    ...carbo,
                                    value: e.target.value
                                })}
                                onBlur={e => validateField(e.target.value, "Carboidrato")}
                            >
                                { INGREDIENTES_API.carboidratos.map((item,idx) => (
                                    <MenuItem key={idx} value={ item.value }>{ item.label }</MenuItem>
                                ))}
                            </Select>
                        </FormControl>
                    </div>
                    <div className="selectInputWrapper">
                        <FormControl sx={{ minWidth: 195 }}>
                            <InputLabel id="demo-simple-select-label">Legume</InputLabel>
                            <Select
                                error={legume.hasError && legume.touched}
                                labelId="demo-simple-select-label"
                                id="demo-simple-select"
                                value={legume.value}
                                label="Legumes"
                                onChange={e => setLegume({
                                    ...legume,
                                    value: e.target.value
                                })}
                                onBlur={e => validateField(e.target.value, "Legume")}
                            >
                                { INGREDIENTES_API.legumes.map((item,idx) => (
                                    <MenuItem key={idx} value={ item.value }>{ item.label }</MenuItem>
                                ))}
                            </Select>
                        </FormControl>
                    </div>
                    <div className="selectInputWrapper">
                        <FormControl sx={{ minWidth: 195 }}>
                            <InputLabel id="demo-simple-select-label">Proteínas</InputLabel>
                            <Select
                                error={proteina.hasError && proteina.touched}
                                labelId="demo-simple-select-label"
                                id="demo-simple-select"
                                value={proteina.value}
                                label="Proteína"
                                onChange={e => setProteina({
                                    ...proteina,
                                    value: e.target.value
                                })}
                                onBlur={e => validateField(e.target.value, "Proteína")}
                            >
                                { INGREDIENTES_API.proteinas.map((item,idx) => (
                                    <MenuItem key={idx} value={ item.value }>{ item.label }</MenuItem>
                                ))}
                            </Select>
                        </FormControl>
                    </div>
                </CardContent>
            </Card>
        </div>
    );
}