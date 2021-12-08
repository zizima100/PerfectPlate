import React, {useEffect, useState} from "react";
import '../nutricion-table/NutricionTableStyle.css';
import {
    Card,
    Table,
    TableBody,
    TableCell,
    TableContainer,
    TableHead,
    TableRow,
    Paper, Button
} from "@material-ui/core";
import {useSelector} from "react-redux";
import {useHistory} from "react-router-dom";
import {ArrowBack} from "@material-ui/icons";

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

export default function NutricionalTable() {
    const history = useHistory();
    const ingredientParams = history && history.location && history.location.state && history.location.state.ingredients;
    const [rows, setRows] = useState(null);
    const selector = useSelector(state => state);

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
            vEnergetico += (parseFloat(item.ingredient.value.energetic_value) * parseFloat(item.portionQtd));
            carboidratos += (parseFloat(item.ingredient.value.carbohydrate) * parseFloat(item.portionQtd));
            proteinas += (parseFloat(item.ingredient.value.protein) * parseFloat(item.portionQtd));
            gordTotais += (parseFloat(item.ingredient.value.total_fat) * parseFloat(item.portionQtd));
            gordSaturadas += (parseFloat(item.ingredient.value.saturated_fat) * parseFloat(item.portionQtd));
            gordTrans += (parseFloat(item.ingredient.value.trans_fat) * parseFloat(item.portionQtd));
            fibraAlimentar += (parseFloat(item.ingredient.value.fibre) * parseFloat(item.portionQtd));
            sodio += (parseFloat(item.ingredient.value.sodium) * parseFloat(item.portionQtd));
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
        if (history && selector.userData.id === 0) {
            alert("Você precisa estar logado para acessar essa página!")
            history.push("/");
        }
    }, [selector, history]);

    return (
        <>
            <section className="table__page-container">
                <Card className="table__card">
                    <div className="table__title-container">
                        <span className="titleText">Tabela Nutricional do seu Prato</span>
                        <div className="separator" />
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
                </Card>
            </section>
        </>
    );
};
