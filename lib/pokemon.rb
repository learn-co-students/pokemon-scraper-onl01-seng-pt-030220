class Pokemon
    attr_accessor :id, :name, :type, :db, :hp


    def initialize(id:, name:, type:, hp: nil, db:)
      @id = id 
      @name = name 
      @db = db
      @type = type
      @hp = hp

    end 

    def self.save(name, type, db)
      db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)",name, type)
    end

    def self.find(number, db)
      var = db.execute("SELECT * FROM pokemon WHERE id=?", number).flatten

      Pokemon.new(id: var[0], name: var[1], type: var[2], hp: var[3], db: db)
    end 
end
