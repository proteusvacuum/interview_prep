class JuggleFestUtils
  
  def self.dot_product(a, b)
    sum = 0
    for i in (0...a.length)
      sum += a[i] * b[i]
    end
    sum
  end

  class JuggleFestFileReader
    attr_reader :circuits, :jugglers
    
    def initialize(file)
      @circuits = []
      @jugglers = []
      read_file(file)
    end

    def read_file(file)
      f = File.open(file)
      f.each_line do |line|
        line = line.split(" ")
        if line[0] == 'C'
          @circuits << Circuit.new(line)
        elsif line[0] == 'J'
          @jugglers << Juggler.new(line)
        end
      end
      f.close
    end
  end
  
end