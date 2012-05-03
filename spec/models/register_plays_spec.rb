require 'spec_helper'

describe RegisterPlay do
  before :each do
    @register = Register.new( :register_num => 1, :date => '1750-01-01', :season => '1749-1750' )
    @play1 = Play.new( :author => 'Bob Smith', :title => 'Bob\'s First Play', :genre => 'tragedy' )
    @play2 = Play.new( :author => 'Bob Smith', :title => 'Bob\'s Second Play', :genre => 'comedy' )
  end

  it "saves associated model data automatically" do
    @rp = RegisterPlay.new(:ordering => 1 )
    @rp.register = @register
    @rp.play = @play1
    @rp.save
    @rp.play.title.should match('Bob\'s First Play')
    @rp.register.season.should match('1749-1750')
  end
end
