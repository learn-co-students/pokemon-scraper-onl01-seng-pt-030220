class Pokemon
  
  attr_accessor :name, :type, :id, :db, :hp 
  
  def initialize(keywords)

  end
  
  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon (name, type) 
      VALUES (?, ?);
    SQL
    
    db.execute(sql, [name, type])
  end
  
  def self.find(num, db)
    pokemon = db.execute("SELECT * FROM pokemon WHERE id=?", [num])
    new_pokemon = self.new(pokemon)
    new_pokemon.id = pokemon[0][0]
    new_pokemon.name = pokemon[0][1]
    new_pokemon.type = pokemon[0][2]
    new_pokemon.hp = pokemon[0][3]
    return new_pokemon
  end
  
  def alter_hp(new_hp)
    sql = <<-SQL
      UPDATE pokemon SET hp = ? WHERE id = ?;
    SQL
    
    db.execute(sql, [new_hp, id])
  end
  
  
end
