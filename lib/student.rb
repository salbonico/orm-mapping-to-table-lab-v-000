class Student
 attr_accessor :name, :grade
 attr_reader :id
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

  def initialize(name,grade)
    @name = name
    @grade = grade
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER primary key,
        name TEXT,
        grade TEXT
      )
      SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE students")
  end

  def save
   sql = <<-SQL
    INSERT INTO students (name,grade)
    VALUES (?,?);
    SQL
   DB[:conn].execute(sql,@name,@grade)
   @id = DB[:conn].execute("SELECT last_insert_rowid() FROM songs")[0][0]

  end
end
