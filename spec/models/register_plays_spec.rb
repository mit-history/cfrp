require 'spec_helper'

describe RegisterPlay do
  before :each do
    @register = Register.new( :register_num => 1,
                              :date => '1750-01-01',
                              :season => '1749-1750' )

    @play1 = Play.new( :author => 'Bob Smith',
                       :title => 'Bob\'s First Play',
                       :genre => 'tragedy' )

    @play2 = Play.new( :author => 'Bob Smith',
                       :title => 'Bob\'s Second Play',
                       :genre => 'comedy' )

    # Want this one saved beforehand
    @play3 = Play.create( :author => 'Bill Jones',
                          :title => 'Bill\'s First Play',
                          :genre => 'tragedy' )

    @rp = RegisterPlay.new(:ordering => 1 )
    @rp.play = @play1
    @rp.register = @register
    @rp.save
  end

  it "sets ordering to 1 by default" do
    rp = RegisterPlay.new
    rp.ordering.should == 1
  end

  it "saves associated model data automatically" do
    @rp.play.title.should match('Bob\'s First Play')
    @rp.register.season.should match('1749-1750')
  end

  it "won't create a new play if the play already exists" do
    @rp.play_attributes = { 
      :author => 'Bill Jones',
      :title => 'Bill\'s First Play',
      :genre => 'tragedy'
    }
    @rp.save
    @rp.play.id.should == @play3.id
  end

  it "replaces its play with a new play if the play doesn't exist" do
    @rp.play_attributes = { 
      :author => 'Jenny Smith',
      :title => 'Jenny\'s Awesome Play',
      :genre => 'comedy'
    }
    @rp.save
    @rp.play.id.should_not == @play3.id
  end
end
