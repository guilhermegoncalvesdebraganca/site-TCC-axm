import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import ItemTabela from './ItemTabela';
import SubmitButton from '../../form/SubmitButton';
import fundo from '../../images/CAPA.png';
import styles from '../principais/Estoque.module.css';

function Estoque() {
    const navigate = useNavigate();
    const [items, setItems] = useState([]);
    const [error, setError] = useState(null);
    const [searchTerm, setSearchTerm] = useState('');
    const [sortConfig, setSortConfig] = useState({ key: null, direction: 'ascending' });

    useEffect(() => {
        fetchItems();
    }, []);

    const fetchItems = async () => {
        try {
            const response = await fetch('http://localhost:3001/api/material');
            if (!response.ok) {
                throw new Error('Erro ao buscar dados do servidor');
            }
            const data = await response.json();
            setItems(data);
        } catch (error) {
            setError(error.message);
            console.error('Erro:', error.message);
        }
    };

    // Função de ordenação
    const handleSort = (key) => {
        let direction = 'ascending';
        if (sortConfig.key === key && sortConfig.direction === 'ascending') {
            direction = 'descending';
        }
        setSortConfig({ key, direction });
    };

    // Aplicar ordenação aos items
    const sortedItems = [...items].sort((a, b) => {
        if (!sortConfig.key) return 0;

        let aValue = a[sortConfig.key];
        let bValue = b[sortConfig.key];

        // Converter para minúsculas se for string
        if (typeof aValue === 'string') {
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

    // Filtragem dos items baseada na pesquisa
    const filteredItems = sortedItems.filter(item =>
        item.nome.toLowerCase().includes(searchTerm.toLowerCase()) ||
        item.descricao.toLowerCase().includes(searchTerm.toLowerCase()) ||
        item.codigo.toString().includes(searchTerm)
    );

    // Função para renderizar o ícone de ordenação
    const renderSortIcon = (key) => {
        if (sortConfig.key === key) {
            return sortConfig.direction === 'ascending' ? ' ↑' : ' ↓';
        }
        return ' ↕';
    };

    return (
        <div
            className={styles.fundo}
            style={{
                backgroundImage: `url(${fundo})`,
                backgroundRepeat: 'repeat',
                backgroundSize: '150px 150px',
            }}
        >
            <div className={styles.estoque}>
                <div className={styles.nav}>
                    <h1>Estoque</h1>
                    <button
                        className={styles.voltar}
                        onClick={() => navigate('/menuprincipal')}
                    >
                        VOLTAR
                    </button>
                </div>

                {/* Barra de pesquisa */}
                <div className={styles.searchContainer}>
                    <input
                        type="text"
                        placeholder="Pesquisar por ID, nome ou descrição..."
                        value={searchTerm}
                        onChange={(e) => setSearchTerm(e.target.value)}
                        className={styles.searchInput}
                    />
                </div>

                {error && <div className={styles.error}>{error}</div>}

                <div className={styles.table}>
                    <table className={styles.tabela}>
                        <thead>
                            <tr>
                                <th onClick={() => handleSort('codigo')} className={styles.sortableHeader}>
                                    ID {renderSortIcon('codigo')}
                                </th>
                                <th onClick={() => handleSort('nome')} className={styles.sortableHeader}>
                                    Nome {renderSortIcon('nome')}
                                </th>
                                <th onClick={() => handleSort('descricao')} className={styles.sortableHeader}>
                                    Descrição {renderSortIcon('descricao')}
                                </th>
                                <th onClick={() => handleSort('quantidade')} className={styles.sortableHeader}>
                                    Quantidade {renderSortIcon('quantidade')}
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            {filteredItems.length > 0 ? (
                                filteredItems.map((item, index) => (
                                    <tr key={item.codigo}>
                                        <td>{item.codigo}</td>
                                        <td>{item.nome}</td>
                                        <td>{item.descricao}</td>
                                        <td>{item.quantidade}</td>
                                    </tr>
                                ))
                            ) : (
                                <tr>
                                    <td colSpan="4">Nenhum item encontrado</td>
                                </tr>
                            )}
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    );
}

export default Estoque;