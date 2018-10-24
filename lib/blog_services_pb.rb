# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: blog.proto for package 'blog'

require 'grpc'
require 'blog_pb'

module Blog
  module PostService
    class Service

      include GRPC::GenericService

      self.marshal_class_method = :encode
      self.unmarshal_class_method = :decode
      self.service_name = 'blog.PostService'

      rpc :ReadAll, ReadAllRequest, ReadAllResponse
      rpc :Read, ReadByIdRequest, ReadByIdResponse
      rpc :Create, CreateRequest, CreateResponse
    end

    Stub = Service.rpc_stub_class
  end
end