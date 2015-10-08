-- remove duplicate ticket sales entries

-- "duplicate" means same on every field except id, created_at, updated_at

DELETE FROM ticket_sales
WHERE id IN (SELECT id
              FROM (SELECT id,
                row_number() OVER (PARTITION BY total_sold, register_id, seating_category_id,
                                                price_per_ticket_l, price_per_ticket_s, price_per_ticket_d,
                                                recorded_total_l, recorded_total_s, recorded_total_d ORDER BY id) AS rnum
                     FROM ticket_sales) t
              WHERE t.rnum > 1);


-- report dates and ticket sales data for any remaining duplicate entries, together with difference in receipts

SELECT date, rnum, sect, total_sold, price, recorded_total, created_at,
       CASE WHEN recorded_receipts - calc_receipts <> 0.0 THEN recorded_receipts - calc_receipts END AS calc_receipts_off FROM (
  SELECT date,
           sum(1) OVER (PARTITION BY register_id, seating_category_id) AS count,
           row_number() OVER (PARTITION BY register_id, seating_category_id) AS rnum,
           name AS sect,
           total_sold,
           'L.' || price_per_ticket_l || ' ' || price_per_ticket_s || 's ' || price_per_ticket_d || 'd' AS price,
           'L.' || recorded_total_l || ' ' || recorded_total_s || 's ' || recorded_total_d || 'd' AS recorded_total,
           ticket_sales.created_at,
           total_sold * (price_per_ticket_l + price_per_ticket_s::REAL / 20.0 + price_per_ticket_d::REAL / 240.0) AS calc_receipts,
           recorded_total_l + recorded_total_s::REAL / 20.0 + recorded_total_d::REAL / 240.0 AS recorded_receipts
  FROM ticket_sales JOIN registers ON (registers.id = register_id)
                    JOIN seating_categories ON (seating_categories.id = seating_category_id)
  ) AS t
  WHERE t.count > 1
  ORDER BY date, sect, rnum;


-- flag corrupt ticket sale entries by calculated receipts
--   ("corrupt" = off by more than 1 denier)

SELECT date, sect, total_sold, price, recorded_total, created_at,
       recorded_receipts - calc_receipts AS calc_receipts_off, substring(notes, 1, 30) FROM (
  SELECT date,
           name AS sect,
           total_sold,
           'L.' || price_per_ticket_l || ' ' || price_per_ticket_s || 's ' || price_per_ticket_d || 'd' AS price,
           'L.' || recorded_total_l || ' ' || recorded_total_s || 's ' || recorded_total_d || 'd' AS recorded_total,
           ticket_sales.created_at,
           total_sold * (price_per_ticket_l + price_per_ticket_s::REAL / 20.0 + price_per_ticket_d::REAL / 240.0) AS calc_receipts,
           recorded_total_l + recorded_total_s::REAL / 20.0 + recorded_total_d::REAL / 240.0 AS recorded_receipts,
           COALESCE(for_editor_notes, misc_notes) AS notes
  FROM ticket_sales JOIN registers ON (registers.id = register_id)
                    JOIN seating_categories ON (seating_categories.id = seating_category_id)
  ) AS t
  WHERE abs(recorded_receipts - calc_receipts) > 1.0 / 240.0
  ORDER BY date, sect;
