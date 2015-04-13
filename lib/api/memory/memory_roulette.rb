require 'sqlite3'

module API
    class MemoryRoulette
        def initialize
            @db = SQLite3::Database.new('nouvion.db')

            table = '
                CREATE TABLE IF NOT EXISTS roulette (
                    id INTEGER PRIMARY KEY,
                    chamber TEXT
                );
            '

            @db.execute(table)
        end

        def exists
            return @db.execute('
                SELECT * FROM roulette
            ').length > 0
        end

        def add(chamber)
            puts chamber
            @db.execute('
                INSERT INTO roulette (chamber)
                VALUES (?)
            ', [chamber])
        end

        def load
            return @db.execute('
                SELECT * FROM roulette
            ')
        end

        def update(chamber)
            @db.execute('
                UPDATE roulette
                SET chamber = ?
                WHERE id = 1
            ', [chamber])
        end

        def delete
            @db.execute('
                DELETE FROM roulette
                WHERE id = 1
            ')
        end
    end
end
