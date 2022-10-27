# file: app.rb

require_relative './lib/database_connection'
require_relative './lib/artist_repository'
require_relative './lib/album_repository'

class Application

  # The Application class initializer
  # takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * the AlbumRepository object (or a double of it)
  #  * the ArtistRepository object (or a double of it)
  def initialize(database_name, io, album_repository, artist_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @album_repository = album_repository
    @artist_repository = artist_repository
  end

  def run
    @io.puts "Welcome to the music library manager!"

    @io.puts "What would you like to do?
    1 - List all albums
    2 - List all artists"

    @io.puts "Enter your choice:"
    input = @io.gets.chomp
    input == 1 ? @album_repository.all.id + @album_repository.all.title : @artist_repository.all.id + @artist_repository.all.name
  end
end

def albums
  results_set = DatabaseConnection.exec_params('SELECT id, title FROM albums;', [])

  results_set.each do |record|
    puts record.values.join(" - ")
  end  
end  

def artists
  results_set = DatabaseConnection.exec_params('SELECT id, title FROM artists;', [])

  results_set.each do |record|
    puts record.values.join(" - ")
  end
end  

# Don't worry too much about this if statement. It is basically saying "only
# run the following code if this is the main file being run, instead of having
# been required or loaded by another file.
# If you want to learn more about __FILE__ and $0, see here: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
if __FILE__ == $0
  app = Application.new(
    'music_library',
    Kernel,
    AlbumRepository.new,
    ArtistRepository.new
  )
  app.run
end