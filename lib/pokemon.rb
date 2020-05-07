# class Pokemon
#
#   attr_accessor :name, :type, :id, :db, :hp
#
#   def initialize(id:, name:, type:, hp:, db:)
#     @id = id
#     @name = name
#     @type = type
#     @hp = hp
#     @db = db
#   end
#
#   def self.create_table
#     sql =  <<-SQL
#       CREATE TABLE IF NOT EXISTS pokemon (
#         id INTEGER PRIMARY KEY,
#         name TEXT,
#         type TEXT
#         )
#     SQL
#     DB[:conn].execute(sql)
#   end
#
#   def self.drop_table
#     sql = "DROP TABLE IF EXISTS pokemon"
#     DB[:conn].execute(sql)
#   end
#
#   def save
#     if self.id
#       self.update
#     else
#       sql = <<-SQL
#         INSERT INTO pokemon (name, type)
#         VALUES (?, ?)
#       SQL
#
#       DB[:conn].execute(sql, self.name, self.type)
#
#       @id = DB[:conn].execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
#     end
#
#   end
#
#   def self.create(name, type)
#     pokemon = Pokemon.new(name, type)
#     pokemon.save
#   end
#
#   def self.new_from_db(row)
#     id = row[0]
#     name = row[1]
#     type = row[2]
#     self.new(id, name, type)
#   end
#
#   def self.find_by_name(name)
#     # find the pokemon in the database given a name
#     # return a new instance of the pokemon class
#     sql = <<-SQL
#       SELECT *
#       FROM pokemon
#       WHERE name = ?
#       LIMIT 1
#     SQL
#
#     DB[:conn].execute(sql,name).map do |row|
#       self.new_from_db(row)
#     end.first
#   end
#
#   def update
#     sql = "UPDATE pokemon SET name = ?, type = ? WHERE id = ?"
#     DB[:conn].execute(sql, self.name, self.type, self.id)
#   end
# end

class Pokemon
  attr_accessor :id, :name, :type, :hp, :db

  def self.save(name, type, db)
    db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)", name, type)
  end

  def self.find(id_num, db)
    pokemon_info = db.execute("SELECT * FROM pokemon WHERE id=?", id_num).flatten
    Pokemon.new(id: pokemon_info[0], name: pokemon_info[1], type: pokemon_info[2], hp: pokemon_info[3], db: db)
  end

  def initialize(id:, name:, type:, hp: nil, db:)
    @id, @name, @type, @hp, @db = id, name, type, hp, db
  end

  def alter_hp(new_hp, db)
    db.execute("UPDATE pokemon SET hp = ? WHERE id = ?", new_hp, self.id)
  end
end
