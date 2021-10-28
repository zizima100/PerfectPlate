import React from "react";
import '../tutorial/TutorialScreenStyle.css';
import TabelaExemplo from "../../images/TabelaExemplo.jpg";

export default function TutorialScreen() {
    return (
        <>
            <div className="main">
                <div className="inputRow">
                    <div className="content-wrapper">
                        <h1>Como ler uma tabela nutricional</h1>
                        <img id="TabelaExemplo" src={ TabelaExemplo } alt="Exemplo de Tabela Nutricional"/>
                        <p>A primeira informação a que você deve se atentar para interpretar corretamente a tabela nutricional é o tamanho da porção considerada pelo fabricante – que costuma ser apenas parte do conteúdo total da embalagem.</p>
                        <p>Por exemplo, você pode se animar achando que uma barra de chocolate tem apenas 135 calorias, conforme especificado na tabela nutricional, sem se dar conta de que esse valor corresponde a apenas 25 gramas (4 quadradinhos). Assim, se você consumir a barra inteira, que costuma ter 140 gramas, na verdade estará ingerindo 756 calorias!</p>
                        <p>Portanto, você sempre deve observar qual é o tamanho da porção em gramas ou mililitros, seja para descobrir quanto você pode ou deve comer de cada alimento e também para poder comparar o valor nutricional de vários produtos (afinal, se as porções forem diferentes, será necessário fazer um cálculo para deixar as porções equivalentes).</p>
                    </div>
                </div>
            </div>
        </>
    );
};
