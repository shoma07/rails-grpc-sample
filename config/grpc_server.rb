class GrpcServer

  attr_accessor :host, :port, :services

  def initialize(host: '127.0.0.1', port: 8080)
    @host = host
    @port = port
    @services = Dir.glob(File.expand_path('../../app/services/**/*.rb', __FILE__)).map do |service|
      File.basename(service).gsub(/\..+$/, '').split("_").map{|w| w[0] = w[0].upcase; w}.join
    end
    @server = GRPC::RpcServer.new
    @server.add_http2_port("#{@host}:#{@port}", :this_port_is_insecure)
  end

  def set_handler(handler_klass)
    @server.handle(handler_klass.new)
  end

  def run
    puts "Starting to listen: #{@port}"
    @server.run
  end

end

server = GrpcServer.new
Dir.glob(File.expand_path('../../app/services/**/*.rb', __FILE__)).each do |file|
  service = File.basename(file).gsub(/\..+$/, '').split("_").map{|w| w[0] = w[0].upcase; w}.join
  puts "Setting up GRPC Service: #{service}"
  server.set_handler service.constantize
end
server.run

