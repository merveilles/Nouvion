require 'sqlite3'

module API
    class MemoryRemember
        def initialize
            @db = SQLite3::Database.new('nouvion.db')

            table = '
                CREATE TABLE IF NOT EXISTS remember (
                    id INTEGER PRIMARY KEY,
                    username TEXT,
                    term TEXT,
                    definition TEXT,
                    relation TEXT
                );
            '

            @db.execute(table)
        end

        def save(username, term, definition, relation)
            @db.execute('
                INSERT INTO remember (username, term, definition, relation)
                VALUES (?, ?, ?, ?)
            ', [username, term, definition, relation])
        end

        def load(term)
            return @db.execute('
                SELECT * FROM remember
                WHERE definition = ?
            ', [term])
        end
    end
end
