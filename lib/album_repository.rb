require 'album'

class AlbumRepository
  def all
    result_set = DatabaseConnection.exec_params('SELECT *  FROM albums', [])

    albums = []

    result_set.each do |record|
      album = Album.new
      album.id = record['id']
      album.title = record['title']
      album.release_year = record['release_year']
      album.artist_id = record['artist_id']

      albums << album
    end  

    return albums
  end
    
      
  def find(id)
    sql = 'SELECT title, release_year FROM albums WHERE id = $1;'

    params = [id]

    result = DatabaseConnection.exec_params(sql, params)
    
    record = result[0]

    album = Album.new
    album.id = record['id']
    album.title = record['title']
    album.release_year = record['release_year']
    album.artist_id = record['artist_id']

    return album
  end  

  

  def create(album)
    sql = 'INSERT INTO albums (title, release_year, artist_id) VALUES ($1, $2, $3);'

      

    result = DatabaseConnection.exec_params(sql, [album.title, album.release_year, album.artist_id])
      


  end  

  
end    