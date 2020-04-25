class Pokemon
  attr_accessor :id, :name, :type, :db

  def initialize(id: nil, name:name, type:type, db:db)
    @id = id
    @name = name
    @type = type
    @db = db
  end

  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon (name,type)
      values(?,?)
    SQL

    db.execute(sql,name, type)
    @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
  end

  def self.find(id, db)
    sql = <<-SQL
    SELECT * from pokemon WHERE id = ?
    SQL

    get = db.execute(sql,id)[0]
    self.new(id:get[0], name: get[1], type: get[2], db:db)
  end
end
