class Pokemon
    attr_accessor :name, :type, :db
    attr_reader :id

    def initialize(name:, type:, id:, db:)
        @name, @type, @db, @id = name, type, db, id
    end

    def self.save(name, type, db)
        sql = <<-SQL
            INSERT INTO pokemon (name, type)
            VALUES (?, ?)
        SQL

        db.execute(sql, name, type)
    end

    def self.find(id, db)
        sql = <<-SQL
            SELECT * FROM pokemon
            WHERE id = ?
        SQL

        db.execute(sql, id).map do |row|
            self.new(name: row[1], type: row[2], id: row[0], db: db)
        end.first
    end

end
