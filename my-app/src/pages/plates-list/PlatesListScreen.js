import './PlatesListScreenStyle.css';
import React, {useEffect, useState} from "react";
import {
    Button,
    Card,
    CardContent,
} from "@material-ui/core";
import {DeleteForever, Edit, Visibility} from "@material-ui/icons";
import {useSelector} from "react-redux";
import {useHistory} from "react-router-dom";
import ApiService from "../../api/ApiService";
import moment from "moment";

export default function PlatesListScreen() {
    const [plateList, setPlateList] = useState([]);
    const selector = useSelector(state => state);
    const history = useHistory();
    const apiInstance = ApiService();

    const getData = async () => {
        const result = await apiInstance.getAllPlates(selector.userData.id);

        if (!result.data.ok) {
            alert("Houve um erro! Tente novamente mais tarde");
            return;
        }
        return setPlateList(result.data.data);
    };

    useEffect(() => {
        if (history && selector.userData.id === 0) {
            alert("Você precisa estar logado para acessar essa página!")
            history.push("/");
        }
    }, [selector, history]);

    useEffect(() => {
        getData().then()
    }, []);

    const visualizePlate = async (plateId) => {
        const plateData = await apiInstance.getPlateById(plateId);
        if (plateData.data.ok) {
            history.push({
                pathname: '/plate-edit-visualize',
                state: { ingredients: plateData.data.data }
            });
        }
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
                    {plateList.length > 0 ? plateList.map((item, idx) => {
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
                                        <span>{moment(item.date).format("DD/MM/YYYY")}</span>
                                    </div>
                                    <div className="plateButtonCol">
                                        <Button
                                            onClick={() => visualizePlate(item.id)}
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
                    }) : (
                        <div className="pageTitle">
                            <span><b>Você ainda não tem nenhum prato cadastrado!</b></span>
                        </div>
                    )}
                </CardContent>
            </Card>
        </div>
    );
}
