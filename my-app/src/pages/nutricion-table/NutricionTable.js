import React from "react";
import '../nutricion-table/NutricionTableStyle.css';
import {
    Card,
    Table,
    TableBody,
    TableCell,
    TableContainer,
    TableHead,
    TableRow,
    Paper
} from "@material-ui/core";

function getTableData(vEnergetico,
    carboidratos,
    proteinas,
    gordTotais,
    gordSaturadas,
    gordTrans,
    fibraAlimentar
) {
    return [
        { name: 'Valor Energético', value: vEnergetico, key: 'vEnergetico' },
        { name: 'Carboidratos', value: carboidratos, key: 'carboidratos' },
        { name: 'Proteínas', value: proteinas, key: 'proteinas' },
        { name: 'Gorduras Totais', value: gordTotais, key: 'gordTotais' },
        { name: 'Gorduras Saturadas', value: gordSaturadas, key: 'gordSaturadas' },
        { name: 'Gorduras Trans', value: gordTrans, key: 'gordTrans' },
        { name: 'Fibra Alimentar', value: fibraAlimentar, key: 'fibraAlimentar' },
    ];
}

const rows = getTableData(159, 6.0, 24, 4.0, 15, 0, 15);

export default function NutricionalTable() {
    return (
        <>
            <section className="table__page-container">
                <Card className="table__card">
                    <div className="table__title-container">
                        <span className="titleText">Tabela Nutricional do Prato</span>
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
                                    {rows.map((row) => (
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
                </Card>
            </section>
        </>
    );
};
