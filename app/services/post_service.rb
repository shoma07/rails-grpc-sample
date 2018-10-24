# app/services/post_service.rb
class PostService < Blog::PostService::Service

  def read_all(req, _call)
    Blog::ReadAllResponse.new(posts: Post.all.map(&:to_proto))
  end

  def read(req, _call)
    id = req.id
    post = Post.find_by(id: id)
    if post.present?
      Blog::ReadByIDResponse.new(post: post.to_proto)
    else
      raise GRPC::BadStatus.new_status_exception(
        GRPC::Core::StatusCodes::ABORTED,
        "Post(id=#{id}) isn't found.",
      )
    end
  end

  def create(req, _call)
    post = Post.new(title: req.title, body: req.body)
    if post.save
      Blog::CreateResponse.new(post: post.to_proto)
    else
      raise GRPC::BadStatus.new_status_exception(
        GRPC::Core::StatusCodes::ABORTED,
        "#{post.errors.to_json}",
      )
    end
  end
end
