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

function createData(name, vEnergetico, carboidratos, proteinas, gordTotais, gordSaturadas, gordTrans, fibraAlimentar) {
    return { name, vEnergetico, carboidratos, proteinas, gordTotais, gordSaturadas, gordTrans, fibraAlimentar };
}

const rows = [
    createData('Frozen yoghurt', 159, 6.0, 24, 4.0),
    createData('Ice cream sandwich', 237, 9.0, 37, 4.3),
    createData('Eclair', 262, 16.0, 24, 6.0),
    createData('Cupcake', 305, 3.7, 67, 4.3),
    createData('Gingerbread', 356, 16.0, 49, 3.9),
];

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
                                        <TableCell>NOME DO PRATO (QUANTIDADE EM GRAMAS)</TableCell>
                                        <TableCell align="right">Valor Energético</TableCell>
                                        <TableCell align="right">Carboidratos&nbsp;(g)</TableCell>
                                        <TableCell align="right">Proteínas&nbsp;(g)</TableCell>
                                        <TableCell align="right">Gorduras Totais&nbsp;(g)</TableCell>
                                        <TableCell align="right">Gorduras Saturadas&nbsp;(g)</TableCell>
                                        <TableCell align="right">Gorduras Trans&nbsp;(g)</TableCell>
                                        <TableCell align="right">Fibra Alimentar&nbsp;(g)</TableCell>
                                        <TableCell align="right">Sódio&nbsp;(g)</TableCell>
                                    </TableRow>
                                </TableHead>
                                <TableBody>
                                    {rows.map((row) => (
                                        <TableRow
                                            key={row.name}
                                            sx={{ '&:last-child td, &:last-child th': { border: 0 } }}
                                        >
                                            <TableCell component="th" scope="row">
                                                {row.name}
                                            </TableCell>
                                            <TableCell align="right">{row.vEnergetico}</TableCell>
                                            <TableCell align="right">{row.carboidratos}</TableCell>
                                            <TableCell align="right">{row.proteinas}</TableCell>
                                            <TableCell align="right">{row.gordTotais}</TableCell>
                                            <TableCell align="right">{row.gordSaturadas}</TableCell>
                                            <TableCell align="right">{row.gordTrans}</TableCell>
                                            <TableCell align="right">{row.fibraAlimentar}</TableCell>
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
