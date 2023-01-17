# Building A Number Guessing Game

Purely BASH scripting exercise backed by a simple Postgres database table.

The table `game_users` could look like the following:

```sql
CREATE TABLE game_users (
    game_user_id SERIAL PRIMARY KEY NOT NULL,
    username VARCHAR(22) UNIQUE NOT NULL,
    games_played INT,
    best_game INT
);
```

## Caviats

* My original approach was to break the tasks into functions and call funtion with pass-in params.  It works correctly (see my `alternative_script.sh`).  However, the FCC tests could not see pass the swanky scripting.  So, it fails to pass their tests.  
I revert to writing a straight through script to pass the FCC tests.

* In order to verify and pass the FCC tests `Run`, you must pay attention to details on the expected naming convention.

* Create a git branch and work on {feat:, fix:, refactor:} until you satisfy.  Then switch bach to the main branch and merge your branch.  Pretty basic git stuff.

* Use shorthand regex to check data type and length in user input.

## Lesson learned

This approach for prototyping a database cuts a lot of overhead.

Thanks FCC!

[back](https://github.com/hurricanemark/relational_database#learn-bash-scripting-by-building-five-programs)
