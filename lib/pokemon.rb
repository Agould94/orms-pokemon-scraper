require 'pry'
class Pokemon
    attr_accessor :id, :name, :type, :db

    def initialize(id: nil, name:, type:, db:)
        @id = id
        @name = name
        @type = type
        @db = db
    end

    def self.save(name, type, db)
        new_pokemon = Pokemon.new(name: name, type: type, db: db)
            sql = <<-SQL
            INSERT INTO pokemon(name, type)
            VALUES (?,?)
            SQL
        #binding.pry
        db.execute(sql, new_pokemon.name, new_pokemon.type)
        new_pokemon.id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end

    def self.find(id, db)
        sql = <<-SQL
        SELECT * FROM pokemon WHERE id = ?
        SQL

        pkmn = db.execute(sql, id)[0]
        new_pokemon = Pokemon.new(id: pkmn[0], name: pkmn[1], type: pkmn[2], db: db)
        new_pokemon

    end

   
end
