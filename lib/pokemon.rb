class Pokemon
    attr_accessor :id, :name, :type, :db

    #KEYWORD ARGUMENTS PARAMATERS
    def initialize(id: , name: , type: , db: )
        @id = id
        @name = name
        @type = type
        @db = db
    end

    def save
        # save instance of Pokemon
        # VALIDATE ID


    end

end
