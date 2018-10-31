SELECT 
    chadwick_people.name_first,
    chadwick_people.name_last,
    firstset.Catcher,
    firstset.game_year,
    firstset.lost_strikes,
    secondset.stolen_strikes,
    (secondset.stolen_strikes - firstset.lost_strikes) AS 'diff'
FROM
    (SELECT 
        fielder_2 AS 'Catcher',
            COUNT(*) AS 'lost_strikes',
            game_year
    FROM
        play_by_play
    WHERE
        description = 'ball' AND zone < 10
    GROUP BY fielder_2 , game_year) AS firstset
        INNER JOIN
    (SELECT 
        fielder_2 AS 'Catcher',
            COUNT(*) AS 'stolen_strikes',
            game_year
    FROM
        play_by_play
    WHERE
        description = 'called_strike'
            AND zone > 10
    GROUP BY fielder_2 , game_year) AS secondset ON secondset.Catcher = firstset.Catcher
        AND secondset.game_year = firstset.game_year
        INNER JOIN
    chadwick_people ON chadwick_people.key_mlbam = firstset.catcher