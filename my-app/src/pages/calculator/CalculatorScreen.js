import './CalculatorScreenStyle.css';
import React, {useEffect, useState} from "react";
import {
    Button,
    Card,
    CardContent, FormControl, InputLabel, MenuItem, Select,
    TextField
} from "@material-ui/core";
import { Add, Check, DeleteForever } from "@material-ui/icons";
import {useSelector} from "react-redux";
import {useHistory} from "react-router-dom";
import {
    Link,
} from "react-router-dom";
import ApiService from "../../api/ApiService";
import moment from "moment";

const mapTypeLabel = {
    carbohydrate: "Carboidrato",
    protein: "Proteina",
    vegetable: "Legume/Vegetal",
}

export default function CalculatorScreen() {
    const apiInstance = ApiService();
    const history = useHistory();
    const [inputList, setInputList] = useState([{ ingredient: { type: "carbohydrate", value: {}}, portionQtd: 1 }]);
    const [newField, setNewField] = useState("carbohydrate");
    const [plateName, setPlateName] = useState("");
    const [plateDate, setPlateDate] = useState(moment().format("YYYY-MM-DD"));
    const [ingredients, setIngredients] = useState([]);
    const selector = useSelector(state => state);

    useEffect(async () => {
        const response = await apiInstance.getAllIngredients();
        if (response.data.ok) {
            setIngredients(response.data.data);
        }
        if (history && selector.userData.id === 0) {
            alert("Você precisa estar logado para acessar essa página!")
            return history.push("/");
        }
    }, [selector, history]);

    const handleInputChange = (e, index) => {
        const { name, value } = e.target;
        const list = [...inputList];
        if (name === "ingredient") {
            list[index][name].value = ingredients.find(item => item.id === value);
            setInputList(list);
            return;
        }
        if (name === "portionQtd") {
            list[index][name] = value > 0 ? value : 1;
            setInputList(list);
            return;
        }
        return setInputList(list);
    };

    const handleRemoveClick = index => {
        const list = [...inputList];
        list.splice(index, 1);
        setInputList(list);
    };

    const handleAddClick = () => {
        setInputList([...inputList, { ingredient: { type: newField, value: {} }, portionQtd: 1 }]);
    };

    const ingredientItemsByType = type => {
        if (type === "carbohydrate") {
            return ingredients.map((item, idx) => (
                item.classification === "carbohydrate" &&
                <MenuItem key={idx} value={item.id}>{item.name}</MenuItem>
            ))
        }
        if (type === "protein") {
            return ingredients.map((item, idx) => (
                item.classification === "protein" &&
                <MenuItem key={idx} value={item.id}>{item.name}</MenuItem>
            ))
        }
        if (type === "vegetable") {
            return ingredients.map((item, idx) => (
                item.classification === "vegetable" &&
                <MenuItem key={idx} value={item.id}>{item.name}</MenuItem>
            ))
        }
    };

    const submitPlate = async () => {
        const plateData = await apiInstance.insertPlate({
            user_id: selector.userData.id,
            name: plateName,
            date: new Date(plateDate),
        });

        if (plateData.data.ok) {
            inputList.map(async (item) => {
                await apiInstance.insertIngredientToPlate({
                    ingredient_id: item.ingredient.value.id,
                    plate_id: plateData.data.data,
                    number_of_portions: item.portionQtd,
                })
            });
        }


        history.push({
            pathname: '/nutricion-table',
            state: { ingredients: inputList }
        });
    }

    return (
        <div className="calculatorMain">
            <Card sx={{ width: 1000 }}>
                <CardContent>
                    <div className="pageTitle">
                        <span className="titleText">Calculadora Nutricional</span>
                        <span>Cadastre um prato e verfique todas as informações nutricionais necessárias!</span>
                        <div className="separator" />
                    </div>
                    <div className="calculatorListMargin">
                        {inputList.length > 0 && inputList.map((item, idx) => {
                            return (
                                <div key={idx} className="inputRow">
                                    <div className="calculatorInputMargin">
                                        <FormControl sx={{ minWidth: 195 }}>
                                            <InputLabel id={"select-" + idx}>{mapTypeLabel[item.ingredient.type]}</InputLabel>
                                            <Select
                                                name="ingredient"
                                                labelId={"select-" + idx}
                                                value={item.ingredient.value.id}
                                                label={mapTypeLabel[item.ingredient.type]}
                                                onChange={e => handleInputChange(e, idx)}
                                            >
                                                {ingredientItemsByType(item.ingredient.type)}
                                            </Select>
                                        </FormControl>
                                    </div>
                                    <div className="calculatorInputMargin">
                                        <TextField
                                            name="onePortionQtd"
                                            type="number"
                                            InputProps={{
                                                readOnly: true,
                                            }}
                                            label="Qtd 1 porção (gramas)"
                                            placeholder="Qtd 1 porção (gramas)"
                                            value={item.ingredient.value.one_portion_weight ?? 0}
                                        />
                                    </div>
                                    <div className="calculatorInputMargin">
                                        <TextField
                                            name="portionQtd"
                                            type="number"
                                            label="Qtd de porções"
                                            placeholder="Ex.: 2"
                                            value={item.portionQtd}
                                            onChange={e => handleInputChange(e, idx)}
                                        />
                                    </div>
                                    <div className="calculatorInputMargin">
                                        {inputList.length !== 0 &&
                                        <Button
                                            onClick={() => handleRemoveClick(idx)}
                                            variant="contained"
                                            color="error"
                                            endIcon={<DeleteForever />}>
                                            Remover
                                        </Button>
                                        }
                                    </div>
                                </div>
                            );
                        })}
                    </div>
                    <div className="inputRow">
                        <div className="calculatorInputMargin">
                            <FormControl sx={{ minWidth: 230 }}>
                                <InputLabel id={"add-new-select"}>Categoria do ingrediente</InputLabel>
                                <Select
                                    name="ingredient"
                                    labelId={"add-new-select"}
                                    value={newField}
                                    label="Categoria do ingrediente"
                                    onChange={e => setNewField(e.target.value)}
                                >
                                    <MenuItem value={"carbohydrate"}>Carboidrato</MenuItem>
                                    <MenuItem value={"protein"}>Proteina</MenuItem>
                                    <MenuItem value={"vegetable"}>Legume/Vegetal</MenuItem>
                                </Select>
                            </FormControl>
                        </div>
                        <div className="calculatorInputMargin">
                            <Button
                                onClick={handleAddClick}
                                variant="contained"
                                endIcon={<Add />}>
                                Novo ingrediente
                            </Button>
                        </div>
                    </div>
                    <div className="separator" />
                    <div className="inputRow">
                        <div className="calculatorInputMargin">
                            <TextField
                                name="plateName"
                                type="text"
                                label="Nome do prato"
                                placeholder="Ex.: Almoço"
                                value={plateName}
                                onChange={e => setPlateName(e.target.value)}
                            />
                        </div>
                        <div className="calculatorInputMargin">
                            <TextField
                                name="plateName"
                                type="date"
                                label="Data de consumo"
                                placeholder="Data de consumo"
                                value={plateDate}
                                onChange={e => setPlateDate(e.target.value)}
                            />
                        </div>
                        <div className="calculatorInputMargin">
                            <Button
                                disabled={
                                    inputList.length <= 0 ||
                                    plateName.length === 0
                                }
                                onClick={() => submitPlate()}
                                color="success"
                                variant="contained"
                                endIcon={<Check />}
                            >
                                Finalizar prato
                            </Button>
                        </div>
                    </div>
                    <div className="separator" />
                    <div className="inputRow">
                        <span>Está sentindo falta de algum ingrediente? <Link to="/ingredient-suggestion">Fique a vontade para sugerir!</Link></span>
                    </div>
                </CardContent>
            </Card>
        </div>
    );
}
