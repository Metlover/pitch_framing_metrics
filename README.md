# pitch_framing_metrics
SQL Code for calculating pitch-framing independent pitching metrics. Requires a Statcast database to set up  - see [Bill Petti's work](https://billpetti.github.io/2018-02-19-build-statcast-database-rstats/) on how to set a Statcast database up in SQL. These examples are also written to incorporate the [Chadwick Bureau](https://github.com/chadwickbureau) to generate names, but the code can be easily modified to remove this functionality if a Chadwick Bureau DB is not available.


## catcher_framing_multiple_seasons.sql
Calculates the number of strikes stolen and strikes lost by catchers over the course of their careers split by season.
For example, the single-season leaders in Strikes Stolen - Lost Strikes from 2015 - 2018:

| First Name | Last Name | MLBAMID | Season | Lost Strikes | Stolen Strikes | Differential |
|------------|-----------|---------|--------|--------------|----------------|--------------|
| Buster     | Posey     | 457763  | 2016   | 290          | 613            | 323          |
| Martin     | Maldonado | 455117  | 2017   | 346          | 661            | 315          |
| Tyler      | Flowers   | 452095  | 2017   | 208          | 520            | 312          |
| Francisco  | Cervelli  | 465041  | 2015   | 374          | 670            | 296          |
| Yasmani    | Grandal   | 518735  | 2015   | 285          | 558            | 273          |
| Derek      | Norris    | 519083  | 2015   | 419          | 653            | 234          |
| Yasmani    | Grandal   | 518735  | 2016   | 318          | 540            | 222          |
| Austin     | Hedges    | 595978  | 2017   | 265          | 473            | 208          |
| Jeff       | Mathis    | 425772  | 2018   | 108          | 313            | 205          |
| Yasmani    | Grandal   | 518735  | 2017   | 307          | 508            | 201          |

## pitcher_framing_multiple_seasons.sql

Calculates the number of strikes stolen and strikes lost by catchers for individual pitchers over the course of their careers, in addition to nFIP and rFIP (explained [here](http://www.johnedwardsstats.com/2018/10/introducing-rfip-and-nfip.html)).
For example, the leaders in IP Outs from 2015-2018:
For example, the single season leaders in IP Outs from 2015-2018:

| First Name | Last Name | Season | Stolen Strikes | Lost Strikes | Strikes | Balls | K   | BB | IP Outs | HR | HBP | FIP    | rFIP       | nFIP       |
|------------|-----------|--------|----------------|--------------|---------|-------|-----|----|---------|----|-----|--------|------------|------------|
| Clayton    | Kershaw   | 2015   | 92             | 102          | 1764    | 1091  | 301 | 41 | 693     | 15 | 5   | 1.9695 | 2.22310539 | 2.25832311 |
| Dallas     | Keuchel   | 2015   | 168            | 61           | 1562    | 1289  | 215 | 51 | 690     | 17 | 2   | 2.9166 | 4.32664058 | 4.02074907 |
| Max        | Scherzer  | 2015   | 109            | 95           | 1796    | 979   | 276 | 32 | 685     | 27 | 5   | 2.7398 | 2.93101439 | 2.97598558 |
| David      | Price     | 2016   | 135            | 97           | 1772    | 1158  | 228 | 49 | 684     | 30 | 7   | 3.5944 | 3.69960167 | 3.70074579 |
| Max        | Scherzer  | 2016   | 95             | 97           | 1863    | 1145  | 284 | 54 | 683     | 31 | 6   | 3.2129 | 3.18288711 | 3.21705845 |
| Jake       | Arrieta   | 2015   | 86             | 104          | 1656    | 1202  | 235 | 46 | 681     | 10 | 6   | 2.3234 | 2.57414418 | 2.56696841 |
| Justin     | Verlander | 2016   | 113            | 79           | 1871    | 1213  | 252 | 56 | 680     | 30 | 8   | 3.4911 | 3.534849   | 3.54132989 |
| Chris      | Sale      | 2016   | 93             | 117          | 1678    | 1142  | 233 | 43 | 676     | 27 | 17  | 3.4355 | 3.56400819 | 3.57835575 |
| Madison    | Bumgarner | 2016   | 129            | 60           | 1770    | 1202  | 251 | 54 | 675     | 26 | 8   | 3.2448 | 3.59639081 | 3.56358724 |
| Zack       | Greinke   | 2015   | 149            | 63           | 1480    | 1161  | 199 | 39 | 665     | 14 | 5   | 2.7551 | 3.77555805 | 3.61197284 |
