import { JSDOM } from 'jsdom';

export async function search(data : any, start : number = 0) {
    try {
        let url = `https://www.google.com/search?q=${data}&start=${start}`
        const response = await fetch(url, {
            headers: {
                'Content-Type': 'text/html; charset=UTF-8',
            }
        })
        if(response.status === 200) {
            let data = await response.text();

            return extrairLinks(data);
        }
    } catch (error) {
        console.error(error)
    }
}

function extrairLinks(html : any) {
    try {
        const dom = new JSDOM(html);
        const info = dom.window.document.querySelectorAll('a');
        let resultados = [];

        info.forEach(info => {
            const href = info.getAttribute('href');
            const linkfilter = /\/url\?q=(https?:\/\/[^&]+)/;
            const match = linkfilter.exec(href);
            if (match) {
                const url = decodeURIComponent(match[1]);
                let tituloElement = info.querySelector('h3') || info.querySelector('div') || info.querySelector('span');
                let titulo = tituloElement ? tituloElement.textContent.split('www.').shift() : '';
                titulo = titulo.split('>').shift();
                titulo = titulo.split('.org').shift();
                titulo = titulo.split('\n').shift();

                if(titulo !== '') {
                    resultados.push({link: url, titulo});
                }
            }
        });

        return resultados;

    } catch (error) {
        console.error(error)
        return [];
    }
}
