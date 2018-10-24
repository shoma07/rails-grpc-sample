class Post < ApplicationRecord

  def to_proto
    Blog::Post.new(
      id: id,
      title: title,
      body: body
    )
  end
end
