require 'sqlite3'

module API
    class MemoryXenon
        def initialize
            @db = SQLite3::Database.new('nouvion.db')

            table = '
                CREATE TABLE IF NOT EXISTS xenon (
                    id INTEGER PRIMARY KEY,
                    username TEXT,
                    balance NUMBER
                );
            '

            @db.execute(table)
        end

        def exists(username)
            return @db.execute('
                SELECT * FROM xenon
                WHERE username = ?
            ', [username]).length > 0
        end

        def add(username, balance = 10)
            @db.execute('
                INSERT INTO xenon (username, balance)
                VALUES (?, ?)
            ', [username, balance])
        end

        def load(username)
            return @db.execute('
                SELECT * FROM xenon
                WHERE username = ?
            ', [username])
        end

        def update(username, balance)
            @db.execute('
                UPDATE xenon
                SET balance = ?
                WHERE username = ?
            ', [balance, username])
        end

        def delete(username)
            @db.execute('
                DELETE FROM xenon
                WHERE username = ?
            ', [username])
        end
    end
end
