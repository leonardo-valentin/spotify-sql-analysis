/* 
Cada query abaixo foi escrita para responder uma pergunta específica sobre o dataset.
Os comentários após cada query descrevem a pergunta e as conclusões tiradas do resultado.
*/

-- Uma linha foi identificada com dados colapsados em um único campo.
-- Foi criada uma view excluindo essa entrada para garantir a integridade das análises.
CREATE VIEW spotify_limpo AS
SELECT * FROM spotify
WHERE track_name != 'Love Grows (Where My Rosemary Goes)';

/* 
query1: Quais são as 100 músicas mais ouvidas no dataset?
resultado: Lista direta das músicas com maior número de streams.
Ponto de entrada para entender quais artistas e faixas dominam a plataforma.
*/
SELECT track_name, artist_name, streams
FROM spotify_limpo
ORDER BY streams DESC
LIMIT 100;

/* 
query2: Quais são as músicas mais ouvidas da Olivia Rodrigo?
resultado: O filtro com WHERE permite isolar um artista específico
e ranquear suas músicas por popularidade. O mesmo modelo
serve para qualquer artista do dataset.
*/
SELECT track_name, artist_name, streams
FROM spotify_limpo
WHERE artist_name = 'Olivia Rodrigo'
ORDER BY streams DESC
LIMIT 10;

/* 
query3: Qual artista aparece mais vezes no dataset?
resultado: Quantidade de músicas por artista no dataset. 
Artistas com mais entradas não necessariamente são os mais ouvidos — apenas lançaram mais músicas que foram indexadas.
*/
SELECT artist_name, COUNT(artist_name) as count_appearence
FROM spotify_limpo
GROUP BY artist_name
ORDER BY count_appearence DESC
LIMIT 10;

/* 
query4: Qual artista tem mais streams totais e quantas músicas tem no dataset?
resultado: Combinando SUM e COUNT no mesmo agrupamento é possível comparar volume de streams com quantidade de músicas. Um artista com poucos lançamentos e streams altos indica hits concentrados; muitos lançamentos com streams distribuídos indica presença consistente.
*/
SELECT artist_name, SUM(streams) as all_streams, COUNT(artist_name) as count_appearence
FROM spotify_limpo
GROUP BY artist_name
ORDER BY count_appearence DESC
LIMIT 10;

/* 
query5: Qual ano teve mais streams no total?
resultado: 2021 e 2022 dominam o ranking. Considerando que o dataset é de 2023, faz sentido — foram os anos em que o Spotify se tornou mais popular e concentrou mais streams. Já 2023 nem aparece no top 10 porque os dados foram retirados antes do fim do ano, então as visualizações estavam incompletas na época da coleta.
*/
SELECT SUM(streams) as all_streams, released_year
FROM spotify_limpo
GROUP BY released_year
ORDER BY all_streams DESC
LIMIT 10;

/* 
query6: Qual a média de streams por ano?
resultado: O resultado ficou bem misturado. Como o Spotify tem seu próprio ano de lançamento, músicas muito antigas naturalmente não teriam tantas visualizações — mas ainda assim aparecem com médias altas em alguns anos. Isso acontece porque o dataset é incompleto nesses períodos, então uma média alta em 1975 por exemplo não significa popularidade real na plataforma.
*/
SELECT AVG(streams) as avg_streams, released_year
FROM spotify_limpo
GROUP BY released_year
ORDER BY released_year DESC;

/* 
query7: Qual a média de streams por ano e quantas músicas cada ano tem no dataset?
resultado: Cruzando a média com a quantidade de músicas por ano ficou claro o que estava acontecendo. O dataset parece incompleto e usado apenas como exemplo — mas as poucas músicas dos anos antigos que aparecem são hits com números absurdos, o que puxa a média para cima. Já 2022 tem 402 músicas no dataset, então sua média é muito mais representativa da realidade. Média sozinha pode enganar quando o tamanho da amostra varia muito entre grupos.
*/
SELECT AVG(streams) as avg_streams, released_year, COUNT(track_name) as track_quantity
FROM spotify_limpo
GROUP BY released_year
ORDER BY released_year DESC;
