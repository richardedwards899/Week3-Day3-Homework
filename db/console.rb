require('pry-byebug')
require_relative('../models/artist.rb')
require_relative('../models/album.rb')

#clean up the database at the start
Album.delete_all() 
Artist.delete_all()

# #test the Artist class first

artist1 = Artist.new({
  'name' => 'Sting'
  })

artist2 = Artist.new({
  'name' => 'Beyonce' 
  })

artist3 = Artist.new({
  'name' => 'Madonna' 
  })

id1 = artist1.save
id2 = artist2.save
id3 = artist3.save

# artist1.name = 'Seal'
# artist1.update
# artist1.delete

album1 = Album.new({
  'title' => 'Mercury Falling',
  'genre' => 'Soft Rock',
  'artist_id' => artist1.id
  }
)

album2 = Album.new({
  'title' => 'Dangerously In Love',
  'genre' => 'Sassy Pop',
  'artist_id' => artist2.id
  }
)

album3 = Album.new({
  'title' => 'Lemonade',
  'genre' => 'Sassy Pop',
  'artist_id' => artist2.id
  }
)

album1.save
album2.save
album3.save

# album2.title = 'Lemonade'
# album2.update
# album1.delete

binding.pry
nil
