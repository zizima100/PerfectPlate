import './PlateVisualizeScreenStyle.css';
import React, {useEffect, useState} from "react";
import {
    Button,
    Card,
    CardContent,
    Paper,
    Table, TableBody,
    TableCell,
    TableContainer,
    TableHead,
    TableRow,
    TextField
} from "@material-ui/core";
import {ArrowBack} from "@material-ui/icons";
import {useSelector} from "react-redux";
import {useHistory} from "react-router-dom";

function getTableData(
    vEnergetico,
    carboidratos,
    proteinas,
    gordTotais,
    gordSaturadas,
    gordTrans,
    fibraAlimentar,
    sodio
) {
    return [
        { name: 'Valor Energético', value: vEnergetico, key: 'vEnergetico' },
        { name: 'Carboidratos', value: carboidratos, key: 'carboidratos' },
        { name: 'Proteínas', value: proteinas, key: 'proteinas' },
        { name: 'Gorduras Totais', value: gordTotais, key: 'gordTotais' },
        { name: 'Gorduras Saturadas', value: gordSaturadas, key: 'gordSaturadas' },
        { name: 'Gorduras Trans', value: gordTrans, key: 'gordTrans' },
        { name: 'Fibra Alimentar', value: fibraAlimentar, key: 'fibraAlimentar' },
        { name: 'Sódio', value: sodio, key: 'sodio' },
    ];
}

export default function PlateVisualizeScreen() {
    const history = useHistory();
    const ingredientParams = history && history.location && history.location.state && history.location.state.ingredients;
    const [inputList, setInputList] = useState([]);
    const selector = useSelector(state => state);
    const [rows, setRows] = useState(null);

    useEffect(async () => {
        if (history && selector.userData.id === 0) {
            alert("Você precisa estar logado para acessar essa página!")
            return history.push("/");
        }
    }, [selector, history]);

    useEffect(() => {
        let vEnergetico = 0;
        let carboidratos = 0;
        let proteinas = 0;
        let gordTotais = 0;
        let gordSaturadas = 0;
        let gordTrans = 0;
        let fibraAlimentar = 0;
        let sodio = 0;
        ingredientParams.map(item => {
            vEnergetico += (parseFloat(item.energetic_value) * parseFloat(item.number_of_portions));
            carboidratos += (parseFloat(item.carbohydrate) * parseFloat(item.number_of_portions));
            proteinas += (parseFloat(item.protein) * parseFloat(item.number_of_portions));
            gordTotais += (parseFloat(item.total_fat) * parseFloat(item.number_of_portions));
            gordSaturadas += (parseFloat(item.saturated_fat) * parseFloat(item.number_of_portions));
            gordTrans += (parseFloat(item.trans_fat) * parseFloat(item.number_of_portions));
            fibraAlimentar += (parseFloat(item.fibre) * parseFloat(item.number_of_portions));
            sodio += (parseFloat(item.sodium) * parseFloat(item.number_of_portions));
        });
        const getRows = getTableData(
            vEnergetico.toFixed(2),
            carboidratos.toFixed(2),
            proteinas.toFixed(2),
            gordTotais.toFixed(2),
            gordSaturadas.toFixed(2),
            gordTrans.toFixed(2),
            fibraAlimentar.toFixed(2),
            sodio.toFixed(2)
        );
        setRows(getRows)
    }, [ingredientParams]);

    useEffect(() => {
        let newInputList = [];
        ingredientParams.map(item => {
            let inputListItem = {
                ingredient: {
                    type: item.classification,
                    value: item
                },
                portionQtd: item.number_of_portions
            }
            newInputList.push(inputListItem)
        });
        setInputList(newInputList);
    }, [ingredientParams]);

    return (
        <div className="calculatorMain">
            <Card sx={{ width: 1000 }}>
                <CardContent>
                    <div className="pageTitle">
                        <span className="titleText">Visualização dos dados de um prato</span>
                        <span>Visualize os dados de um prato já cadastrado anteriormente!</span>
                        <div className="separator" />
                    </div>
                    <div className="calculatorListMargin">
                        <div className="pageSubTitle">
                            <span className="titleText">Ingredientes e Porções</span>
                        </div>
                        {inputList.length > 0 && inputList.map((item, idx) => {
                            return (
                                <div key={idx} className="inputRow">
                                    <div className="calculatorInputMargin">
                                        <TextField
                                            name="ingredient"
                                            type="text"
                                            label="Ingrediente"
                                            InputProps={{
                                                readOnly: true,
                                            }}
                                            value={item.ingredient.value.name}
                                        />
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
                                            InputProps={{
                                                readOnly: true,
                                            }}
                                            label="Qtd de porções"
                                            placeholder="Ex.: 2"
                                            value={item.portionQtd}
                                        />
                                    </div>
                                </div>
                            );
                        })}
                    </div>
                    <div className="separator" />
                    <div className="pageSubTitle">
                        <span className="titleText">Informações Nutricionais</span>
                    </div>
                    <div className="table__nutri-table-container">
                        <TableContainer component={Paper}>
                            <Table sx={{ minWidth: 650 }} aria-label="simple table">
                                <TableHead>
                                    <TableRow>
                                        <TableCell></TableCell>
                                        <TableCell align="right">Quantidade por Porção (g)</TableCell>
                                    </TableRow>
                                </TableHead>
                                <TableBody>
                                    {rows && rows.map((row) => (
                                        <TableRow
                                            key={row.key}
                                            sx={{ '&:last-child td, &:last-child th': { border: 0 } }}
                                        >
                                            <TableCell component="th" scope="rows">
                                                {row.name}
                                            </TableCell>
                                            <TableCell align="right">{row.value}</TableCell>
                                        </TableRow>
                                    ))}
                                </TableBody>
                            </Table>
                        </TableContainer>
                    </div>
                    <div className="inputRow">
                        <Button
                            onClick={() => history.push("/plates-list")}
                            variant="contained"
                            endIcon={<ArrowBack />}
                        >
                            Voltar para a listagem
                        </Button>
                    </div>
                </CardContent>
            </Card>
        </div>
    );
}
