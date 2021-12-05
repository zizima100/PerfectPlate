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

const INGREDIENTES_API = {
    carboidratos: [
        { value: 'batata_doce', label: 'Batata Doce', onePortion: 53 },
        { value: 'mandioquinha', label: 'Mandioquinha', onePortion: 45 },
        { value: 'batata', label: 'Batata', onePortion: 100 },
        { value: 'arroz', label: 'Arroz', onePortion: 120 },
    ],
    legumes: [
        { value: 'vagem', label: 'Vagem', onePortion: 100 },
        { value: 'espinafre', label: 'Espinafre', onePortion: 150 },
        { value: 'cenoura', label: 'Cenoura', onePortion: 200 },
    ],
    proteinas: [
        { value: 'frango', label: 'Frango', onePortion: 90 },
        { value: 'carne_de_boi', label: 'Carne de Boi', onePortion: 80 },
        { value: 'carne_de_porco', label: 'Carne de Porco', onePortion: 115 },
    ],
}

const mapTypeLabel = {
    carb: "Carboidrato",
    protein: "Proteina",
    legume: "Legume/Vegetal",
}

export default function CalculatorScreen() {
    const [inputList, setInputList] = useState([{ ingredient: { type: "carb", value: "" }, portionQtd: 1, onePortionQtd: 0 }]);
    const [newField, setNewField] = useState("carb");
    const selector = useSelector(state => state);
    const history = useHistory();

    useEffect(() => {
        if (history && selector.userData.id === 0) {
            alert("Você precisa estar logado para acessar essa página!")
            history.push("/");
        }
    }, [selector]);

    const handleInputChange = (e, index) => {
        const { name, value } = e.target;
        const list = [...inputList];
        if (name === "ingredient") {
            list[index][name].value = value;
            list[index].onePortionQtd = verifyItemOnePortionQtd(list[index][name].type, value);
            setInputList(list);
            return;
        }
        if (name === "portionQtd") {
            list[index][name] = value > 0 ? value : 1;
            setInputList(list);
            return;
        }
        list[index][name] = value;
        setInputList(list);
    };

    const handleRemoveClick = index => {
        const list = [...inputList];
        list.splice(index, 1);
        setInputList(list);
    };

    const handleAddClick = () => {
        setInputList([...inputList, { ingredient: { type: newField, value: "" }, portionQtd: 1, onePortionQtd: 0 }]);
    };

    const verifyItemOnePortionQtd = (type, value) => {
        if (type === "carb") {
            return INGREDIENTES_API.carboidratos.find(item => item.value === value).onePortion;
        }
        if (type === "protein") {
            return INGREDIENTES_API.proteinas.find(item => item.value === value).onePortion;
        }
        if (type === "legume") {
            return INGREDIENTES_API.legumes.find(item => item.value === value).onePortion;
        }
    }

    const ingredientItemsByType = type => {
        if (type === "carb") {
            return INGREDIENTES_API.carboidratos.map((item, idx) => (
                <MenuItem key={idx} value={item.value}>{item.label}</MenuItem>
            ))
        }
        if (type === "protein") {
            return INGREDIENTES_API.proteinas.map((item, idx) => (
                <MenuItem key={idx} value={item.value}>{item.label}</MenuItem>
            ))
        }
        if (type === "legume") {
            return INGREDIENTES_API.legumes.map((item, idx) => (
                <MenuItem key={idx} value={item.value}>{item.label}</MenuItem>
            ))
        }
    };

    const submitPlate = () => {
        console.log(inputList);
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
                    {inputList.map((item, idx) => {
                        return (
                            <div key={idx} className="inputRow">
                                <div className="calculatorInputMargin">
                                    <FormControl sx={{ minWidth: 195 }}>
                                        <InputLabel id={"select-" + idx}>{mapTypeLabel[item.ingredient.type]}</InputLabel>
                                        <Select
                                            name="ingredient"
                                            labelId={"select-" + idx}
                                            value={item.ingredient.value}
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
                                        disabled
                                        label="Qtd 1 porção (gramas)"
                                        placeholder="Qtd 1 porção (gramas)"
                                        value={item.onePortionQtd}
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
                                            onClick={() => handleRemoveClick(item)}
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
                    <div className="separator" />
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
                                    <MenuItem value={"carb"}>Carboidrato</MenuItem>
                                    <MenuItem value={"protein"}>Proteina</MenuItem>
                                    <MenuItem value={"legume"}>Legume/Vegetal</MenuItem>
                                </Select>
                            </FormControl>
                        </div>
                        <div className="calculatorInputMargin">
                            <Button
                                onClick={handleAddClick}
                                variant="contained"
                                endIcon={<Add />}>
                                Adicionar novo ingrediente
                            </Button>
                        </div>
                        <div className="calculatorInputMargin">
                            <Button
                                disabled={
                                    inputList.length <= 0
                                }
                                onClick={submitPlate}
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
