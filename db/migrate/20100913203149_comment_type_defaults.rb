class CommentTypeDefaults < ActiveRecord::Migration
  def self.up
    questionCommentType = CommentType.new(:name => 'question')
    questionCommentType.id = 1
    questionCommentType.save

    interpretationCommentType = CommentType.new(:name => 'interpretation')
    interpretationCommentType.id = 2
    interpretationCommentType.save
  end

  def self.down
    CommentType.find(1, 2).each() { |comment_type| comment_type.destroy() }
  end
end
