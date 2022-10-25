# EXAMPLE
# Table name: students

# Repository class
# (in lib/student_repository.rb)

class ArtistRepository

    # Selecting all records
    # No arguments
    def all
      result_set = DatabaseConnection.exec_params('SELECT id, name, genre FROM artists', [])

      artists = []

      result_set.each do |record|
        artist = Artist.new
        artist.id = record['id']
        artist.name = record['name']
        artist.genre = record['genre']

        artists << artist
      end  

      return artists
    end
  
    # Gets a single record by its ID
    # One argument: the id (number)
    def find(id)
      # Executes the SQL query:
      # SELECT id, name, cohort_name FROM students WHERE id = $1;
  
      # Returns a single Student object.
    end
  
    # Add more methods below for each operation you'd like to implement.
  
    # def create(student)
    # end
  
    # def update(student)
    # end
  
    # def delete(student)
    # end
  end