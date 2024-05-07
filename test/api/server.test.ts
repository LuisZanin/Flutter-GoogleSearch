import axios, { AxiosResponse } from 'axios';

describe('Teste de Estabilidade do Servidor', () => {
    it('Faz várias requisições para o servidor e verifica se todas são bem-sucedidas', async () => {
        const requestPromises: Promise<AxiosResponse>[] = [];
        const requestCount = 100;

        for (let i = 0; i < requestCount; i++) {
            requestPromises.push(axios.get('http://localhost:3000/search/Maringá'));
        }

        const responses: AxiosResponse[] = await Promise.all(requestPromises);

        responses.forEach(response => {
            expect(response.status).toBe(200);
        });
    }, 30000);
});