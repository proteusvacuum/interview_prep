Dir['./lib/*.rb'].each {|file| require file }
Dir['./models/*.rb'].each {|file| require file }
Dir['./controllers/*.rb'].each {|file| require file }

describe "JuggleFest 2" do

  describe "FileReader" do    
    class Circuit; end
    class Juggler; end

    before(:each) do
        Circuit.stub(:new)
        Juggler.stub(:new)
    end

    it "parses a file properly" do
      filename = "data1"
      num_circuts = 2000
      num_jugglers = 12000

      file = JuggleFestUtils::JuggleFestFileReader.new(filename)

      file.circuits.length.should be(num_circuts)
      file.jugglers.length.should be(num_jugglers)
    end

  end
  
  describe "Circuit" do
    it "should parse the attributes properly" do
      attrs = "C C1214 H:5 E:8 P:5".split(" ")
      skills = [5, 8, 5]
      
      c = Circuit.new(attrs)

      c.skills.should eql skills
      c.id.should eql 1214
    end

    it "should add a potential_juggler" do
      c = Circuit.new("C C1214 H:5 E:8 P:5".split(" "))
      j2 = Juggler.new("J J2157 H:5 E:8 P:5 C85,C1214,C701,C1831,C1935,C1750,C819,C1529,C1843,C1273".split(" "))
      j = Juggler.new("J J2156 H:1 E:5 P:9 C85,C1214,C701,C1831,C1935,C1750,C819,C1529,C1843,C1273".split(" "))      
      
      c.add_potential_juggler(j2)
      c.add_potential_juggler(j)
      
      jugglers = [{id: 2156, match:((1*5) + (8*5) + (5*9)) }, {id: 2157, match:((5*5) + (8*8) + (5*5)) }]
      jugglers_unsorted = [{id: 2157, match:((5*5) + (8*8) + (5*5)) }, {id: 2156, match:((1*5) + (8*5) + (5*9)) }]
      c.potential_jugglers.should eql(jugglers)
      c.potential_jugglers.should_not eql(jugglers_unsorted)
    end

    context "offers" do
      
      before do
        attrs = "J J1 H:1 E:5 P:9 C1214,C1215,C701,C1831,C1935,C1750,C819,C1529,C1843,C1273".split(" ")
        @j = Juggler.new(attrs)
        @j1 = Juggler.new("J J0 H:6 E:10 P:2 C1215,C1643,C380,C135,C273,C889,C1764,C574,C795,C1876".split(" "))
        
        @c = Circuit.new("C C1215 H:5 E:8 P:5".split(" "))
        @c.avail_positions = 1
        @c.add_potential_juggler(@j)
        @c.add_potential_juggler(@j1)
      end

      it "should make next offer" do
        @c.make_next_offer([@j, @j1])
        @c.offers.should eql [1]
        @c.potential_jugglers.last[:id].should eql 1
        @c.avail_positions.should eql 0
      end
    end
    
  end

  describe "Juggler" do
    it "should parse the attributes properly" do
      attrs = "J J2156 H:1 E:5 P:9 C85,C1207,C701,C1831,C1935,C1750,C819,C1529,C1843,C1273".split(" ")
      prefs = "85,1207,701,1831,1935,1750,819,1529,1843,1273".split(",").map(&:to_i)
      
      j = Juggler.new(attrs)

      j.preferences.should eql(prefs)
      j.id.should eql(2156)
    end

    it "computes match with preferred circuits" do
      c = double(
        id: 85,
        skills: [1,5,9]
      )

      attrs = "J J2156 H:1 E:5 P:9 C85,C1207,C701,C1831,C1935,C1750,C819,C1529,C1843,C1273".split(" ")
      j = Juggler.new(attrs)      

      match = (1*1) + (5*5) + (9*9)
      j.compute_match(c).should eql(match)
    end

    context "offers" do
      before do
        attrs = "J J2156 H:1 E:5 P:9 C1214,C1215,C701,C1831,C1935,C1750,C819,C1529,C1843,C1273".split(" ")
        @j = Juggler.new(attrs)
        @c = Circuit.new("C C1215 H:5 E:8 P:5".split(" "))
        @c.avail_positions = 1
        @c2 = Circuit.new("C C1214 H:1 E:5 P:9".split(" "))
      end
      
      it "should accept an offer" do
        @j.committed.should be_false
        @j.make_offer(@c)
        @j.current_offer.should eql @c
        @j.committed.should be_true
      end

      it "should accept a better offer" do
        @j.current_offer = @c
        @j.committed = true
        @j.make_offer(@c2)
        @j.current_offer.should eql @c2
        @c.avail_positions.should eql 2
      end

      it "should decline a worse offer" do
        @j.current_offer = @c2
        @j.committed = true
        @j.make_offer(@c).should eql :declined
        @j.current_offer.should eql @c2
      end

    end
  end

  describe "JuggleFestMatcher" do
    let(:jfm) {JuggleFestMatcher.new}
    
    before do
      jfm.parse_input("data")      
    end

    it "adds jugglers to circuits" do
      potential_jugglers = [{:id=>2, :match=>68}, {:id=>1, :match=>74}, {:id=>7, :match=>75}, {:id=>8, :match=>80}, {:id=>0, :match=>83}, {:id=>9, :match=>86}, {:id=>10, :match=>86}, {:id=>4, :match=>106}, {:id=>11, :match=>108}, {:id=>5, :match=>112}, {:id=>3, :match=>120}, {:id=>6, :match=>128}]

      jfm.add_jugglers_to_circuits
      jfm.circuits.last.potential_jugglers.should eql potential_jugglers
    end

    it "makes offers" do
      expected_offers = [[5, 11, 2, 4], [9, 8, 7, 1], [6, 3, 10, 0]]
      jfm.add_jugglers_to_circuits
      jfm.make_offers
      jfm.circuits.map(&:offers).should eql expected_offers
    end
  end
end