SELECT 
    chadwick_people.name_first,
    chadwick_people.name_last,
    seventhset.game_year,
    IFNULL(firstset.stolen_strikes, 0) AS 'stolen_strikes',
    IFNULL(secondset.lost_strikes, 0) AS 'lost_strikes',
    IFNULL(thirdset.strikes, 0) AS 'strikes',
    IFNULL(fourthset.balls, 0) AS 'balls',
    IFNULL(fifthset.k, 0) AS 'k',
    IFNULL(sixthset.walks, 0) AS 'bb',
    seventhset.ipouts,
    IFNULL(eighthset.hr, 0) AS 'hr',
    IFNULL(ninthset.hbp, 0) AS 'hbp',
    (IFNULL(eighthset.hr, 0) * 13 + 3 * (IFNULL(ninthset.hbp, 0) + IFNULL(sixthset.walks, 0)) - 2 * IFNULL(fifthset.k, 0)) / (seventhset.ipouts / 3) + CASE
        WHEN seventhset.game_year = 2015 THEN 3.134
        WHEN seventhset.game_year = 2016 THEN 3.147
        WHEN seventhset.game_year = 2017 THEN 3.158
        WHEN seventhset.game_year = 2018 THEN 3.161
        ELSE NULL
    END AS 'fip',
    (13 * IFNULL(eighthset.hr, 0) + 3 * (IFNULL(ninthset.hbp, 0) + (IFNULL(sixthset.walks, 0) + IFNULL(fifthset.k, 0)) / (1 + (7 * (IFNULL(thirdset.strikes, 0) + IFNULL(secondset.lost_strikes, 0) - IFNULL(firstset.stolen_strikes, 0)) / (IFNULL(fourthset.balls, 0) + IFNULL(firstset.stolen_strikes, 0) - IFNULL(secondset.lost_strikes, 0)) - 6))) - 2 * ((IFNULL(sixthset.walks, 0) + IFNULL(fifthset.k, 0)) - (IFNULL(sixthset.walks, 0) + IFNULL(fifthset.k, 0)) / (1 + (7 * (IFNULL(thirdset.strikes, 0) + IFNULL(secondset.lost_strikes, 0) - IFNULL(firstset.stolen_strikes, 0)) / (IFNULL(fourthset.balls, 0) + IFNULL(firstset.stolen_strikes, 0) - IFNULL(secondset.lost_strikes, 0)) - 6)))) / (seventhset.ipouts / 3) + CASE
        WHEN seventhset.game_year = 2015 THEN 3.134
        WHEN seventhset.game_year = 2016 THEN 3.147
        WHEN seventhset.game_year = 2017 THEN 3.158
        WHEN seventhset.game_year = 2018 THEN 3.161
        ELSE NULL
    END AS 'rfip',
    (13 * IFNULL(eighthset.hr, 0) + 3 * (IFNULL(ninthset.hbp, 0) + (IFNULL(sixthset.walks, 0) + IFNULL(fifthset.k, 0)) / (1 + (7 * (IFNULL(thirdset.strikes, 0) + IFNULL(secondset.lost_strikes, 0) - IFNULL(firstset.stolen_strikes, 0) - (IFNULL(thirdset.strikes, 0) + IFNULL(secondset.lost_strikes, 0) - IFNULL(firstset.stolen_strikes, 0)) * .054 + (IFNULL(fourthset.balls, 0) + IFNULL(firstset.stolen_strikes, 0) - IFNULL(secondset.lost_strikes, 0)) * .078) / (IFNULL(fourthset.balls, 0) + IFNULL(firstset.stolen_strikes, 0) - IFNULL(secondset.lost_strikes, 0) + (IFNULL(thirdset.strikes, 0) + IFNULL(secondset.lost_strikes, 0) - IFNULL(firstset.stolen_strikes, 0)) * .054 - (IFNULL(fourthset.balls, 0) + IFNULL(firstset.stolen_strikes, 0) - IFNULL(secondset.lost_strikes, 0)) * .078) - 6))) - 2 * ((IFNULL(sixthset.walks, 0) + IFNULL(fifthset.k, 0)) - (IFNULL(sixthset.walks, 0) + IFNULL(fifthset.k, 0)) / (1 + (7 * (IFNULL(thirdset.strikes, 0) + IFNULL(secondset.lost_strikes, 0) - IFNULL(firstset.stolen_strikes, 0) - (IFNULL(thirdset.strikes, 0) + IFNULL(secondset.lost_strikes, 0) - IFNULL(firstset.stolen_strikes, 0)) * .054 + (IFNULL(fourthset.balls, 0) + IFNULL(firstset.stolen_strikes, 0) - IFNULL(secondset.lost_strikes, 0)) * .078) / (IFNULL(fourthset.balls, 0) + IFNULL(firstset.stolen_strikes, 0) - IFNULL(secondset.lost_strikes, 0) + (IFNULL(thirdset.strikes, 0) + IFNULL(secondset.lost_strikes, 0) - IFNULL(firstset.stolen_strikes, 0)) * .054 - (IFNULL(fourthset.balls, 0) + IFNULL(firstset.stolen_strikes, 0) - IFNULL(secondset.lost_strikes, 0)) * .078) - 6)))) / (seventhset.ipouts / 3) + CASE
        WHEN seventhset.game_year = 2015 THEN 3.134
        WHEN seventhset.game_year = 2016 THEN 3.147
        WHEN seventhset.game_year = 2017 THEN 3.158
        WHEN seventhset.game_year = 2018 THEN 3.161
        ELSE NULL
    END AS 'nfip'
FROM
    (SELECT 
        pitcher, COUNT(*) AS 'stolen_strikes', game_year
    FROM
        play_by_play
    WHERE
        description = 'called_strike'
            AND zone > 10
    GROUP BY pitcher , game_year) AS firstset
        RIGHT JOIN
    (SELECT 
        pitcher, COUNT(*) AS 'lost_strikes', game_year
    FROM
        play_by_play
    WHERE
        description = 'ball' AND zone < 10
    GROUP BY pitcher , game_year) AS secondset ON secondset.pitcher = firstset.pitcher
        AND secondset.game_year = firstset.game_year
        RIGHT JOIN
    (SELECT 
        pitcher, COUNT(*) AS 'strikes', game_year
    FROM
        play_by_play
    WHERE
        type = 'S'
    GROUP BY pitcher , game_year) AS thirdset ON thirdset.pitcher = secondset.pitcher
        AND thirdset.game_year = secondset.game_year
        RIGHT JOIN
    (SELECT 
        pitcher, COUNT(*) AS 'called_strikes', game_year
    FROM
        play_by_play
    WHERE
        description = 'called_strike'
    GROUP BY pitcher , game_year) AS called_strikes ON called_strikes.pitcher = thirdset.pitcher
        AND called_strikes.game_year = thirdset.game_year
        RIGHT JOIN
    (SELECT 
        pitcher, COUNT(*) AS 'balls', game_year
    FROM
        play_by_play
    WHERE
        type = 'B'
    GROUP BY pitcher , game_year) AS fourthset ON fourthset.pitcher = called_strikes.pitcher
        AND fourthset.game_year = called_strikes.game_year
        RIGHT JOIN
    (SELECT 
        pitcher, COUNT(*) AS 'k', game_year
    FROM
        play_by_play
    WHERE
        events = 'strikeout'
    GROUP BY pitcher , game_year) AS fifthset ON fifthset.pitcher = fourthset.pitcher
        AND fifthset.game_year = fourthset.game_year
        RIGHT JOIN
    (SELECT 
        pitcher, COUNT(*) AS 'walks', game_year
    FROM
        play_by_play
    WHERE
        events = 'walk'
    GROUP BY pitcher , game_year) AS sixthset ON sixthset.pitcher = fifthset.pitcher
        AND sixthset.game_year = fifthset.game_year
        RIGHT JOIN
    (SELECT 
        pitcher,
            SUM(CASE
                WHEN events IN ('strikeout' , 'field_out', 'force_out', 'caught_stealing_2b', 'caught_stealing_3b', 'sac_fly', 'fielders_choice', 'sac_bunt', 'fielders_choice_out', 'other_out', 'caught_stealing_home', 'pickoff_caught_stealing_2b', 'pickoff_caught_stealing_3b', 'pickoff_1b', 'pickoff_2b', 'pickoff_3b', 'batter_interference', 'pickoff_caught_stealing_home') THEN 1
                ELSE CASE
                    WHEN events IN ('grounded_into_double_play' , 'double_play', 'strikeout_double_play', 'sac_fly_double_play', 'sac_bunt_double_play') THEN 2
                    ELSE CASE
                        WHEN events = 'triple_play' THEN 3
                        ELSE 0
                    END
                END
            END) AS 'ipouts',
            game_year
    FROM
        play_by_play
    WHERE
        events IS NOT NULL
    GROUP BY pitcher , game_year) AS seventhset ON seventhset.pitcher = sixthset.pitcher
        AND seventhset.game_year = sixthset.game_year
        LEFT JOIN
    (SELECT 
        pitcher, COUNT(*) AS 'hr', game_year
    FROM
        play_by_play
    WHERE
        events = 'home_run'
    GROUP BY pitcher , game_year) AS eighthset ON eighthset.pitcher = seventhset.pitcher
        AND eighthset.game_year = seventhset.game_year
        LEFT JOIN
    (SELECT 
        pitcher, COUNT(*) AS 'hbp', game_year
    FROM
        play_by_play
    WHERE
        events = 'hit_by_pitch'
    GROUP BY pitcher , game_year) AS ninthset ON ninthset.pitcher = eighthset.pitcher
        AND ninthset.game_year = eighthset.game_year
        INNER JOIN
    chadwick_people ON chadwick_people.key_mlbam = seventhset.pitcher
