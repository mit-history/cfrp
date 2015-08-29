class FixBucketAggregation < ActiveRecord::Migration
  def up

    execute <<-SQL

      CREATE OR REPLACE FUNCTION bucket(val DOUBLE PRECISION, size INT, fmt TEXT, nullval TEXT) RETURNS TEXT AS $$
        SELECT COALESCE(
          to_char(trunc(val / size) * size, fmt) || '-' || to_char(trunc(val / size) * size + size - 1, fmt), nullval);
      $$ LANGUAGE SQL IMMUTABLE;

    SQL
  end

  def down

    # straight bug fix for a function with the same signature: no need to back out

  end
end
