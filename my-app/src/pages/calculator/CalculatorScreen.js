import './CalculatorScreenStyle.css';
import React, {useState} from "react";
import {
    Button,
    Card,
    CardContent, FormControl, InputLabel, MenuItem, Select,
    TextField
} from "@material-ui/core";
import {Add, DeleteForever} from "@material-ui/icons";

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

export default function CalculatorScreen() {
    const [inputList, setInputList] = useState([{ ingredient: "", portionQtd: "" }]);

    const handleInputChange = (e, index) => {
        const { name, value } = e.target;
        const list = [...inputList];
        list[index][name] = value;
        setInputList(list);
    };

    const handleRemoveClick = index => {
        const list = [...inputList];
        list.splice(index, 1);
        setInputList(list);
    };

    const handleAddClick = () => {
        setInputList([...inputList, { ingredient: "", portionQtd: "" }]);
    };

    return (
        <div className="calculatorMain">
            <Card sx={{ width: 1000 }}>
                <CardContent>
                    <div className="pageTitle">
                        <span className="titleText">Calculadora Nutricional</span>
                        <span>Cadastre um prato e verfique todas as informações nutricionais necessárias!</span>
                        <div className="separator"/>
                    </div>
                    {inputList.map((item, idx) => {
                        return (
                            <div key={idx} className="inputRow">
                                <div className="calculatorInputMargin">
                                    <FormControl sx={{ minWidth: 195 }}>
                                        <InputLabel id={"select-" + idx}>Carboidrato</InputLabel>
                                        <Select
                                            name="ingredient"
                                            labelId={"select-" + idx}
                                            value={item.ingredient}
                                            label="Carboidrato"
                                            onChange={e => handleInputChange(e, idx)}
                                        >
                                            { INGREDIENTES_API.carboidratos.map((item,idx) => (
                                                <MenuItem key={idx} value={ item.value }>{ item.label }</MenuItem>
                                            ))}
                                        </Select>
                                    </FormControl>
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
                    <div className="inputRow">
                        <div className="calculatorInputMargin">
                            <Button
                                onClick={handleAddClick}
                                variant="contained"
                                endIcon={<Add />}>
                                Adicionar novo campo
                            </Button>
                        </div>
                    </div>
                </CardContent>
            </Card>
        </div>
    );
}
