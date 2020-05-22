class Pokemon

    attr_accessor :id, :name, :type, :db

    def initialize(id:, name:, type:, db:)
        @id, @name, @type, @db = id, name, type, db
    end

    def self.save(name, type, db)
        sql = <<-SQL 
            INSERT INTO pokemon (name, type) VALUES (?,?)
        SQL
        db.execute(sql, name, type)
    end

    def self.find(id_number, db)
        res = db.execute("SELECT * FROM pokemon WHERE id = ?", id_number).first
        Pokemon.new(id: res[0], name: res[1], type: res[2], db: db)
    end
end
