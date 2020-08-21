require 'sqlite3'

module DB
  def with_database
    begin
      db = SQLite3::Database.new ":memory:"

      # Create a table
      db.execute <<-SQL
        create table data (
          url varchar(100),
          page_type varchar(100),
          ip varchar(30)
        );
      SQL

      yield(db)
    rescue SQLite3::Exception => e

      puts "Exception occurred"
      puts e

    ensure
      db.close if db
    end
  end

  def insert_row(db, row)
    url, ip = row.split(' ')
    page_type = url.sub(/.*\K\/\d+/, '')

    db.execute("INSERT INTO data (url, page_type, ip) VALUES (?, ?, ?)", [url, page_type, ip])
  end

  def most_page_views(db)
    db.execute('select page_type, count(ip) from data group by page_type order by count(ip) desc;')
  end

  def most_unique_views(db)
    db.execute('select url, count(distinct ip) from data group by url order by count(distinct ip) desc;')
  end
end

