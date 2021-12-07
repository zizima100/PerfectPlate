import React from "react";
import '../tutorial/TutorialScreenStyle.css';
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

const rows = getTableData(0, 0, 0, 0, 0, 0, 0);

export default function TutorialScreen() {
    return (
        <>
            <section className="tutorial__page-container">
                <Card className="tutorial__inputRow">
                    <article className="tutorial__content-container">
                        <h1 className="tutorial__title_h1">Como ler uma tabela nutricional</h1>
                        <div className="tutorial__nutri-table-container">
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
                        <p className="tutorial__content">
                            A primeira informação a que você deve se atentar para interpretar corretamente a tabela nutricional é o tamanho da porção considerada pelo fabricante – que costuma ser apenas parte do conteúdo total da embalagem.
                        </p>
                        <p className="tutorial__content">
                            Por exemplo, você pode se animar achando que uma barra de chocolate tem apenas 135 calorias, conforme especificado na tabela nutricional, sem se dar conta de que esse valor corresponde a apenas 25 gramas (4 quadradinhos). Assim, se você consumir a barra inteira, que costuma ter 140 gramas, na verdade estará ingerindo 756 calorias!
                        </p>
                        <p className="tutorial__content">
                            Portanto, você sempre deve observar qual é o tamanho da porção em gramas ou mililitros, seja para descobrir quanto você pode ou deve comer de cada alimento e também para poder comparar o valor nutricional de vários produtos (afinal, se as porções forem diferentes, será necessário fazer um cálculo para deixar as porções equivalentes). No caso do <strong>PerfectPlate</strong>, suas porções serão equivalentes ao prato descrito para o cálculo.
                        </p>
                    </article>
                </Card>
                <Card className="tutorial__inputRow">
                    <article className="tutorial__content-container">
                        <h1 className="tutorial__title_h1">Como utilizar a calculadora</h1>
                        <h2 className="tutorial__title_h2">Criando seu prato:</h2>
                        <p className="tutorial__content">
                            A primeira informação a que você deve se atentar para interpretar corretamente a tabela nutricional é o tamanho da porção considerada pelo fabricante – que costuma ser apenas parte do conteúdo total da embalagem.

                            Amoeba
                        </p>
                        <h2 className="tutorial__title_h2">Adicionando Ingredientes:</h2>
                        <p className="tutorial__content">
                            Por exemplo, você pode se animar achando que uma barra de chocolate tem apenas 135 calorias, conforme especificado na tabela nutricional, sem se dar conta de que esse valor corresponde a apenas 25 gramas (4 quadradinhos). Assim, se você consumir a barra inteira, que costuma ter 140 gramas, na verdade estará ingerindo 756 calorias!
                        </p>
                        <h2 className="tutorial__title_h2">Calculando o valor nutricional:</h2>
                        <p className="tutorial__content">
                            Portanto, você sempre deve observar qual é o tamanho da porção em gramas ou mililitros, seja para descobrir quanto você pode ou deve comer de cada alimento e também para poder comparar o valor nutricional de vários produtos (afinal, se as porções forem diferentes, será necessário fazer um cálculo para deixar as porções equivalentes).
                        </p>
                    </article>
                </Card>
            </section>
        </>
    );
};
