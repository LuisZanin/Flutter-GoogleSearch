import { JSDOM } from 'jsdom';

export async function search(data) {
    try {
        let url = `https://www.google.com/search?q=${data}`
        const response = await fetch(url)
        if(response.status === 200) {
            let data = await response.text();
            let info = extrairLinks(data)
            return info;
        }
    } catch (error) {
        console.error(error)
    }
}

function extrairLinks(html) {
    try {
        const dom = new JSDOM(html);
        const info = dom.window.document.querySelectorAll('a');
        let resultados = [];

        info.forEach(info => {
            const href = info.getAttribute('href');
            const linkfilter = /\/url\?q=(https?:\/\/[^&]+)/;
            const match = linkfilter.exec(href);
            if (match) {
                const url = match[1];
                let tituloElement = info.querySelector('h3') || info.querySelector('div') || info.querySelector('span');
                let titulo = tituloElement ? tituloElement.textContent.split('www.').shift() : '';
                titulo = titulo.split('>').shift();
                titulo = titulo.split('.org').shift();
                titulo = titulo.split('\n').shift();
                resultados.push({link: url, titulo});
            }
        });

        return resultados;

    } catch (error) {
        console.error(error)
    }
}
