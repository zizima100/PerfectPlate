import React from "react";
import '../about/AboutScreenStyle.css';
import { Card } from "@material-ui/core";

export default function AboutScreen() {
    return (
        <>
            <section className="about__page-container">
                <Card className="about__card">
                    <div className="about__container-title">
                        <span className="titleText">Sobre o Projeto</span>
                        <div className="separator"/>
                    </div>
                    <p className="about__content"> O projeto PerfectPlate é um projeto de faculdade com a proposta de promover um maior controle nutricional dos pratos ingeridos por atletas e frequentadores de academia e, também, estimular um maior interesse e conscientização pela leitura de tabelas nutricionais. Como um bônus, ainda, o aplicativo possibilita um melhor e mais ativo relacionamento entre nutricionista e cliente ao oferecer uma ferramenta que pode ser utilizada em conjunto pelos dois.  </p>
                </Card>
                <Card className="about__card">
                    <div className="about__container-title">
                        <span className="titleText">Informações Para Contato</span>
                        <div className="separator"/>
                    </div>
                    <ul className="about__list">
                        O PerfectPlane foi desenvolvido pelos developers:
                        <il className="about__item">Júlio Renato Minguini Faúndes</il>
                        <il className="about__item">Lucas Ribolli Blasquez</il>
                        <il className="about__item">Vinícius Natalino Zacheu</il>
                    </ul>
                </Card>
            </section>
        </>
    );
};
