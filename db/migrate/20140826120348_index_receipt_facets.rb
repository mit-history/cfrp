class IndexReceiptFacets < ActiveRecord::Migration
  def up
    Register.index_facets ["season", "weekday", "title1", "title2", "author1", "author2", "genre1", "genre2",
                           "total_receipts", "parterre_receipts", "premiere_loge_receipts"]
  end

  def down
    Register.index_facets ["season", "weekday", "title1", "title2", "author1", "author2", "genre1", "genre2"]
  end
end
