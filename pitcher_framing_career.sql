SELECT 
    chadwick_people.name_first,
    chadwick_people.name_last,
    firstset.stolen_strikes,
    secondset.lost_strikes,
    thirdset.strikes,
    fourthset.balls,
    fifthset.k,
    sixthset.walks,
    seventhset.ipouts,
    eighthset.hr,
    ninthset.hbp
FROM
    (SELECT 
        pitcher, COUNT(*) AS 'stolen_strikes'
    FROM
        play_by_play
    WHERE
        description = 'called_strike'
            AND zone > 10
    GROUP BY pitcher) AS firstset
        RIGHT JOIN
    (SELECT 
        pitcher, COUNT(*) AS 'lost_strikes'
    FROM
        play_by_play
    WHERE
        description = 'ball' AND zone < 10
    GROUP BY pitcher) AS secondset on secondset.pitcher = firstset.pitcher
        RIGHT JOIN
    (SELECT 
        pitcher, COUNT(*) AS 'strikes'
    FROM
        play_by_play
    WHERE
        type = 'S'
    GROUP BY pitcher) AS thirdset on thirdset.pitcher = secondset.pitcher
        RIGHT JOIN
    (SELECT 
        pitcher, COUNT(*) AS 'balls'
    FROM
        play_by_play
    WHERE
        type = 'B'
    GROUP BY pitcher) AS fourthset on fourthset.pitcher = thirdset.pitcher
        RIGHT JOIN
    (SELECT 
        pitcher, COUNT(*) AS 'k'
    FROM
        play_by_play
    WHERE
        events = 'strikeout'
    GROUP BY pitcher) AS fifthset on fifthset.pitcher = fourthset.pitcher
        RIGHT JOIN
    (SELECT 
        pitcher, COUNT(*) AS 'walks'
    FROM
        play_by_play
    WHERE
        events = 'walk'
    GROUP BY pitcher) AS sixthset on sixthset.pitcher = fifthset.pitcher
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
            END) AS 'ipouts'
    FROM
        play_by_play
    WHERE
        events IS NOT NULL
    GROUP BY pitcher ) AS seventhset on seventhset.pitcher = sixthset.pitcher
        LEFT JOIN
    (SELECT 
        pitcher, COUNT(*) AS 'hr'
    FROM
        play_by_play
    WHERE
        events = 'home_run'
    GROUP BY pitcher) AS eighthset on eighthset.pitcher = seventhset.pitcher
        LEFT JOIN
    (SELECT 
        pitcher, COUNT(*) AS 'hbp'
    FROM
        play_by_play
    WHERE
        events = 'hit_by_pitch'
    GROUP BY pitcher) AS ninthset on ninthset.pitcher = eighthset.pitcher
    inner join chadwick_people on chadwick_people.key_mlbam = seventhset.pitcher
