#!/usr/bin/ruby
#encoding: utf-8

require 'pg'

# this is just not working.
#conn = PGconn.open(:user => 'cfrp', :password => 'cfrp$02139', :dbname => 'hyperstudio_development', :host => 'hs-dev.mit.edu')
conn = PGconn.open(:user => 'cfrp', :password => 'cfrp$02139', :dbname => 'older_cfrp_development')
conn_dev = PGconn.open(:user => 'cfrp', :password => 'cfrp$02139', :dbname => 'cfrp_development')


# NOTE: IDs NEED TO BE KEPT THE SAME ACROSS THE BOARD

#USERS

#COMMON FIELDS
#shortname
#last_name
#first_name
#bio
#email
#institution
#institution_code
#created_at
#updated_at
#id
#(name change, old -> new)
#crypted_password => encrypted_password
#salt => password_salt

#FIELDS ONLY IN OLD TABLE
# activated_at       | timestamp without time zone | 
# activation_code    | character varying(50)       | 
# password_reset_key | character varying(50)       | 

#FIELDS ONLY IN NEW TABLE
# reset_password_token | character varying(255)      | 
# remember_token       | character varying(255)      | 
# remember_created_at  | timestamp without time zone | 
# sign_in_count        | integer                     | default 0
# current_sign_in_at   | timestamp without time zone | 
# last_sign_in_at      | timestamp without time zone | 
# current_sign_in_ip   | character varying(255)      | 
# last_sign_in_ip      | character varying(255)      | 
#----

users_select = "SELECT shortname, last_name, first_name, bio, email, institution, institution_code, created_at, updated_at, id, crypted_password, salt FROM users"
res = conn.exec(users_select)

if res.count > 0
  res.each do |this_user|
    # print "#{this_user}\n"

    user_array = [ this_user['shortname'], this_user['last_name'], this_user['first_name'], this_user['bio'], this_user['email'], this_user['institution'], this_user['institution_code'], this_user['created_at'], this_user['updated_at'], this_user['id'], this_user['crypted_password'], this_user['salt'] ]

    print "#{user_array}\n\n"

    conn_dev.exec('INSERT INTO users (shortname, last_name, first_name, bio, email, institution, institution_code, created_at, updated_at, id, encrypted_password, password_salt) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12)', user_array)
  end
else
  print "FAILURE\n"
end


#REGISTERS
#-note that register_type_id in old db is register_period_id in new

registers_select = "SELECT id, date, weekday, season, register_num, payment_notes, date_flag, season_flag, regnum_flag, totalreceipts_flag, payment_notes_flag, page_text, page_text_flag, total_receipts_recorded_l, total_receipts_recorded_s, representation, signatory, signatory_flag, rep_flag, misc_notes, misc_notes_flag, for_editor_notes, ouverture, ouverture_flag, cloture, cloture_flag, created_at, updated_at, register_image_id, register_type_id FROM registers"
res = conn.exec(registers_select)

if res.count > 0
  res.each do |this_register|
#    print "#{this_register}\n\n"

    register_array = [ this_register['id'], this_register['date'], this_register['weekday'], this_register['season'], this_register['register_num'], this_register['payment_notes'], this_register['date_flag'], this_register['season_flag'], this_register['regnum_flag'], this_register['totalreceipts_flag'], this_register['payment_notes_flag'], this_register['page_text'], this_register['page_text_flag'], this_register['total_receipts_recorded_l'], this_register['total_receipts_recorded_s'], this_register['representation'], this_register['signatory'], this_register['signatory_flag'], this_register['rep_flag'], this_register['misc_notes'], this_register['misc_notes_flag'], this_register['for_editor_notes'], this_register['ouverture'], this_register['ouverture_flag'], this_register['cloture'], this_register['cloture_flag'], this_register['created_at'], this_register['updated_at'], this_register['register_image_id'], this_register['register_period_id'] ]

    print "#{register_array}\n\n"

    conn_dev.exec('INSERT INTO registers (id, date, weekday, season, register_num, payment_notes, date_flag, season_flag, regnum_flag, totalreceipts_flag, payment_notes_flag, page_text, page_text_flag, total_receipts_recorded_l, total_receipts_recorded_s, representation, signatory, signatory_flag, rep_flag, misc_notes, misc_notes_flag, for_editor_notes, ouverture, ouverture_flag, cloture, cloture_flag, created_at, updated_at, register_image_id, register_period_id) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $30)', register_array)
  end
else
  print "FAILURE\n"
end

#COMMENTS
#(same)

comments_select = "SELECT id, name, value, register_id, comment_type_id FROM comments WHERE value != ''"
res = conn.exec(comments_select)

if res.count > 0
  res.each do |this_comment|
#    print "#{this_comment}\n\n"

    comment_array = [ this_comment['id'], this_comment['name'], this_comment['value'], this_comment['register_id'], this_comment['comment_type_id'] ]

    print "#{comment_array}\n\n"

    conn_dev.exec('INSERT INTO comments (id, name, value, register_id, comment_type_id) VALUES ($1, $2, $3, $4, $5)', comment_array)
  end
else
  print "FAILURE\n"
end


#PLAYS
#(same)

plays_select = "SELECT id, title, author, genre FROM plays"
res = conn.exec(plays_select)

if res.count > 0
  res.each do |this_play|
#    print "#{this_play}\n\n"

    play_array = [ this_play['id'], this_play['title'], this_play['author'], this_play['genre'] ]

    print "#{play_array}\n\n"

    conn_dev.exec('INSERT INTO plays (id, title, author, genre) VALUES ($1, $2, $3, $4)', play_array)
  end
else
  print "FAILURE\n"
end


#REGISTER_IMAGES
#(same)

reg_images_select = "SELECT id, filepath, user_id FROM register_images"
res = conn.exec(reg_images_select)

if res.count > 0
  res.each do |this_reg_image|
#    print "#{this_reg_image}\n\n"

    reg_image_array = [ this_reg_image['id'], this_reg_image['filepath'], this_reg_image['user_id'] ]

    print "#{reg_image_array}\n\n"

    conn_dev.exec('INSERT INTO register_images (id, filepath, user_id) VALUES ($1, $2, $3)', reg_image_array)
  end
else
  print "FAILURE\n"
end


#REGISTER_PLAYS
#(same)

reg_plays_select = "SELECT id, register_id, play_id, firstrun, newactor, actorrole, editor_flag, firstrun_perfnum FROM register_plays"
res = conn.exec(reg_plays_select)

if res.count > 0
  res.each do |this_reg_play|
#    print "#{this_reg_play}\n\n"

    reg_play_array = [ this_reg_play['id'], this_reg_play['register_id'], this_reg_play['play_id'], this_reg_play['firstrun'], this_reg_play['newactor'], this_reg_play['actorrole'], this_reg_play['editor_flag'], this_reg_play['firstrun_perfnum'] ]

    print "#{reg_play_array}\n\n"

    conn_dev.exec('INSERT INTO register_plays (id, register_id, play_id, firstrun, newactor, actorrole, editor_flag, firstrun_perfnum) VALUES ($1, $2, $3, $4, $5, $6, $7, $8)', reg_play_array)
  end
else
  print "FAILURE\n"
end


#REGISTER_CONTRIBUTORS
#-note that 'tasks' have been moved to a separate table and are now referenced by id (task -> task_id)
#-also, contributor_id -> user_id

reg_contribs_select = "SELECT register_id, contributor_id FROM register_contributors"
res = conn.exec(reg_contribs_select)

if res.count > 0
  res.each do |this_reg_contrib|
#    print "#{this_reg_contrib}\n\n"

    reg_contrib_array = [ this_reg_contrib['register_id'], this_reg_contrib['contributor_id'], 1 ]

    print "#{reg_contrib_array}\n\n"

    conn_dev.exec('INSERT INTO register_contributors (register_id, user_id, task_id) VALUES ($1, $2, $3)', reg_contrib_array)
  end
else
  print "FAILURE\n"
end


#TICKET_SALES
#(same)

ticket_sales_select = "SELECT id, total_sold, register_id, seating_category_id, price_per_ticket_l, price_per_ticket_s, recorded_total_l, recorded_total_s, editor_flag FROM ticket_sales" 
res = conn.exec(ticket_sales_select)

if res.count > 0
  res.each do |this_ticket_sale|
#    print "#{this_ticket_sale}\n\n"

    ticket_sale_array = [ this_ticket_sale['id'], this_ticket_sale['total_sold'], this_ticket_sale['register_id'], this_ticket_sale['seating_category_id'], this_ticket_sale['price_per_ticket_l'], this_ticket_sale['price_per_ticket_s'], this_ticket_sale['recorded_total_l'], this_ticket_sale['recorded_total_s'], this_ticket_sale['editor_flag'] ]

    print "#{ticket_sale_array}\n\n"

    conn_dev.exec('INSERT INTO ticket_sales (id, total_sold, register_id, seating_category_id, price_per_ticket_l, price_per_ticket_s, recorded_total_l, recorded_total_s, editor_flag) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)', ticket_sale_array)
  end
else
  print "FAILURE\n"
end


__END__
