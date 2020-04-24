class Pokemon

  attr_accessor :name, :type, :db
  attr_reader :id

  def initialize(id: nil, name:, type:, db:)
    @id, @name, @type, @db = id, name, type, db
  end

  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon (name, type)
      VALUES (?, ?)
    SQL

    db.execute(sql, name, type)
    @id = db.execute("SELECT  last_insert_rowid() FROM pokemon")[0][0]
  end

  def self.find(id, db)
    sql = "SELECT * FROM pokemon WHERE id = ?"
    db.execute(sql, id).map {|row| new_from_database(row)}.first
  end

  def self.new_from_database(row)
    self.new(id: row[0], name: row[1], type: row[2], db: row[3])
  end

end
