require 'bundler'
Bundler.require

require_relative '../lib/song'

DB = { conn: SQLite3::Database.new("db/music.db") }
class Song

    # ... rest of methods
  
    def self.new_from_db(row)
      # self.new is equivalent to Song.new
      self.new(id: row[0], name: row[1], album: row[2])
    end

    def self.all
        sql = <<-SQL
          SELECT *
          FROM songs
        SQL
    
        DB[:conn].execute(sql).map do |row|
          self.new_from_db(row)
        end
      end
      def self.find_by_name(name)
        sql = <<-SQL
          SELECT *
          FROM songs
          WHERE name = ?
          LIMIT 1
        SQL
    
        DB[:conn].execute(sql, name).map do |row|
          self.new_from_db(row)
        end.first
      end
  
  end