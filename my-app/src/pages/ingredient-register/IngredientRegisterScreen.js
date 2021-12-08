import './IngredientRegisterScreenStyle.css';
import React, { useEffect, useState } from "react";
import {
    Button,
    Card,
    CardContent, FormControl, InputLabel, MenuItem, Select,
    TextField
} from "@material-ui/core";
import { Check } from "@material-ui/icons";
import { useSelector } from "react-redux";
import { useHistory } from "react-router-dom";

export default function IngredientRegisterScreen() {
    const [category, setCategory] = useState("carb");
    const [onePortionQtd, setOnePortionQtd] = useState(0);
    const [ingredientName, setIngredientName] = useState("");
    const [vEnergetico, setVEnergetico] = useState(0);
    const [carboidratos, setCarboidratos] = useState(0);
    const [proteinas, setProteinas] = useState(0);
    const [gordTotais, setGordTotais] = useState(0);
    const [gordSaturadas, setGordSaturadas] = useState(0);
    const [gordTrans, setGordTrans] = useState(0);
    const [fibraAlimentar, setFibraAlimentar] = useState(0);
    const [sodio, setSodio] = useState(0);
    const selector = useSelector(state => state);
    const history = useHistory();

    const nutricionInputs = [
        { name: 'Valor Energético', value: vEnergetico, setValue: setVEnergetico, key: 'vEnergetico' },
        { name: 'Carboidratos', value: carboidratos, setValue: setCarboidratos, key: 'carboidratos' },
        { name: 'Proteínas', value: proteinas, setValue: setProteinas, key: 'proteinas' },
        { name: 'Gorduras Totais', value: gordTotais, setValue: setGordTotais, key: 'gordTotais' },
        { name: 'Gorduras Saturadas', value: gordSaturadas, setValue: setGordSaturadas, key: 'gordSaturadas' },
        { name: 'Gorduras Trans', value: gordTrans, setValue: setGordTrans, key: 'gordTrans' },
        { name: 'Fibra Alimentar', value: fibraAlimentar, setValue: setFibraAlimentar, key: 'fibraAlimentar' },
        { name: 'Sódio', value: sodio, setValue: setSodio, key: 'sodio' },
    ];

    let nutricionInputCounter = 0;

    useEffect(() => {
        if (history && selector.userData.id === 0) {
            alert("Você precisa estar logado para acessar essa página!")
            history.push("/");
        }
    }, [selector, history]);

    const hasNumber = /\d/;

    const submitIngredient = () => {
        const data = {
            category,
            onePortionQtd,
            ingredientName
        }
        console.log(data);
    }

    return (
        <div className="ing-register__main">
            <Card className="ing-register__card">
                <CardContent>
                    <div className="pageTitle">
                        <span className="titleText">Cadastro de Ingredientes</span>
                        <span>Cadastre um Ingrediente para os usuários escolherem em seus pratos!</span>
                        <div className="separator" />
                    </div>
                    <div className="ing-register__input-row">
                        <FormControl className="ing-register__input" sx={{ m: "10px" }}>
                            <InputLabel id={"add-new-select"}>Categoria do ingrediente</InputLabel>
                            <Select
                                name="ingredient"
                                labelId={"add-new-select"}
                                value={category}
                                label="Categoria do ingrediente"
                                onChange={e => setCategory(e.target.value)}
                            >
                                <MenuItem value={"carb"}>Carboidrato</MenuItem>
                                <MenuItem value={"protein"}>Proteina</MenuItem>
                                <MenuItem value={"legume"}>Legume/Vegetal</MenuItem>
                            </Select>
                        </FormControl>
                        <TextField
                            className="ing-register__input"
                            name="ingredientName"
                            type="text"
                            label="Nome do ingrediente"
                            placeholder="Nome do ingrediente"
                            value={ingredientName}
                            onChange={e => setIngredientName(e.target.value)}
                            sx={{ m: "10px" }}
                        />
                        <TextField
                            className="ing-register__input"
                            name="onePortionQtd"
                            type="number"
                            label="Qtd 1 porção (gramas)"
                            placeholder="Qtd 1 porção (gramas)"
                            value={onePortionQtd}
                            onChange={e => setOnePortionQtd(parseFloat(e.target.value))}
                            sx={{ m: "10px" }}
                        />
                    </div>
                    <div className="ing-register__input-row">
                        <div className="ing-register__nutri-inputs__wrapper">
                            {nutricionInputs && nutricionInputs.map((nutricionInput) => {
                                return (
                                    <TextField
                                        className="ing-register__nutri-input"
                                        name="ingredientName"
                                        type="number"
                                        label={nutricionInput.name}
                                        placeholder="Nome do ingrediente"
                                        value={nutricionInput.value}
                                        onChange={(e) =>
                                            e.target.value < 0
                                                ? (e.target.value = 0)
                                                : nutricionInput.setValue(e.target.value)
                                        }
                                        sx={{ m: "5px" }}
                                    />
                                )
                            })}
                        </div>
                    </div>
                    <div className="separator" />
                    <div className="ing-register__input-row">
                        <div className="calculatorInputMargin">
                            <Button
                                disabled={
                                    ingredientName === '' ||
                                    hasNumber.test(ingredientName) ||
                                    onePortionQtd <= 0 ||
                                    !onePortionQtd
                                }
                                onClick={submitIngredient}
                                color="success"
                                variant="contained"
                                endIcon={<Check />}>
                                Cadastrar ingrediente
                            </Button>
                        </div>
                    </div>
                </CardContent>
            </Card>
        </div>
    );
}
