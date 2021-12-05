import './PlatesListScreenStyle.css';
import React, {useState} from "react";
import {
    Button,
    Card,
    CardContent,
} from "@material-ui/core";
import {DeleteForever, Edit, Visibility} from "@material-ui/icons";

const API_LIST = [
    {
        id: 1,
        name: "Prato 1",
        date: "12/11/2021",
    },
    {
        id: 2,
        name: "Prato 2",
        date: "13/11/2021",
    },
    {
        id: 3,
        name: "Prato 3",
        date: "14/11/2021",
    },
    {
        id: 4,
        name: "Prato 4",
        date: "15/11/2021",
    },
];

export default function PlatesListScreen() {
    const [plateList, setPlateList] = useState(API_LIST);

    const visualizePlate = () => {
        console.log("visualizePlate");
    };

    const editPlate = () => {
        console.log("editPlate");
    };

    const deletePlate = () => {
        console.log("deletePlate");
    };

    return (
        <div className="calculatorMain">
            <Card sx={{ width: 1000 }}>
                <CardContent>
                    <div className="pageTitle">
                        <span className="titleText">Listagem de Pratos</span>
                        <span>Verifique aqui todos os pratos cadastrados anteriormente!</span>
                        <div className="separator"/>
                    </div>
                    {plateList.map((item, idx) => {
                        return (
                            <div key={idx}>
                                <div className="inputRow">
                                    <div className="plateItemCol">
                                        <span className="labelPadding">Código</span>
                                        <span>{item.id}</span>
                                    </div>
                                    <div className="plateItemCol">
                                        <span className="labelPadding">Nome do prato</span>
                                        <span>{item.name}</span>
                                    </div>
                                    <div className="plateItemCol">
                                        <span className="labelPadding">Data de criação</span>
                                        <span>{item.date}</span>
                                    </div>
                                    <div className="plateButtonCol">
                                        <Button
                                            onClick={visualizePlate}
                                            variant="contained"
                                            color="secondary"
                                            endIcon={<Visibility />}>
                                            Visualizar
                                        </Button>
                                    </div>
                                    <div className="plateButtonCol">
                                        <Button
                                            onClick={editPlate}
                                            variant="contained"
                                            endIcon={<Edit />}>
                                            Editar
                                        </Button>
                                    </div>
                                    <div className="plateButtonCol">
                                        <Button
                                            onClick={deletePlate}
                                            color="error"
                                            variant="contained"
                                            endIcon={<DeleteForever />}>
                                            Deletar
                                        </Button>
                                    </div>
                                </div>
                                {
                                    plateList.length - 1 !== idx && (
                                        <div className="separator" />
                                    )
                                }
                            </div>
                        );
                    })}
                </CardContent>
            </Card>
        </div>
    );
}
