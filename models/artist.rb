require_relative('../db/sql_runner.rb')
require_relative('./album.rb')

class Artist
  
  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO artists ( name ) VALUES ( '#{@name}' ) RETURNING id;"
    @id = SqlRunner.run(sql)[0]['id'].to_i
    return @id
  end
  
  def update()
    sql = "UPDATE artists SET ( name ) = ( '#{@name}' ) WHERE id = #{@id};"
    SqlRunner.run(sql)
    return nil
  end

  def albums()
    sql = "SELECT * FROM albums WHERE artist_id = #{@id};"
    album_hashes = SqlRunner.run(sql)

    return album_hashes.map { |album_hash| Album.new (album_hash) }
  end

  def delete()
    sql = "DELETE FROM artists where id = #{@id};"
    SqlRunner.run(sql)
    return nil
  end

  def Artist.all()
    sql = "SELECT * FROM artists;"
    artist_hashes = SqlRunner.run(sql)
    return artist_hashes.map { |artist_hash| Artist.new(artist_hash) }
  end

  def Artist.find(id)
    sql = "SELECT * FROM artists WHERE id = #{id};"
    return Artist.new ( SqlRunner.run(sql)[0] )
  end

  def Artist.delete_all()
    sql = "DELETE FROM artists;"
    SqlRunner.run(sql)
  end

end