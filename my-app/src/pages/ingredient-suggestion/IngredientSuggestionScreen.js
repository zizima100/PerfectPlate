import './IngredientSuggestionScreenStyle.css';
import React, {useEffect, useState} from "react";
import {
    Button,
    Card,
    CardContent,
    TextField
} from "@material-ui/core";
import {Check} from "@material-ui/icons";
import {useSelector} from "react-redux";
import {useHistory} from "react-router-dom";
import ApiService from "../../api/ApiService";

export default function IngredientSuggestionScreen() {
    const apiInstance = ApiService();
    const [ingredientName, setIngredientName] = useState("");
    const selector = useSelector(state => state);
    const history = useHistory();

    useEffect(() => {
        if (history && selector.userData.id === 0) {
            alert("Você precisa estar logado para acessar essa página!")
            return history.push("/");
        }
    }, [selector, history]);

    const hasNumber = /\d/;

    const submitIngredient = async () => {
        const result = await apiInstance.insertIngredientSuggestion({ingredient_name: ingredientName});

        if (result.data.ok) {
            alert("Ingrediente sugerido com sucesso!");
        } else {
            alert("Houve um erro! Tente novamente mais tarde.");
        }
    }

    return (
        <div className="ingredientRegisterMain">
            <Card sx={{ width: 550 }}>
                <CardContent>
                    <div className="pageTitle">
                        <span className="titleText">Sugestão de Ingredientes</span>
                        <span>Sugira um ingrediente que você está sentindo falta em nosso site!</span>
                        <div className="separator" />
                    </div>
                    <div className="suggestion__inputRow">
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
                    <div className="separator" />
                    <div className="suggestion__inputRow">
                        <div className="calculatorInputMargin">
                            <Button
                                disabled={
                                    ingredientName === '' ||
                                    hasNumber.test(ingredientName)
                                }
                                onClick={submitIngredient}
                                color="success"
                                variant="contained"
                                endIcon={<Check />}>
                                Sugerir ingrediente
                            </Button>
                        </div>
                    </div>
                </CardContent>
            </Card>
        </div>
    );
}
