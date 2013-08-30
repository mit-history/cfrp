# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

season_dirs = {
  'M119_02_R134' => '1769-1770',
  'M119_02_R135' => '1770-1771',
  'M119_02_R136' => '1771-1772',
  'M119_02_R137' => '1772-1773',
  'M119_02_R145' => '1780-1781',
  'M119_02_R146' => '1781-1782',
  'M119_02_R147' => '1782-1783',
  'M119_02_R148' => '1782-1783',
  'M119_02_R149' => '1783-1784',
  'M119_02_R150' => '1784-1785',
  'M119_02_R151' => '1785-1786',
  'M119_02_R152' => '1786-1787',
  'M119_02_R153' => '1787-1788',
  'M119_02_R154' => '1788-1789',
  'M119_02_R155' => '1789-1790',
  'M119_02_R156' => '1790-1791',
  'M119_02_R157' => '1791-1792',
  'M119_02_R158' => '1792-1793' }

root_path = '/Library/WebServer/Deployment/cfrp/public/images/jpeg-150-80/'
img_dirs = Dir.entries(root_path)

rp1 = RegisterPeriod.find_by_period('1769-1770')
rp2 = RegisterPeriod.find_by_period('1770 until 1782')
rp3 = RegisterPeriod.find_by_period('1782 until ...')

img_dirs.each do |d|
  if season_dirs.keys.detect {|sd| sd == d}
    years = season_dirs[d].split('-')

    register_period_id = rp2.id
    if season_dirs[d] == '1769-1770'
      register_period_id = rp1.id
    elsif years[1].to_i > 1783
      register_period_id = rp3.id
    end

    register = {
      :date => "#{years[0]}-01-01",
      :season => season_dirs[d],
      :register_period_id => register_period_id,
      :verification_state_id => VerificationState.find_by_name('unentered').id }
    Dir.entries("#{root_path}#{d}").each do |i|
      if i =~ /_(\d*)r\.jpg$/
        r = Register.create(register)
        # p register
        p r
        register_image_r = {
          :register_id => r.id,
          :filepath => "images/jpeg-150-80/#{d}/#{i}" }

        v_num = i.gsub(/_\d*r\.jpg$/, "_#{sprintf("%03d", $1.to_i + 1)}v.jpg")
        register_image_v = {
          :register_id => r.id,
          :filepath => "images/jpeg-150-80/#{d}/#{v_num}" }
        p register_image_r
        p register_image_v
        RegisterImage.create(register_image_r)
        RegisterImage.create(register_image_v)
      end
    end
  end
end
