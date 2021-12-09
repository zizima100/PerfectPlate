import './IngredientSuggestionListScreenStyle.css';
import React, {useEffect, useState} from "react";
import {
    Button,
    Card,
    CardContent,
} from "@material-ui/core";
import {DeleteForever, Edit, Visibility} from "@material-ui/icons";
import {useSelector} from "react-redux";
import {useHistory} from "react-router-dom";
import ApiService from "../../api/ApiService";
import moment from "moment";

export default function IngredientSuggestionListScreen() {
    const [ingredientList, setIngredientList] = useState([]);
    const selector = useSelector(state => state);
    const history = useHistory();
    const apiInstance = ApiService();

    const getData = async () => {
        const result = await apiInstance.getIngredientSuggestions();

        if (!result.data.ok) {
            alert("Houve um erro! Tente novamente mais tarde");
            return;
        }
        return setIngredientList(result.data.data);
    };

    useEffect(() => {
        if (history && selector.userData.id === 0) {
            alert("Você precisa estar logado para acessar essa página!")
            return history.push("/");
        }
    }, [selector, history]);

    useEffect(() => {
        getData().then()
    }, []);

    const deletePlate = async (suggestionId) => {
        const plateData = await apiInstance.deleteIngredientSuggestion(suggestionId);
        if (plateData.data.ok) {
            alert("Sugestão deletada com sucesso!");
            getData().then();
        }
    };

    return (
        <div className="calculatorMain">
            <Card sx={{ width: 1000 }}>
                <CardContent>
                    <div className="pageTitle">
                        <span className="titleText">Listagem de sugestões de ingredientes</span>
                        <span>Verifique aqui todos os ingredientes sugeridos pelos usuários!</span>
                        <div className="separator"/>
                    </div>
                    {ingredientList.length > 0 ? ingredientList.map((item, idx) => {
                        return (
                            <div key={idx}>
                                <div className="inputRow">
                                    <div className="plateItemCol">
                                        <span className="labelPadding">Código</span>
                                        <span>{item.id}</span>
                                    </div>
                                    <div className="plateItemCol">
                                        <span className="labelPadding">Nome do Ingrediente</span>
                                        <span>{item.name}</span>
                                    </div>
                                    <div className="plateButtonCol">
                                        <Button
                                            onClick={() => deletePlate(item.id)}
                                            color="error"
                                            variant="contained"
                                            endIcon={<DeleteForever />}>
                                            Deletar sugestão
                                        </Button>
                                    </div>
                                </div>
                                {
                                    ingredientList.length - 1 !== idx && (
                                        <div className="separator" />
                                    )
                                }
                            </div>
                        );
                    }) : (
                        <div className="pageTitle">
                            <span><b>Nenhuma sugestão foi cadastrada!</b></span>
                        </div>
                    )}
                </CardContent>
            </Card>
        </div>
    );
}
