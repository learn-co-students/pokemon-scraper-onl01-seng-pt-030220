

class Pokemon

    attr_accessor :id, :name
    attr_reader :type, :db

    def initialize(id:, name:, type:, db:)
        @id = id
        @name = name
        @type = type
        @db = db
    end

    def self.save(name, type, db)
        sql = <<-SQL
            INSERT INTO pokemon (name, type)
            VALUES (?, ?)
        SQL

        db.execute(sql, name, type)

        @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end

    def self.find(id, db)
        res = db.execute("SELECT * FROM pokemon WHERE id = ?", [id])[0]
        pokemon = self.new(id: res[0], name: res[1], type: res[2], db: res[3])
        pokemon
    end

end
