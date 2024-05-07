import axios from 'axios';
import { search } from "../../../api/src/logic/search";

describe('Teste de Requisição', () => {
    it('O teste faz uma requisição para a query "Maringá" e espera um corpo não nulo e não em branco', async () => {
        const response = await axios.get('http://localhost:3000/search/Maringá');

        expect(response.data).not.toBeNull();
        expect(response.data).not.toBe('');
    });
});

describe('Teste da função search', () => {
    it('Verifica se a função search retorna uma resposta no formato JSON', async () => {
        const response = await search('Maringá');

        expect(typeof response).toBe('object');
        expect(Array.isArray(response)).toBe(true);

        expect(() => JSON.stringify(response)).not.toThrow();

        response.forEach((item: any) => {
            expect(typeof item).toBe('object');
            expect(item).toHaveProperty('link');
            expect(item).toHaveProperty('titulo');
        });
    });
});