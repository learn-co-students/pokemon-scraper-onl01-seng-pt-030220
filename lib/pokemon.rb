require 'pry'
class Pokemon

    attr_accessor :name, :type, :db
    attr_reader :id

    #KEYWORD ARGUMENTS PARAMATERS
    def initialize(id: , name: , type: , db: )
        @id = id
        @name = name
        @type = type
        @db = db
    end

    def self.save(name, type, db)
        sql = "INSERT INTO pokemon (name, type) VALUES (?, ?);"
        db.execute(sql, name, type)
    end

    def self.find(id, datab)
        sql = "SELECT * FROM pokemon WHERE id = ?;"
        blip = datab.execute(sql, id)[0]
        Pokemon.new(id: blip[0], name: blip[1], type: blip[2], db: datab)
    end

end #<---CLASSend