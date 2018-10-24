require 'benchmark'
require 'grpc'
require 'net/http'
require 'active_support/all'

proto_lib_dir = "#{__dir__}/lib/"
$LOAD_PATH.unshift(proto_lib_dir)
Dir.glob("#{proto_lib_dir}**/*.rb").each { |f| require f }

#Benchmark.bm 10 do |r|
#  r.report "Rest" do
#    url = URI.parse('http://127.0.0.1:3000')
#    res = Net::HTTP.start(url.host, url.port) {|http| http.get('/posts') }
#    res = Net::HTTP.start(url.host, url.port) {|http| http.get('/posts') }
#    res = Net::HTTP.start(url.host, url.port) {|http| http.get('/posts') }
#    res = Net::HTTP.start(url.host, url.port) {|http| http.get('/posts') }
#    res = Net::HTTP.start(url.host, url.port) {|http| http.get('/posts') }
#  end
#  r.report "Grpc" do
#    # 暗号化または認証なし
#    grpc_server = Blog::PostService::Stub.new('127.0.0.1:8080', :this_channel_is_insecure)
#    req = Blog::ReadAllRequest.new
#    res = grpc_server.read_all(req)
#    res = grpc_server.read_all(req)
#    res = grpc_server.read_all(req)
#    res = grpc_server.read_all(req)
#    res = grpc_server.read_all(req)
#  end
#end


post_service = Blog::PostService::Stub.new('127.0.0.1:8080', :this_channel_is_insecure)
req = Blog::CreateRequest.new(title: 'title-1', body: 'body-1')
res = post_service.create(req)
p res

