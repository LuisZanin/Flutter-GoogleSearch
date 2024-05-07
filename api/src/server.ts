import { search } from './logic/search';
import express from 'express';

const app = express();
const port = 3000;

app.get('/search/:q', async (req, res) => {
    const query = req.params.q;
    const start = Number(req.query.start) || 0;

    try {
        const results = await search(query, start);
        if (results === undefined) {
            res.status(500).send('Erro, os dados não estão no formato JSON');
            return;
        }
        const jsonString = JSON.stringify(results);
        const json = JSON.parse(jsonString);
        res.setHeader('Content-Type', 'application/json; charset=utf-8');
        res.json(json);
    } catch (error) {
        console.error(error);
        res.status(500).send('Erro na pesquisa');
    }
});
app.listen(port, () => {
    console.log(`Servidor rodando na porta 3000`);
});