
SELECT now()::date;

SELECT date, ordering, author::CHAR(60), title::CHAR(60)
FROM registers
JOIN register_plays ON registers.id = register_plays.register_id
JOIN plays ON plays.id = register_plays.play_id
WHERE to_char(date, 'DD Mon') = '20 May'
ORDER BY date, ordering;