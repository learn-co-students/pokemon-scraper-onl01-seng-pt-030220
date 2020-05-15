
class Pokemon
  attr_accessor :name, :type, :id, :db

  def initialize(poke)
    # binding.pry
    @name = poke[:name]
    @type = poke[:type]
    @id = poke[:id]
    @db = poke[:db]
  end

  def self.save(name, type, db)
    sql = <<-SQL
    INSERT INTO pokemon (name, type)
    VALUES (?, ?)
    SQL
    # binding.pry
    db.execute(sql, name, type)
  end

  def self.new_from_db(id)
    
  end

  def self.find(id, db)
    sql = <<-SQL
      SELECT *
      FROM pokemon
      WHERE id = ?
      LIMIT 1
    SQL
    db.execute(sql, id).map do |row|
      Pokemon.new(id: row[0], name: row[1], type: row[2])
    end.first
  end

end
