import styles from './QrCode.module.css';
import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import SubmitButton from '../../form/SubmitButton';
import fundo from '../../images/CAPA.png';

function QrCode () {
        const navigate = useNavigate();

        return (
            <div className={styles.fundo} style={{ backgroundImage: `url(${fundo})`, backgroundRepeat: 'repeat',
            backgroundSize: '150px 150px'}}>
                <div className={styles.qr}>
                    <div className={styles.qrCode}>
                        <h1>QR Code</h1>
                        <p>Função indisponivel no momento!</p>
                    </div>
                    <SubmitButton text="Voltar" onClick={() => navigate('/saida')} />
                </div>
            </div>
        );
    }
    
export default QrCode