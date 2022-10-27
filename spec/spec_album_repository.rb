require 'album_repository'
require 'album'
require 'pg'


RSpec.describe AlbumRepository do
  def reset_albums_table
    seed_sql = File.read('spec/seeds_albums.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library' })
    connection.exec(seed_sql)
  end
  

  before(:each) do 
    reset_albums_table
  end

  it 'returns the list of artists' do
    repo = AlbumRepository.new

    albums = repo.all

    expect(albums.length).to eq(2)
    expect(albums.first.id).to eq("1")
    expect(albums.first.title).to eq('Voyage')
  end  

  it 'finds a specific record using the id' do
        repo = AlbumRepository.new
        album = repo.find(2)
        expect(album.release_year).to eq "1973"
        expect(album.title).to eq "Ring Ring"
  end  

  it 'creates an album' do
    repository = AlbumRepository.new
    album = Album.new
    album.title = 'Trompe le Monde'
    album.release_year = 1991
    album.artist_id = 1
    repository.create(album)
    
    expect(repository.find(3).title).to eq 'Trompe le Monde'
    expect(album.release_year).to eq 1991
    expect(album.artist_id).to eq 1

    # The all_albums array should contain the new Album object
  end  
  
end