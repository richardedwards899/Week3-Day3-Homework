
require_relative('../db/sql_runner.rb')
require_relative('./artist.rb')

class Album

  attr_accessor :title, :genre, :artist_id
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id']
  end

  def delete()
    sql = "DELETE FROM albums where id = #{@id};"
    SqlRunner.run(sql)
  end

  def update()
    sql = "
    UPDATE albums SET ( title, genre, artist_id ) = ( '#{@title}', '#{@genre}', '#{@artist_id}' )
    WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def save()
    sql = "
    INSERT INTO albums ( title, genre, artist_id )
    VALUES ( '#{@title}', '#{@genre}', '#{@artist_id}' )
    RETURNING id;"

    @id = SqlRunner.run(sql)[0]["id"].to_i
  end

  def artist() 
    sql = "SELECT * FROM artists WHERE id=#{@artist_id};"
    return Artist.new ( SqlRunner.run(sql)[0] )
  end

  def Album.all()
    sql = "SELECT * FROM albums;"
    albums = SqlRunner.run(sql)
    return albums.map { |album_hash| Album.new(album_hash) }
  end

  def Album.find(id)
    sql = "SELECT * FROM albums WHERE id = #{id};"
    return Album.new ( SqlRunner.run(sql).first )
  end

  def Album.delete_all()
    sql = "DELETE FROM albums;"
    SqlRunner.run(sql)
  end

end
