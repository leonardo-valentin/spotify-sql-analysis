/* 
Estes comentários vão dizer a pergunta que foram utilizados para serem
respondidos e também minhas conclusões sobre o resultado
*/

SELECT track_name, artist_name, streams
FROM spotify
ORDER BY streams DESC
LIMIT 100;

/* 
query1: Quais são as 100 músicas mais ouvidas no dataset?
resultado: Lista direta das músicas com maior número de streams.
Ponto de entrada para entender quais artistas e faixas dominam a plataforma.
*/

SELECT track_name, artist_name, streams
FROM spotify
WHERE artist_name = 'Olivia Rodrigo'
ORDER BY streams DESC
LIMIT 10;

/* 
query2: Quais são as músicas mais ouvidas da Olivia Rodrigo?
resultado:O filtro com WHERE permite isolar um artista específico
e ranquear suas músicas por popularidade. O mesmo modelo
serve para qualquer artista do dataset.
*/

SELECT artist_name, COUNT(artist_name) as count_appearence
FROM spotify
GROUP BY artist_name
ORDER BY count_appearence DESC
LIMIT 10;

/* 
query3: Qual artista aparece mais vezes no dataset?
resultado: Quantidade de músicas por artista no dataset. 
Artistas com mais entradas não necessariamente são os mais ouvidos — apenas lançaram mais músicas que foram indexadas.
*/

SELECT artist_name, SUM(streams) as all_streams, COUNT(artist_name) as count_appearence
FROM spotify
GROUP BY artist_name
ORDER BY count_appearence DESC
LIMIT 10;

/* 
query4: Qual artista tem mais streams totais e quantas músicas tem no dataset?
resultado: Combinando SUM e COUNT no mesmo agrupamento é possível comparar volume de streams com quantidade de músicas. Um artista com poucos lançamentos e streams altos indica hits concentrados; muitos lançamentos com streams distribuídos indica presença consistente.
*/

SELECT SUM(streams) as all_streams, released_year
FROM spotify
GROUP BY released_year
ORDER BY all_streams DESC
LIMIT 10;

/* 
query5: Qual ano teve mais streams no total?
resultado: 2021 e 2022 dominam o ranking de streams totais. Isso reflete o crescimento acelerado do Spotify no período pós-pandemia, quando muitos usuários migraram para streaming. 2023 não aparece no top 10 porque os dados foram coletados antes do fim do ano, deixando os streams incompletos.
*/

SELECT AVG(streams) as avg_streams, released_year
FROM spotify
GROUP BY released_year
ORDER BY released_year DESC;

/* 
query6: Qual a média de streams por ano?
resultado: Anos antigos como 1975 e 1983 aparecem com médias altíssimas, acima de anos recentes. Isso é enganoso — não significa que o Spotify era popular nessa época, mas sim que poucas músicas desses anos entraram no dataset e as que entraram são clássicos históricos com streams acumulados ao longo de décadas. A média sobe porque a amostra é pequena e enviesada para hits.
*/

SELECT AVG(streams) as avg_streams, released_year, COUNT(track_name) as track_quantity
FROM spotify
GROUP BY released_year
ORDER BY released_year DESC;

/* 
query7: Qual a média de streams por ano e quantas músicas cada ano tem no dataset?
resultado: Cruzando a média com a quantidade de músicas por ano, o viés fica evidente. Anos como 1975 têm média alta mas apenas 2 músicas no dataset. Já 2022 tem 402 músicas, tornando sua média muito mais representativa da realidade. Média sozinha pode enganar quando o tamanho da amostra varia muito entre grupos.
*/