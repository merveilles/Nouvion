require 'sqlite3'

module API
    class MemoryHealth
        def initialize
            @db = SQLite3::Database.new('nouvion.db')

            table = '
                CREATE TABLE IF NOT EXISTS health (
                    id INTEGER PRIMARY KEY,
                    username TEXT,
                    health NUMBER
                );
            '

            @db.execute(table)
        end

        def save(username, health)
            @db.execute('
                INSERT INTO health (username, health)
                VALUES (?, ?)
            ', [username, health])
        end

        def load(username)
            return @db.execute('
                SELECT * FROM health
                WHERE username = ?
            ', [username])
        end
    end
end
