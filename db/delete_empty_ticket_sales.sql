-- remove empty ticket sales entries

-- NB retains ticket sales lines that have either computed or recorded receipts;
--    removes completely empty lines and those with only a price

DELETE FROM ticket_sales
  WHERE COALESCE(total_sold, 0) + COALESCE(recorded_total_l, 0) + COALESCE(recorded_total_s, 0) + COALESCE(recorded_total_d, 0) = 0;


-- remove orphan ticket sales lines (those without a register page)

DELETE FROM ticket_sales
  WHERE NOT EXISTS (SELECT 1 FROM registers WHERE registers.id = register_id);