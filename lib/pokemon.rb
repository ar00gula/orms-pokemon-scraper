class Pokemon
    attr_accessor :name, :type, :id, :db

    def initialize(name:, type:, id: nil, db:)
        @name = name
        @type = type
        @id = id
        @db = db
    end

    def self.save(name, type, db)
        sql = <<-SQL
            INSERT INTO pokemon (name, type) 
            VALUES (?, ?)
        SQL

        db.execute(sql, name, type)

        @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end

    def self.find(id, db)
        sql = <<-SQL
        SELECT *
        FROM pokemon
        WHERE id == ?
        SQL

        pokemon = db.execute(sql, id)[0]
        self.new(name: pokemon[1], type: pokemon[2], id: pokemon[0], db: pokemon[3])
    end

end