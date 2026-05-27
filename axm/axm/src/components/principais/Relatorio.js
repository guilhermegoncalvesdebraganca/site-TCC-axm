import styles from '../principais/Relatorio.module.css';
import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import fundo from '../../images/CAPA.png';

function Relatorio() {
    const navigate = useNavigate();
    const [movimentacoes, setMovimentacoes] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const [searchTerm, setSearchTerm] = useState('');
    const [sortConfig, setSortConfig] = useState({ key: null, direction: 'ascending' });

    useEffect(() => {
        const fetchData = async () => {
            try {
                const [entradasRes, saidasRes, materiaisRes, almoxarifesRes] = await Promise.all([
                    fetch('http://localhost:3001/api/entrar'),
                    fetch('http://localhost:3001/api/saida'),
                    fetch('http://localhost:3001/api/material'),
                    fetch('http://localhost:3001/api/almoxarife')
                ]);

                const entradas = await entradasRes.json();
                const saidas = await saidasRes.json();
                const materiais = await materiaisRes.json();
                const almoxarifes = await almoxarifesRes.json();

                const materiaisMap = materiais.reduce((acc, mat) => {
                    acc[mat.codigo] = mat.nome;
                    return acc;
                }, {});

                const almoxarifesMap = almoxarifes.reduce((acc, alm) => {
                    acc[alm.cpf] = alm.nome;
                    return acc;
                }, {});

                const entradasFormatadas = entradas.map(entrada => ({
                    id: entrada.id_registro,
                    tipo: "Entrada",
                    material: materiaisMap[entrada.codigo] || 'Material não encontrado',
                    quantidade: entrada.qtd,
                    almoxarife: almoxarifesMap[entrada.cpf] || 'Almoxarife não encontrado',
                    data: new Date(entrada.createdAT).toLocaleDateString('pt-BR')
                }));

                const saidasFormatadas = saidas.map(saida => ({
                    id: saida.id_nota,
                    tipo: "Saída",
                    material: materiaisMap[saida.codigo] || 'Material não encontrado',
                    quantidade: saida.qtd,
                    almoxarife: almoxarifesMap[saida.cpf] || 'Almoxarife não encontrado',
                    data: new Date(saida.createdAT).toLocaleDateString('pt-BR')
                }));

                const todasMovimentacoes = [...entradasFormatadas, ...saidasFormatadas]
                    .sort((a, b) => new Date(b.data) - new Date(a.data));

                setMovimentacoes(todasMovimentacoes);
                setLoading(false);
            } catch (err) {
                console.error('Erro ao buscar dados:', err);
                setError('Erro ao carregar os dados. Por favor, tente novamente mais tarde.');
                setLoading(false);
            }
        };

        fetchData();
    }, []);

    // Função de ordenação
    const handleSort = (key) => {
        let direction = 'ascending';
        if (sortConfig.key === key && sortConfig.direction === 'ascending') {
            direction = 'descending';
        }
        setSortConfig({ key, direction });
    };

    // Função para renderizar o ícone de ordenação
    const renderSortIcon = (key) => {
        if (sortConfig.key === key) {
            return sortConfig.direction === 'ascending' ? ' ↑' : ' ↓';
        }
        return ' ↕';
    };

    // Aplicar ordenação e filtragem
    const filteredAndSortedMovimentacoes = movimentacoes
        .filter(item =>
            item.id.toString().toLowerCase().includes(searchTerm.toLowerCase()) ||
            item.tipo.toLowerCase().includes(searchTerm.toLowerCase()) ||
            item.material.toLowerCase().includes(searchTerm.toLowerCase()) ||
            item.almoxarife.toLowerCase().includes(searchTerm.toLowerCase()) ||
            item.data.toLowerCase().includes(searchTerm.toLowerCase())
        )
        .sort((a, b) => {
            if (!sortConfig.key) return 0;

            let aValue = a[sortConfig.key];
            let bValue = b[sortConfig.key];

            // Tratamento especial para datas
            if (sortConfig.key === 'data') {
                aValue = new Date(a.data.split('/').reverse().join('-'));
                bValue = new Date(b.data.split('/').reverse().join('-'));
            } else if (typeof aValue === 'string') {
                aValue = aValue.toLowerCase();
                bValue = bValue.toLowerCase();
            }

            if (aValue < bValue) {
                return sortConfig.direction === 'ascending' ? -1 : 1;
            }
            if (aValue > bValue) {
                return sortConfig.direction === 'ascending' ? 1 : -1;
            }
            return 0;
        });

    if (loading) {
        return (
            <div className={styles.fundo} style={{
                backgroundImage: `url(${fundo})`,
                backgroundRepeat: 'repeat',
                backgroundSize: '150px 150px'
            }}>
                <div className={styles.relatorio}>
                    <div className={styles.nav}>
                        <h1>Relatório</h1>
                        <button
                            className={styles.voltar}
                            onClick={() => navigate('/menuprincipal')}
                        >VOLTAR</button>
                    </div>
                    <div className={styles.inferior}>
                        <div className="flex justify-center items-center p-8">
                            <p className="text-lg">Carregando dados...</p>
                        </div>
                    </div>
                </div>
            </div>
        );
    }

    if (error) {
        return (
            <div className={styles.fundo} style={{
                backgroundImage: `url(${fundo})`,
                backgroundRepeat: 'repeat',
                backgroundSize: '150px 150px'
            }}>
                <div className={styles.relatorio}>
                    <div className={styles.nav}>
                        <h1>Relatório</h1>
                        <button
                            className={styles.voltar}
                            onClick={() => navigate('/menuprincipal')}
                        >VOLTAR</button>
                    </div>
                    <div className={styles.inferior}>
                        <div className="flex justify-center items-center p-8">
                            <p className="text-lg text-red-600">{error}</p>
                        </div>
                    </div>
                </div>
            </div>
        );
    }

    return (
        <div className={styles.fundo} style={{
            backgroundImage: `url(${fundo})`,
            backgroundRepeat: 'repeat',
            backgroundSize: '150px 150px'
        }}>
            <div className={styles.relatorio}>
                <div className={styles.nav}>
                    <h1>Relatório</h1>
                    <button
                        className={styles.voltar}
                        onClick={() => navigate('/menuprincipal')}
                    >VOLTAR</button>
                </div>
                <div className={styles.inferior}>
                    <div>
                        {/* Barra de pesquisa */}
                        <div className={styles.searchContainer}>
                            <input
                                type="text"
                                placeholder="Pesquisar por ID, tipo, material, almoxarife ou data..."
                                value={searchTerm}
                                onChange={(e) => setSearchTerm(e.target.value)}
                                className={styles.searchInput}
                            />
                        </div>

                        <div>
                            <table className={styles.tabela}>
                                <thead>
                                    <tr>
                                        <th onClick={() => handleSort('id')} className={styles.sortableHeader}>
                                            ID {renderSortIcon('id')}
                                        </th>
                                        <th onClick={() => handleSort('tipo')} className={styles.sortableHeader}>
                                            Tipo {renderSortIcon('tipo')}
                                        </th>
                                        <th onClick={() => handleSort('material')} className={styles.sortableHeader}>
                                            Material {renderSortIcon('material')}
                                        </th>
                                        <th onClick={() => handleSort('quantidade')} className={styles.sortableHeader}>
                                            Quantidade {renderSortIcon('quantidade')}
                                        </th>
                                        <th onClick={() => handleSort('almoxarife')} className={styles.sortableHeader}>
                                            Almoxarife {renderSortIcon('almoxarife')}
                                        </th>
                                        <th onClick={() => handleSort('data')} className={styles.sortableHeader}>
                                            Data {renderSortIcon('data')}
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {filteredAndSortedMovimentacoes.map((item) => (
                                        <tr key={`${item.tipo}-${item.id}`}>
                                            <td>{item.id}</td>
                                            <td>
                                                <span>
                                                    {item.tipo}
                                                </span>
                                            </td>
                                            <td>{item.material}</td>
                                            <td>{item.quantidade}</td>
                                            <td>{item.almoxarife}</td>
                                            <td>{item.data}</td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
}

export default Relatorio;