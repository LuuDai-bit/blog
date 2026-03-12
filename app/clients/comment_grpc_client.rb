require "grpc"

$LOAD_PATH.unshift(Rails.root.join("lib/grpc"))

require "comment_services_pb"

class CommentGrpcClient
  def initialize
    @stub = Comment::CommentService::Stub.new(
      ENV["GITHUB_GRPC_DOMAIN"] || "localhost:50051",
      :this_channel_is_insecure
    )
  end

  def create_comment(owner:, repo:, pr:, variables:)
    req = Comment::CreateCommentRequest.new(
      owner: owner,
      repo: repo,
      pullRequestNumber: pr,
      variables: variables
    )

    @stub.create_comment(req)
  end
end
