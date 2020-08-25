require 'sqlite3'
# A special module to work with database.
module DB
  def table_creation_string
    <<-SQL
      create table data (
        url varchar(100),
        page_type varchar(100),
        ip varchar(30)
      );
    SQL
  end

  def with_database
    db = SQLite3::Database.new ':memory:'

    # Create a table
    db.execute table_creation_string

    yield(db)
  rescue SQLite3::Exception => e
    puts 'Exception occurred'
    puts e
  ensure
    db&.close
  end

  def insert_row(db, row)
    url, ip = row.split(' ')
    page_type = url.sub(%r{.*\K\/\d+}, '')

    db.execute('INSERT INTO data (url, page_type, ip) VALUES (?, ?, ?)', [url, page_type, ip])
  end

  def most_page_views(db)
    db.execute('select page_type, count(ip) from data group by page_type order by count(ip) desc;')
  end

  def most_unique_views(db)
    db.execute('select url, count(distinct ip) from data group by url order by count(distinct ip) desc;')
  end
end
