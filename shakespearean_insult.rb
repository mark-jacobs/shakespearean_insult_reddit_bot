class ShakespeareanInsult
  def initialize
      # initialize arrays
      @first_array = []
      @second_array = []
      @third_array = []
      # get the file
      file = load_file
      parse_insults(file)
  end

  def insult
    return "thou #{@first_array.sample} #{@second_array.sample} #{@third_array.sample}"
  end

  private

    def load_file
      p file = File.open('shakespeare.text', "r")
    end

    def parse_insults(file)
      file.readlines.each do |line|
        words = line.split(" ")
        @first_array << words[0]
        @second_array << words[1]
        @third_array << words[2]
      end
      file.close
    end
end







