#!/home/cristian/.rvm/rubies/ruby-2.2.1/bin/ruby
require 'net/http'
require 'json'
require 'uri'

email = 'julianvargas@fluvip.com'
token = '7tm_JWFT6PSJGddY-2Sz'
host = 'http://localhost:3000'
path = '/tasks.json'

def list_tasks(email, token, host, path)
  uri = URI.parse("#{host}#{path}")
  http = Net::HTTP.new(uri.host, uri.port)

  headers = {
    'X-User-Token' => token,
    'X-User-Email' => email,
    'Accept' => 'application/json',
    'Content-Type' => 'application/json'
  }

  response = http.get(uri.path, headers)
  tasks = JSON.parse(response.body)

  tasks.each do |t|
    puts "#{t["id"]} [#{t["status"]}] #{t["description"]}"
  end
end

def create_task(email, token, host, path, description)
  uri = URI.parse("#{host}#{path}")
  http = Net::HTTP.new(uri.host, uri.port)

  headers = {
    'X-User-Token' => token,
     'X-User-Email' => email,
     'Accept' => 'application/json',
     'Content-Type' => 'application/json'
  }

  data = {'task' => {"description" => description}}
  response = http.post(uri.path, data.to_json, headers)
  task = JSON.parse(response.body)
  puts "#{task["id"]} #{task["description"]}"
end

command = ARGV[0]
value = ARGV[1]

if command == 'list'
  list_tasks(email, token, host, path)
elsif command == 'create'
  create_task(email, token, host, path, value)
end
