class Pokemon
  attr_accessor :name, :type, :db
  attr_reader :id
  
  def initialize(id:nil, name:, type:, db:)
    @id = id
    @name = name
    @type = type
    @db = db
  end

  def self.create(name:, type:, db:)
    poke = Pokemon.new(name, type, db)
    poke
  end

  def self.save(name, type, db)
      db.execute( "INSERT INTO pokemon (name, type) VALUES (?, ?)", [name, type] )
      @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
  end

  def self.find(int, db)
   result = db.execute("SELECT * FROM pokemon WHERE id = ?", [int])[0]
   poke = Pokemon.new(id:int, name:result[1], type:result[2], db:db)
   poke
  end

end
# Pokemon.find(3, pokemon)

