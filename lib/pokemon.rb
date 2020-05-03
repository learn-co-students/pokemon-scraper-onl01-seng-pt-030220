require 'pry'
class Pokemon

  attr_accessor :name,:type,:id ,:db

  def initialize(attribute)
    @id,@name,@type,@db = attribute[:id],attribute[:name],attribute[:type],attribute[:db];
  end

  def self.save(name,type,db)
    sql=<<-SQL
       INSERT INTO pokemon (name,type) VALUES(?,?)
    SQL

    db.execute(sql,name,type)
    @id=db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
  end

  def self.find(id,db)

    sql = <<-SQL
     SELECT *
     FROM pokemon
     WHERE id = ?
   SQL
     found=db.execute(sql,id).flatten
     self.new(id:found[0],name:found[1],type:found[2],db:db)
  end

end
