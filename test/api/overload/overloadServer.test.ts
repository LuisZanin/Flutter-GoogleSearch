import axios, { AxiosResponse } from 'axios';

describe('Testes de Overload de requisições com a query escolhida', () => {
    it('Irá sobrecarregar requisições para a query Maringá' ,async () => {
        const requestPromises: Promise<AxiosResponse>[] = [];
        const requestCount = 200;
        const route = '/search/Maringá';
        for (let i = 0; i < requestCount; i++) {
            requestPromises.push(axios.get(`http://localhost:3000${route}`));
        }

        const responses: AxiosResponse[] = await Promise.all(requestPromises);

        responses.forEach(response => {
            expect(response.status).toBe(200);
        });
    }, 30000);
});