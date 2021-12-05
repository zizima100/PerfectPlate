import './IngredientRegisterScreenStyle.css';
import React, {useEffect, useState} from "react";
import {
    Button,
    Card,
    CardContent, FormControl, InputLabel, MenuItem, Select,
    TextField
} from "@material-ui/core";
import {Check} from "@material-ui/icons";
import {useSelector} from "react-redux";
import {useHistory} from "react-router-dom";

export default function IngredientRegisterScreen() {
    const [category, setCategory] = useState("carb");
    const [onePortionQtd, setOnePortionQtd] = useState(0);
    const [ingredientName, setIngredientName] = useState("");
    const selector = useSelector(state => state);
    const history = useHistory();

    useEffect(() => {
        if (history && selector.userData.id === 0) {
            alert("Você precisa estar logado para acessar essa página!")
            history.push("/");
        }
    }, [selector]);

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
        <div className="ingredientRegisterMain">
            <Card sx={{ width: 550 }}>
                <CardContent>
                    <div className="pageTitle">
                        <span className="titleText">Cadastro de Ingredientes</span>
                        <span>Cadastre um Ingrediente para os usuários escolherem em seus pratos!</span>
                        <div className="separator" />
                    </div>
                    <div className="inputRow">
                        <div className="calculatorInputMargin">
                            <FormControl sx={{ minWidth: 193 }}>
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
                        </div>
                    </div>
                    <div className="inputRow">
                        <div className="calculatorInputMargin">
                            <TextField
                                name="ingredientName"
                                type="text"
                                label="Nome do ingrediente"
                                placeholder="Nome do ingrediente"
                                value={ingredientName}
                                onChange={e => setIngredientName(e.target.value)}
                            />
                        </div>
                    </div>
                    <div className="inputRow">
                        <div className="calculatorInputMargin">
                            <TextField
                                name="onePortionQtd"
                                type="number"
                                label="Qtd 1 porção (gramas)"
                                placeholder="Qtd 1 porção (gramas)"
                                value={onePortionQtd}
                                onChange={e => setOnePortionQtd(parseFloat(e.target.value))}
                            />
                        </div>
                    </div>
                    <div className="separator" />
                    <div className="inputRow">
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
