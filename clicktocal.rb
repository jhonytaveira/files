require 'rubygems'
require 'mysql'

user = "root"
db = "clicktocal_development"
host = "localhost"
pass = ""
con = Mysql.real_connect(host, user, pass, db)

query = con.query("select id,ddd,number,carried_out from register_numbers where carried_out=0")
query.each do |q|
  update = con.query("update register_numbers set carried_out = 1 where id = #{q[0]}")

  path = "/home/jhony/#{q[1, 2]}.call"
  File.open(path, "w+") do |f|
    f.write("Channel: Local/#{q[1, 2]}@mor
      MaxRetries: 1
      RetryTime: 120
      WaitTime: 30
      Account: 8
      Context: mor
      Application: Queue
      Data: problema_tecnico
      Extension: #{q[1, 2]}
      Priority: 1
      Set: MOR_AD_CAMPAIGN_ID=3")
  end
end
